import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:fpdart/fpdart.dart';

class UpdateProfileDetails implements Usecase<Unit, UserProfileDetailsEntity> {
  final ProfileRepository repository;

  UpdateProfileDetails(this.repository);

  @override
  Future<Either<Failure, Unit>> call(UserProfileDetailsEntity profile) {
    return repository.updateProfileDetails(profile);
  }
}
