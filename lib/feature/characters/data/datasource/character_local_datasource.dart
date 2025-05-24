import 'dart:convert';
import 'package:app/feature/characters/data/model/character_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

abstract class CharacterLocalDataSource {
  Future<void> init(String userId, String languageCode);
  Future<List<CharacterModel>> getAllCharacters(String userId);
  Future<void> unlockCharacter(String id, String userId);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const _boxName = 'charactersBox';
  String? _currentLanguage;

  @override
  Future<void> init(String userId, String languageCode) async {
    final box = await Hive.openBox<CharacterModel>(_boxName);

    // Check if we have existing data for this user
    final existingCharacters =
        box.values.where((char) => char.userId == userId).toList();
    final hasExistingData = existingCharacters.isNotEmpty;

    // Store existing unlocked states
    Map<String, bool> unlockedStates = {};
    for (var char in existingCharacters) {
      if (char.isUnlocked) {
        unlockedStates[char.id] = true;
      }
    }

    // Only reload characters if:
    // 1. Language has changed and is different from current
    // 2. OR we have no data for this user
    if ((_currentLanguage != null && _currentLanguage != languageCode) ||
        !hasExistingData) {
      try {
        // Try to load from localized path
        String jsonString;
        try {
          jsonString = await rootBundle
              .loadString('assets/json/locales/$languageCode/characters.json');
        } catch (e) {
          // If localized file doesn't exist, fall back to the original characters.json
          jsonString =
              await rootBundle.loadString('assets/json/characters.json');
        }

        final List decoded = json.decode(jsonString);
        final characters = decoded.map((e) {
          var char = CharacterModel.fromJson(e, userId);
          // Restore unlocked state if it was previously unlocked
          if (unlockedStates.containsKey(char.id)) {
            char = char.copyWith(isUnlocked: true);
          }
          return char;
        }).toList();

        // Clear existing data for this user
        final userKeys =
            box.keys.where((key) => key.toString().startsWith('${userId}_'));
        await Future.forEach(userKeys, (key) async {
          await box.delete(key);
        });

        // Save the characters to the box
        await Future.forEach(characters, (CharacterModel char) async {
          await box.put('${userId}_${char.id}', char);
        });

        _currentLanguage = languageCode;
      } catch (e) {
        print('Failed to load characters: $e');
        // If we have existing data, don't throw - just keep using it
        if (!hasExistingData) {
          throw Exception('Failed to load characters from any location');
        }
      }
    } else {
      // If we're not reloading, just update the current language
      _currentLanguage = languageCode;
    }
  }

  @override
  Future<List<CharacterModel>> getAllCharacters(String userId) async {
    final box = await Hive.openBox<CharacterModel>(_boxName);
    return box.values.where((char) => char.userId == userId).toList();
  }

  @override
  Future<void> unlockCharacter(String id, String userId) async {
    final box = await Hive.openBox<CharacterModel>(_boxName);
    final key = '${userId}_$id';
    final character = box.get(key);

    if (character != null && !character.isUnlocked) {
      final updated = character.copyWith(isUnlocked: true);
      await box.put(key, updated);
    }
  }
}
