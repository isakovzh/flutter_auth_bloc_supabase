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
  // 🧠 Адаптер Hive
  if (!Hive.isAdapterRegistered(CharacterModelAdapter().typeId)) {
    Hive.registerAdapter(CharacterModelAdapter());
  }

  // 📦 Hive Box
  // final box = await Hive.openBox<CharacterModel>('charactersBox');

  // 🧩 Supabase client
  final supabaseClient = Supabase.instance.client;
  final userId = supabaseClient.auth.currentUser?.id;

  if (userId == null) {
    throw Exception('User is not logged in');
  }

  // 📥 DataSource
  final characterLocalDataSource = CharacterLocalDataSourceImpl();
  sl.registerLazySingleton<CharacterLocalDataSource>(
      () => characterLocalDataSource);

  // 🧠 Repository
  sl.registerLazySingleton<CharacterRepository>(
    () => CharacterRepositoryImpl(sl(), sl()),
  );

  // ✅ Use Cases
  sl.registerLazySingleton(() => GetAllCharactersUseCase(sl()));
  sl.registerLazySingleton(() => UnlockCharacterUseCase(sl()));
  sl.registerLazySingleton(() => InitCharactersUseCase(sl()));

  // 🎯 Bloc
  sl.registerFactory(() => CharacterBloc(
        getAllCharacters: sl(),
        unlockCharacter: sl(),
        initCharacters: sl(),
      ));
}
