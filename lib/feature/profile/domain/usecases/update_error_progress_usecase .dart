import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateErrorProgressUseCase
    implements Usecase<Unit, UpdateErrorProgressParams> {
  final ProfileRepository repository;

  UpdateErrorProgressUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UpdateErrorProgressParams params) {
    return repository.updateErrorProgress(
      lessonId: params.lessonId,
      questionIndex: params.questionIndex,
      isCorrect: params.isCorrect,
    );
  }
}

class UpdateErrorProgressParams {
  final String lessonId;
  final int questionIndex;
  final bool isCorrect;

  UpdateErrorProgressParams({
    required this.lessonId,
    required this.questionIndex,
    required this.isCorrect,
  });
}
