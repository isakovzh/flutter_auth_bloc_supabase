import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/feature/lesson/domain/usecases/get_all_lessons.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetAllLessonsUseCase getAllLessons;

  LessonBloc({required this.getAllLessons}) : super(LessonInitial()) {
    on<LoadLessonsEvent>(_onLoadLessons);
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());

    final Either<Failure, List<LessonEntity>> result =
        await getAllLessons(NoParams());

    result.match(
      (failure) => emit(LessonError(failure.message)),
      (lessons) => emit(LessonLoaded(lessons)),
    );
  }
}
 