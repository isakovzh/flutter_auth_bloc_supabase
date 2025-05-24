import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app/core/error/failure.dart';

abstract interface class LessonRepository {
  Future<Either<Failure, List<LessonEntity>>> getAllLessons(
      String languageCode);
}
