import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class AddQuizResultUseCase implements Usecase<Unit, AddQuizResultParams> {
  final ProfileRepository repository;

  AddQuizResultUseCase(this.repository);

  @override
  Future<Either<Failure, Unit>> call(AddQuizResultParams params) {
    return repository.addQuizResult(
        lessonId: params.lessonId,
        correctAnswers: params.correctAnswers,
        totalQuestions: params.totalQuestions,
        context: params.context);
  }
}

class AddQuizResultParams {
  final String lessonId;
  final int correctAnswers;
  final int totalQuestions;
  final BuildContext context;

  AddQuizResultParams({
    required this.lessonId,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.context,
  });
}
