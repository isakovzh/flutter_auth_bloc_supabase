import 'package:app/feature/profile/data/repository/proflie_repository_impl.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:app/feature/profile/domain/usecases/clear_proflie_deteils.dart';
import 'package:app/feature/profile/domain/usecases/get_proflie_deteild.dart';
import 'package:app/feature/profile/domain/usecases/update_proflie_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import 'package:app/feature/profile/data/datacources/profile_local_datasource.dart';
import 'package:app/feature/profile/data/model/user_profile_details_model.dart';

import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;
Future<void> initProfileDependencies() async {
  // Регистрируем Hive-адаптер (один раз)
  if (!Hive.isAdapterRegistered(UserProfileDetailsModelAdapter().typeId)) {
    Hive.registerAdapter(UserProfileDetailsModelAdapter());
  }

  final box = await Hive.openBox<UserProfileDetailsModel>('user_profile');

  // Data Source
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(box),
  );

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProfileDetails(sl()));
  sl.registerLazySingleton(() => UpdateProfileDetails(sl()));
  sl.registerLazySingleton(() => ClearProfileDetails(sl()));

  // Bloc
  sl.registerFactory(() => ProfileBloc(
        getProfileDetails: sl(),
        updateProfileDetails: sl(),
        clearProfileDetails: sl(),
      ));
}
