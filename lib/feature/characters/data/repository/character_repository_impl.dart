import 'package:app/feature/characters/data/datasource/character_local_datasource.dart';
import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:app/feature/characters/domain/repository/character_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CharacterRepositoryImpl implements CharacterRepository {
  final CharacterLocalDataSource localDataSource;
  final SupabaseClient supabaseClient;

  CharacterRepositoryImpl(this.localDataSource, this.supabaseClient);

  String get _userId {
    final user = supabaseClient.auth.currentUser;
    if (user == null) {
      throw Exception('Пользователь не авторизован');
    }
    return user.id;
  }

  @override
  Future<void> initCharacters(String languageCode) async {
    await localDataSource.init(_userId, languageCode);
  }

  @override
  Future<List<CharacterEntity>> getAllCharacters() async {
    final models = await localDataSource.getAllCharacters(_userId);
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> unlockCharacter(String id) async {
    await localDataSource.unlockCharacter(id, _userId);
  }
}
