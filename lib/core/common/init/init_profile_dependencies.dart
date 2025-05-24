import 'package:app/feature/profile/data/model/quiz_result_entry.dart';
import 'package:app/feature/profile/data/repository/proflie_repository_impl.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:app/feature/profile/domain/usecases/add_quiz_result.dart';
import 'package:app/feature/profile/domain/usecases/clear_proflie_deteils.dart';
import 'package:app/feature/profile/domain/usecases/complete_error_quiz_usecase.dart';
import 'package:app/feature/profile/domain/usecases/get_proflie_deteild.dart';
import 'package:app/feature/profile/domain/usecases/update_error_progress_usecase%20.dart';
import 'package:app/feature/profile/domain/usecases/update_proflie_details.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:app/feature/profile/data/datacources/profile_local_datasource.dart';
import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';

final sl = GetIt.instance;

Future<void> initProfileDependencies() async {
  try {
    // Register Hive adapters
    if (!Hive.isAdapterRegistered(UserProfileDetailsModelAdapter().typeId)) {
      Hive.registerAdapter(UserProfileDetailsModelAdapter());
      Hive.registerAdapter(QuizResultEntryAdapter());
    }

    // Open Hive box
    final box = await Hive.openBox<UserProfileDetailsModel>('profileBox');

    // Always register the basic profile dependencies
    if (!sl.isRegistered<ProfileLocalDataSource>()) {
      // Data Source
      sl.registerLazySingleton<ProfileLocalDataSource>(
        () => ProfileLocalDataSourceImpl(box),
      );

      // Repository (with empty implementation if not logged in)
      sl.registerLazySingleton<ProfileRepository>(
        () => ProfileRepositoryImpl(
          sl<ProfileLocalDataSource>(),
          sl<SupabaseClient>(),
        ),
      );
    }

    // Check if user is logged in before registering full profile features
    final supabaseClient = sl<SupabaseClient>();
    if (supabaseClient.auth.currentUser != null) {
      // Register full profile features
      if (!sl.isRegistered<GetProfileDetails>()) {
        // Use Cases
        sl.registerLazySingleton(() => GetProfileDetails(sl()));
        sl.registerLazySingleton(() => UpdateProfileDetails(sl()));
        sl.registerLazySingleton(() => ClearProfileDetails(sl()));
        sl.registerLazySingleton(() => AddQuizResultUseCase(sl()));
        sl.registerLazySingleton(() => UpdateErrorProgressUseCase(sl()));
        sl.registerLazySingleton(() => CompleteErrorQuizUseCase(sl()));

        // Bloc
        sl.registerFactory(() => ProfileBloc(
              getProfileDetails: sl(),
              updateProfileDetails: sl(),
              clearProfileDetails: sl(),
              addQuizResult: sl(),
              updateErrorProgress: sl(),
              completeErrorQuiz: sl(),
              profileRepository: sl(),
            ));
      }
    } else {
      print('Skipping full profile initialization - user not logged in');
    }
  } catch (e, stackTrace) {
    print('Error initializing profile dependencies: $e');
    print('Stack trace: $stackTrace');
    // Don't rethrow - allow the app to continue even if profile init fails
  }
}
