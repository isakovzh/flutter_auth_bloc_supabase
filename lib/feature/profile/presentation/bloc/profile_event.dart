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

// ✅ Новый event для отметки урока как завершённого
class MarkLessonCompletedEvent extends ProfileEvent {
  final String lessonId;

  const MarkLessonCompletedEvent(this.lessonId);
}
