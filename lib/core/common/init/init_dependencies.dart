// import 'package:app/core/secrets/app_secrets.dart';
// import 'package:app/feature/auth/data/datasources/auth_remote_datasourece.dart';
// import 'package:app/feature/auth/data/repository/auth_repository_impl.dart';
// import 'package:app/feature/auth/domain/repository/auth_repository.dart';
// import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
// import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
// import 'package:get_it/get_it.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// final sl = GetIt.instance;

// Future<void> initDependencies() async {
//   // External
//   await Supabase.initialize(
//     url: AppSecrets.supabaseUrl,
//     anonKey: AppSecrets.supabaseAnonKey,
//   );
//   sl.registerLazySingleton(() => Supabase.instance.client);

//   // DataSource
//   sl.registerLazySingleton<AuthRemoteDataSource>(
//     () => AuthRemoteDataSourceImpl(sl()),
//   );

//   // Repository
//   sl.registerLazySingleton<AuthRepository>(
//     () => AuthRepositoryImpl(sl()),
//   );

//   // UseCases
//   sl.registerLazySingleton(() => SignUpWithEmailPassword(sl()));
//   sl.registerLazySingleton(() => LoginWithEmailPassword(sl()));
//   sl.registerLazySingleton(() => CurrentUserData(sl()));
//   sl.registerLazySingleton(() => Logout(sl()));

//   // Bloc
//   sl.registerFactory(() => AuthBloc(
//         signUp: sl(),
//         login: sl(),
//         currentUser: sl(),
//         logout: sl(),
//       ));
// }
import 'package:app/core/common/init/init_lesson_dependnecies.dart';
import 'package:app/core/common/init/init_profile_dependencies.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/secrets/app_secrets.dart';

// сюда добавим позже другие features (например, profile)
import 'package:app/core/common/init/init_auth_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External: Supabase
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  sl.registerLazySingleton(() => Supabase.instance.client);

  // Инициализация зависимостей каждой feature
  await initAuthDependencies();
  await initProfileDependencies(); // подключим позже
  await initLessonDependencies(); // ✅ lessons
}
