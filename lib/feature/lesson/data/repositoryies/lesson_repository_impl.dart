import 'package:app/core/error/failure.dart';
import 'package:app/feature/lesson/data/datasources/local_lesson_datasource.dart';
import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/lesson/domain/repository/lesson_repository.dart';
import 'package:fpdart/fpdart.dart';

class LessonRepositoryImpl implements LessonRepository {
  final LessonLocalDataSource localDataSource;

  LessonRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<LessonEntity>>> getAllLessons() async {
    try {
      final lessons = await localDataSource.loadLessons();
      return Right(lessons);
    } catch (e) {
      return Left(Failure('Failed to load lessons: ${e.toString()}'));
    }
  }
}
