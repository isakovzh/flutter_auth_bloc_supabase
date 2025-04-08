import 'package:get_it/get_it.dart';
import 'package:app/feature/auth/data/datasources/auth_remote_datasourece.dart';
import 'package:app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> initAuthDependencies() async {
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
        profileRepository: sl(),
      ));
}
