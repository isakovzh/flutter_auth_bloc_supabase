import 'package:app/feature/characters/domain/entity/characters.dart';

abstract class CharacterRepository {
  Future<void> initCharacters(String languageCode);
  Future<List<CharacterEntity>> getAllCharacters();
  Future<void> unlockCharacter(String id);
}
