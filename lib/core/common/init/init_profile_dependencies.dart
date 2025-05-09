import 'package:app/feature/profile/data/model/quiz_result_entry.dart';
import 'package:app/feature/profile/data/repository/proflie_repository_impl.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:app/feature/profile/domain/usecases/add_quiz_result.dart';
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
  // Регистрируем Hive-адаптеры (только один раз)
  if (!Hive.isAdapterRegistered(UserProfileDetailsModelAdapter().typeId)) {
    Hive.registerAdapter(UserProfileDetailsModelAdapter());
    Hive.registerAdapter(QuizResultEntryAdapter());
    
    
  }

  // ❗ Используй одно и то же имя бокса ВЕЗДЕ:
  final box = await Hive.openBox<UserProfileDetailsModel>('profileBox');
  

  // ✅ УБЕРИ очистку, чтобы не терять данные:
  // if (await Hive.boxExists('profileBox')) {
  //   var box = await Hive.openBox<UserProfileDetailsModel>('profileBox');
  //   await box.clear();
  //   await box.close();
  // }

  // Data Source
  sl.registerLazySingleton<ProfileLocalDataSource>(
    () => ProfileLocalDataSourceImpl(box),
  );

  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(
      sl(), // localDataSource
      sl(), // supabase
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProfileDetails(sl()));
  sl.registerLazySingleton(() => UpdateProfileDetails(sl()));
  sl.registerLazySingleton(() => ClearProfileDetails(sl()));
  sl.registerLazySingleton(() => AddQuizResultUseCase(sl()));

  // Bloc
  sl.registerFactory(() => ProfileBloc(
        getProfileDetails: sl(),
        updateProfileDetails: sl(),
        clearProfileDetails: sl(),
        addQuizResult: sl(),
      ));
}
