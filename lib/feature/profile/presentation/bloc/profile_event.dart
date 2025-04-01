part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

class GetProfileDetailsEvent extends ProfileEvent {
  const GetProfileDetailsEvent();
}

class UpdateProfileDetailsEvent extends ProfileEvent {
  final ProfileDetailsEntity updatedDetails;

  const UpdateProfileDetailsEvent(this.updatedDetails);

  @override
  List<Object?> get props => [updatedDetails];
}
