// lib/feature/profile/presentation/bloc/profile_bloc.dart

import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/usecases/clear_proflie_deteils.dart';
import 'package:app/feature/profile/domain/usecases/complete_error_quiz_usecase.dart';
import 'package:app/feature/profile/domain/usecases/get_proflie_deteild.dart';
import 'package:app/feature/profile/domain/usecases/update_error_progress_usecase%20.dart';
import 'package:app/feature/profile/domain/usecases/update_proflie_details.dart';
import 'package:app/feature/profile/domain/usecases/add_quiz_result.dart'; // ✅ Используем этот UseCase
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDetails getProfileDetails;
  final UpdateProfileDetails updateProfileDetails;
  final ClearProfileDetails clearProfileDetails;
  final AddQuizResultUseCase addQuizResult;
  final UpdateErrorProgressUseCase updateErrorProgress;
  final CompleteErrorQuizUseCase completeErrorQuiz;

  ProfileBloc(
      {required this.getProfileDetails,
      required this.updateProfileDetails,
      required this.clearProfileDetails,
      required this.addQuizResult, // ✅ внедрили
      required this.updateErrorProgress,
      required this.completeErrorQuiz})
      : super(ProfileInitial()) {
    on<GetProfileDetailsEvent>(_onGetProfile);
    on<UpdateProfileDetailsEvent>(_onUpdateProfile);
    on<ClearProfileDetailsEvent>(_onClearProfile);
    on<AddQuizResultEvent>(_onAddQuizResult); // ✅ новый обработчик
    on<UpdateErrorProgressEvent>(_onUpdateErrorProgress);
    on<CompleteErrorQuizEvent>(_onCompleteErrorQuiz);
  }

  Future<void> _onGetProfile(
    GetProfileDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await getProfileDetails(NoParams());
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (profile) => emit(ProfileLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(
    UpdateProfileDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    print('👉 UpdateProfileDetailsEvent вызван');
    emit(ProfileLoading());
    final result = await updateProfileDetails(event.profile);
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(const GetProfileDetailsEvent()),
    );
  }

  Future<void> _onClearProfile(
    ClearProfileDetailsEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await clearProfileDetails(NoParams());
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (_) => emit(ProfileInitial()),
    );
  }

  Future<void> _onAddQuizResult(
    AddQuizResultEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await addQuizResult(AddQuizResultParams(
      lessonId: event.lessonId,
      correctAnswers: event.correctAnswers,
      totalQuestions: event.totalQuestions,
      context: event.context,
    ));
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(const GetProfileDetailsEvent()),
    );
  }

  Future<void> _onUpdateErrorProgress(
    UpdateErrorProgressEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    final result = await updateErrorProgress(UpdateErrorProgressParams(
      lessonId: event.lessonId,
      questionIndex: event.questionIndex,
      isCorrect: event.isCorrect,
    ));
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(const GetProfileDetailsEvent()),
    );
  }

  Future<void> _onCompleteErrorQuiz(
    CompleteErrorQuizEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (state is ProfileLoaded) {
      emit(ProfileLoading());

      final result = await completeErrorQuiz(
        CompleteErrorQuizParams(
          correctAnswers: event.correctAnswers,
          context: event.context,
        ),
      );

      result.match(
        (failure) => emit(ProfileError(failure.message)),
        (_) => add(const GetProfileDetailsEvent()),
      );
    }
  }
}
