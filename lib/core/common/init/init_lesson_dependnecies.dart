import 'package:app/feature/lesson/data/datasources/local_lesson_datasource.dart';
import 'package:app/feature/lesson/data/repositoryies/lesson_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:app/core/theme/language_cubit.dart';

import 'package:app/feature/lesson/domain/repository/lesson_repository.dart';
import 'package:app/feature/lesson/domain/usecases/get_all_lessons.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_bloc.dart';

final sl = GetIt.instance;

Future<void> initLessonDependencies() async {
  // Data Source
  sl.registerLazySingleton<LessonLocalDataSource>(
    () => LessonLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<LessonRepository>(
    () => LessonRepositoryImpl(sl()),
  );

  // Use Case
  sl.registerLazySingleton(() => GetAllLessonsUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () => LessonBloc(
      getAllLessons: sl(),
      languageCubit: sl<LanguageCubit>(),
    ),
  );
}
