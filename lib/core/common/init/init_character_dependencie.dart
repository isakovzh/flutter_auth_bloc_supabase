import 'package:app/feature/characters/data/datasource/character_local_datasource.dart';
import 'package:app/feature/characters/data/model/character_model.dart';
import 'package:app/feature/characters/data/repository/character_repository_impl.dart';
import 'package:app/feature/characters/domain/repository/character_repository.dart';
import 'package:app/feature/characters/domain/usecase/character_usecases.dart';
import 'package:app/feature/characters/presentation/bloc/character_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final sl = GetIt.instance;

Future<void> initCharacterDependencies() async {
  try {
    // 🧠 Register Hive Adapter
    if (!Hive.isAdapterRegistered(CharacterModelAdapter().typeId)) {
      Hive.registerAdapter(CharacterModelAdapter());
    }

    // 📥 DataSource
    if (!sl.isRegistered<CharacterLocalDataSource>()) {
      sl.registerLazySingleton<CharacterLocalDataSource>(
        () => CharacterLocalDataSourceImpl(),
      );
    }

    // 🧠 Repository
    if (!sl.isRegistered<CharacterRepository>()) {
      sl.registerLazySingleton<CharacterRepository>(
        () => CharacterRepositoryImpl(
          sl<CharacterLocalDataSource>(),
          sl(),
        ),
      );
    }

    // ✅ Use Cases
    if (!sl.isRegistered<GetAllCharactersUseCase>()) {
      sl.registerLazySingleton(() => GetAllCharactersUseCase(sl()));
      sl.registerLazySingleton(() => UnlockCharacterUseCase(sl()));
      sl.registerLazySingleton(() => InitCharactersUseCase(sl()));
    }

    // 🎯 Bloc
    sl.registerFactory(() => CharacterBloc(
          getAllCharacters: sl(),
          unlockCharacter: sl(),
          initCharacters: sl(),
        ));
  } catch (e, stackTrace) {
    print('Error initializing character dependencies: $e');
    print('Stack trace: $stackTrace');
    // Don't rethrow - allow the app to continue even if character init fails
  }
}
