import 'dart:convert';
import 'package:app/feature/characters/data/model/character_model.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class CharacterLocalDataSource {
  Future<void> init();
  Future<List<CharacterModel>> getAllCharacters();
  Future<void> unlockCharacter(String id);
}

class CharacterLocalDataSourceImpl implements CharacterLocalDataSource {
  final Box<CharacterModel> box;

  CharacterLocalDataSourceImpl(this.box);

  @override
  Future<void> init() async {
    if (box.isEmpty) {
      final data = await rootBundle.loadString('assets/json/characters.json');
      final List decoded = json.decode(data);
      final characters =
          decoded.map((e) => CharacterModel.fromJson(e)).toList();

      for (final character in characters) {
        await box.put(character.id, character);
      }
    }
  }

  @override
  Future<List<CharacterModel>> getAllCharacters() async {
    return box.values.toList();
  }

  @override
  Future<void> unlockCharacter(String id) async {
    final character = box.get(id);
    if (character != null && !character.isUnlocked) {
      final updated = character.copyWith(isUnlocked: true);
      await box.put(id, updated);
    }
  }
}
