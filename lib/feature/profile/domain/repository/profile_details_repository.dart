import 'package:app/core/error/failure.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

// abstract interface class ProfileRepository {
//   Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails();
//   Future<Either<Failure, Unit>> updateProfileDetails(
//       UserProfileDetailsEntity entity);
//   Future<Either<Failure, Unit>> clearProfileDetails();
//   Future<Either<Failure, Unit>> markLessonAsCompleted(String lessonId);
//   Future<Either<Failure, Unit>> addQuizResult({
//     required String lessonId,
//     required int correctAnswers,
//     required int totalQuestions,
//   });
// }
abstract interface class ProfileRepository {
  Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails();
  Future<Either<Failure, Unit>> updateProfileDetails(
      UserProfileDetailsEntity entity);
  Future<Either<Failure, Unit>> clearProfileDetails();
  Future<Either<Failure, Unit>> addQuizResult({
    required String lessonId,
    required int correctAnswers,
    required int totalQuestions,
    required BuildContext context,
  });
  Future<Either<Failure, Unit>> updateErrorProgress({
    required String lessonId,
    required int questionIndex,
    required bool isCorrect,
  });
  Future<Either<Failure, Unit>> completeErrorQuiz({
    required int correctAnswers,
  });
}
