import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:fpdart/fpdart.dart';

class ClearProfileDetails implements Usecase<Unit, NoParams> {
  final ProfileRepository repository;

  ClearProfileDetails(this.repository);

  @override
  Future<Either<Failure, Unit>> call(NoParams params) {
    return repository.clearProfileDetails();
  }
}
