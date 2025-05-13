import 'package:app/feature/characters/data/datasource/character_local_datasource.dart';
import 'package:app/feature/characters/data/model/character_model.dart';
import 'package:app/feature/characters/data/repository/character_repository_impl.dart';
import 'package:app/feature/characters/domain/repository/character_repository.dart';
import 'package:app/feature/characters/domain/usecase/character_usecases.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initCharacterDependencies() async {
  if (!Hive.isAdapterRegistered(CharacterModelAdapter().typeId)) {
    Hive.registerAdapter(CharacterModelAdapter());
  }

  final user = Supabase.instance.client.auth.currentUser;
  final userId = user?.id ?? 'guest';

  final boxName = 'charactersBox_$userId';
  final box = await Hive.openBox<CharacterModel>(boxName);
  

  final characterLocalDataSource = CharacterLocalDataSourceImpl(box);
  await characterLocalDataSource.init();

  sl.registerLazySingleton<CharacterLocalDataSource>(
      () => characterLocalDataSource);
  sl.registerLazySingleton<CharacterRepository>(
      () => CharacterRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetAllCharactersUseCase(sl()));
  sl.registerLazySingleton(() => UnlockCharacterUseCase(sl()));

  sl.registerFactory(() => CharacterBloc(
        getAllCharacters: sl(),
        unlockCharacter: sl(),
      ));
}
