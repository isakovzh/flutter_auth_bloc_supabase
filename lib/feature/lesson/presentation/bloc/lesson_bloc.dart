// lib/feature/lesson/presentation/bloc/lesson_bloc.dart

import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/feature/lesson/domain/usecases/get_all_lessons.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetAllLessonsUseCase getAllLessons;
  final LanguageCubit languageCubit;
  late final StreamSubscription<Locale> _languageSubscription;

  LessonBloc({
    required this.getAllLessons,
    required this.languageCubit,
  }) : super(LessonInitial()) {
    on<LoadLessonsEvent>(_onLoadLessons);

    // Listen to language changes
    _languageSubscription = languageCubit.stream.listen((_) {
      add(LoadLessonsEvent());
    });
  }

  Future<void> _onLoadLessons(
    LoadLessonsEvent event,
    Emitter<LessonState> emit,
  ) async {
    emit(LessonLoading());

    final languageCode = languageCubit.state.languageCode;
    final Either<Failure, List<LessonEntity>> result =
        await getAllLessons(languageCode);

    result.match(
      (failure) => emit(LessonError(failure.message)),
      (lessons) => emit(LessonLoaded(lessons)),
    );
  }

  @override
  Future<void> close() {
    _languageSubscription.cancel();
    return super.close();
  }
}
