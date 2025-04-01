import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';
import 'package:app/feature/profile/domain/repositories/profile_deteils_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:app/core/error/failure.dart';


class GetProfileDetails implements Usecase<ProfileDetailsEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileDetails(this.repository);

  @override
  Future<Either<Failure, ProfileDetailsEntity>> call(NoParams params) {
    return repository.getProfileDetails();
  }
}