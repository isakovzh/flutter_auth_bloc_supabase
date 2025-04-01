import 'package:app/core/secrets/app_secrets.dart';
import 'package:app/feature/auth/data/datasources/auth_remote_datasourece.dart';
import 'package:app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/profile/data/datasource/proflie_remote_datasource.dart';
import 'package:app/feature/profile/data/repositories/profile_deteils_repository_impl.dart';
import 'package:app/feature/profile/domain/repositories/profile_deteils_repository.dart';
import 'package:app/feature/profile/domain/usecases/get_profile_detelis.dart';
import 'package:app/feature/profile/domain/usecases/update_profile_deteils.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  // External
  await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonKey,
  );
  sl.registerLazySingleton(() => Supabase.instance.client);

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl()),
  );



  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl()),
  );

  // UseCases
  sl.registerLazySingleton(() => SignUpWithEmailPassword(sl()));
  sl.registerLazySingleton(() => LoginWithEmailPassword(sl()));
  sl.registerLazySingleton(() => CurrentUserData(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Bloc
  sl.registerFactory(() => AuthBloc(
        signUp: sl(),
        login: sl(),
        currentUser: sl(),
        logout: sl(),
      ));

  // Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl()),
  );

  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetProfileDetails(sl()));
  sl.registerLazySingleton(() => UpdateProfileDetails(sl()));

  sl.registerFactory(() => ProfileBloc(
        getProfileDetails: sl(),
        updateProfileDetails: sl(),
      ));
}
