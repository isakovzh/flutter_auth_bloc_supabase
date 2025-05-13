import 'dart:convert';
import 'package:app/feature/characters/data/model/character_model.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';

abstract class CharacterLocalDataSource {
  Future<void> init(String userId); // ✅ передаём userId при инициализации
  Future<List<CharacterModel>> getAllCharacters(String userId);
  Future<void> unlockCharacter(String id, String userId);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  static const _boxName = 'charactersBox';

  @override
  Future<void> init(String userId) async {
    final box = await Hive.openBox<CharacterModel>(_boxName);

    // Если в box ещё нет данных текущего пользователя
    final hasUserData = box.values.any((char) => char.userId == userId);

    if (!hasUserData) {
      final jsonString = await rootBundle.loadString('assets/json/characters.json');
      final List decoded = json.decode(jsonString);

      final characters = decoded.map((e) => CharacterModel.fromJson(e, userId)).toList();
      for (final char in characters) {
        await box.put('${userId}_${char.id}', char); // ✅ ключ включает userId
      }
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
