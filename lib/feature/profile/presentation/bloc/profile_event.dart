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

  const AddQuizResultEvent({
    required this.lessonId,
    required this.correctAnswers,
    required this.totalQuestions,
  });
}
