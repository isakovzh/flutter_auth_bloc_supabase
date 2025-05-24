import 'package:get_it/get_it.dart';
import 'package:app/feature/auth/data/datasources/auth_remote_datasourece.dart';
import 'package:app/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
import 'package:app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';

final sl = GetIt.instance;

Future<void> initAuthDependencies() async {
  try {
    // DataSource
    if (!sl.isRegistered<AuthRemoteDataSource>()) {
      sl.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl(sl()),
      );
    }

    // Repository
    if (!sl.isRegistered<AuthRepository>()) {
      sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl()),
      );
    }

    // UseCases
    if (!sl.isRegistered<SignUpWithEmailPassword>()) {
      sl.registerLazySingleton(() => SignUpWithEmailPassword(sl()));
      sl.registerLazySingleton(() => LoginWithEmailPassword(sl()));
      sl.registerLazySingleton(() => CurrentUserData(sl()));
      sl.registerLazySingleton(() => Logout(sl()));
    }

    // Bloc
    sl.registerFactory(() {
      // Try to get ProfileRepository if it's registered
      ProfileRepository? profileRepository;
      try {
        profileRepository = sl<ProfileRepository>();
      } catch (_) {
        print(
            'ProfileRepository not available yet - AuthBloc will initialize without it');
      }

      return AuthBloc(
        signUp: sl(),
        login: sl(),
        currentUser: sl(),
        logout: sl(),
        profileRepository: profileRepository,
      );
    });
  } catch (e, stackTrace) {
    print('Error initializing auth dependencies: $e');
    print('Stack trace: $stackTrace');
    rethrow;
  }
}
