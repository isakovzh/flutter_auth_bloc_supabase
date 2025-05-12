import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class CompleteErrorQuizUseCase
    implements Usecase<Unit, CompleteErrorQuizParams> {
  final ProfileRepository repository;

  CompleteErrorQuizUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(CompleteErrorQuizParams params) {
    return repository.completeErrorQuiz(
      context: params.context,
      correctAnswers: params.correctAnswers,
    );
  }
}

class CompleteErrorQuizParams {
  final int correctAnswers;
  final BuildContext context;

  CompleteErrorQuizParams({
    required this.correctAnswers,
    required this.context,
  });
}
