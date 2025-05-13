// lib/feature/profile/presentation/bloc/profile_event.dart

part of 'profile_bloc.dart';

abstract class ProfileEvent {
  const ProfileEvent();
}

class GetProfileDetailsEvent extends ProfileEvent {
  const GetProfileDetailsEvent();
}

class UpdateProfileDetailsEvent extends ProfileEvent {
  final UserProfileDetailsEntity profile;

  const UpdateProfileDetailsEvent(this.profile);
}

class ClearProfileDetailsEvent extends ProfileEvent {
  const ClearProfileDetailsEvent();
}

class AddQuizResultEvent extends ProfileEvent {
  final String lessonId;
  final int correctAnswers;
  final int totalQuestions;
  final BuildContext context;

  const AddQuizResultEvent({
    required this.lessonId,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.context,
  });
}

class UpdateErrorProgressEvent extends ProfileEvent {
  final String lessonId;
  final int questionIndex;
  final bool isCorrect;

  const UpdateErrorProgressEvent({
    required this.lessonId,
    required this.questionIndex,
    required this.isCorrect,
  });
}

class CompleteErrorQuizEvent extends ProfileEvent {
  final int correctAnswers;
  final BuildContext context;

  const CompleteErrorQuizEvent({
    required this.correctAnswers,
    required this.context,
  });
}

class AddXPEvent extends ProfileEvent {
  final int xp;
  const AddXPEvent(this.xp);
}
