import 'package:app/core/error/failure.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails();
  Future<Either<Failure, Unit>> updateProfileDetails(
      UserProfileDetailsEntity profile);
  Future<Either<Failure, Unit>> clearProfileDetails();
}
