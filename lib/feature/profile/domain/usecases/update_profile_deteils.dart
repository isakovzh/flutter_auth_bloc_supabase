import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';
import 'package:app/feature/profile/domain/repositories/profile_deteils_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app/core/error/failure.dart';


class UpdateProfileDetails implements Usecase<void, ProfileDetailsEntity> {
  final ProfileRepository repository;

  UpdateProfileDetails(this.repository);

  @override
  Future<Either<Failure, void>> call(ProfileDetailsEntity entity) {
    return repository.updateProfileDetails(entity);
  }
}
