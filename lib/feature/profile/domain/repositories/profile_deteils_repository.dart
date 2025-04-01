import 'package:app/core/error/failure.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failure, ProfileDetailsEntity>> getProfileDetails();
  Future<Either<Failure, void>> updateProfileDetails(ProfileDetailsEntity entity);
}