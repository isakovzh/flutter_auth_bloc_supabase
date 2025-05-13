import 'package:app/feature/characters/data/datasource/character_local_datasource.dart';
import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:app/feature/characters/domain/repository/character_repository.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterLocalDataSource localDataSource;

  CharacterRepositoryImpl(this.localDataSource);

  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    final models = await localDataSource.getAllCharacters();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<void> unlockCharacter(String id) async {
    await localDataSource.unlockCharacter(id);
  }
}
