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
import 'package:app/core/common/init/init_character_dependencie.dart';
import 'package:app/core/common/init/init_lesson_dependnecies.dart';
import 'package:app/core/common/init/init_profile_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/core/secrets/app_secrets.dart';
import 'package:app/core/common/init/init_auth_dependencies.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  try {
    // Initialize Hive first
    await Hive.initFlutter();

    // External: Supabase
    await Supabase.initialize(
      url: AppSecrets.supabaseUrl,
      anonKey: AppSecrets.supabaseAnonKey,
    );

    // Register Supabase client
    if (!sl.isRegistered<SupabaseClient>()) {
      sl.registerLazySingleton(() => Supabase.instance.client);
    }

    // Initialize dependencies sequentially to avoid conflicts
    await initCharacterDependencies().catchError((e) {
      print('Error initializing character dependencies: $e');
    });

    await initLessonDependencies().catchError((e) {
      print('Error initializing lesson dependencies: $e');
    });

    await initAuthDependencies().catchError((e) {
      debugPrint('Error initializing auth dependencies: $e');
    });

    // Initialize profile dependencies only if auth is ready
    try {
      await initProfileDependencies();
    } catch (e) {
      print('Error initializing profile dependencies: $e');
      // Profile initialization can fail if user is not logged in
    }
  } catch (e, stackTrace) {
    print('Error during dependency initialization: $e');
    print('Stack trace: $stackTrace');
    // Continue with app initialization even if there's an error
  }
}
