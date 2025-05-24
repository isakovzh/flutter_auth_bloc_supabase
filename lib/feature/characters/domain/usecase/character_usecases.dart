import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:app/feature/characters/domain/repository/character_repository.dart';

class GetAllCharactersUseCase {
  final CharacterRepository repository;
  GetAllCharactersUseCase(this.repository);
  Future<List<CharacterEntity>> call() => repository.getAllCharacters();
}

class UnlockCharacterUseCase {
  final CharacterRepository repository;
  UnlockCharacterUseCase(this.repository);
  Future<void> call(String id) => repository.unlockCharacter(id);
}

class InitCharactersUseCase {
  final CharacterRepository repository;

  InitCharactersUseCase(this.repository);

  Future<void> call(String languageCode) async {
    await repository.initCharacters(languageCode);
  }
}
