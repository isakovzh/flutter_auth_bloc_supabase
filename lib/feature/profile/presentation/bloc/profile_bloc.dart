import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';
import 'package:app/feature/profile/domain/usecases/get_profile_detelis.dart';
import 'package:app/feature/profile/domain/usecases/update_profile_deteils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';


part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileDetails getProfileDetails;
  final UpdateProfileDetails updateProfileDetails;

  ProfileBloc({
    required this.getProfileDetails,
    required this.updateProfileDetails,
  }) : super(ProfileInitial()) {
    on<GetProfileDetailsEvent>(_onGetProfile);
    on<UpdateProfileDetailsEvent>(_onUpdateProfile);
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
    final result = await updateProfileDetails(event.updatedDetails);
    result.match(
      (failure) => emit(ProfileError(failure.message)),
      (_) => add(const GetProfileDetailsEvent()),
    );
  }
}
