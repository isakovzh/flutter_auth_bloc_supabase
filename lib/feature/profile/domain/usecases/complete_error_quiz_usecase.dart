import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:fpdart/fpdart.dart';

class CompleteErrorQuizUseCase implements Usecase<Unit, int> {
  final ProfileRepository repository;

  CompleteErrorQuizUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(int correctAnswers) {
    return repository.completeErrorQuiz(correctAnswers: correctAnswers);
  }
}
