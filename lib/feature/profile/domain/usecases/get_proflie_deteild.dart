import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetProfileDetails implements Usecase<UserProfileDetailsEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileDetails(this.repository);

  @override
  Future<Either<Failure, UserProfileDetailsEntity>> call(NoParams params) {
    return repository.getProfileDetails();
  }
}
