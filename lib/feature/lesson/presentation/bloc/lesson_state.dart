import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:equatable/equatable.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonLoaded extends LessonState {
  final List<LessonEntity> lessons;

  const LessonLoaded(this.lessons);

  @override
  List<Object?> get props => [lessons];
}

class LessonCompleted extends LessonState {
  final String lessonId;

  const LessonCompleted(this.lessonId);
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}
