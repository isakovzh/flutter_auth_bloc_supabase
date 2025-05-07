import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonsEvent extends LessonEvent {}

class CompleteLessonEvent extends LessonEvent {
  final String lessonId;

  const CompleteLessonEvent(this.lessonId);
}
