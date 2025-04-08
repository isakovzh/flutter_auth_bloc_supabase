// lib/feature/profile/presentation/bloc/profile_bloc.dart

import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/usecases/clear_proflie_deteils.dart';
import 'package:app/feature/profile/domain/usecases/get_proflie_deteild.dart';
import 'package:app/feature/profile/domain/usecases/update_proflie_details.dart';
import 'package:app/feature/profile/presentation/bloc/profile_state.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDetails getProfileDetails;
  final UpdateProfileDetails updateProfileDetails;
  final ClearProfileDetails clearProfileDetails;

  ProfileBloc({
    required this.getProfileDetails,
    required this.updateProfileDetails,
    required this.clearProfileDetails,
  }) : super(ProfileInitial()) {
    on<GetProfileDetailsEvent>(_onGetProfile);
    on<UpdateProfileDetailsEvent>(_onUpdateProfile);
    on<ClearProfileDetailsEvent>(_onClearProfile);
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
}
