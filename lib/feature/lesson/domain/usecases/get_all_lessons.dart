import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/lesson/domain/repository/lesson_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllLessonsUseCase implements Usecase<List<LessonEntity>, String> {
  final LessonRepository repository;

  GetAllLessonsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LessonEntity>>> call(String languageCode) {
    return repository.getAllLessons(languageCode);
  }
}
