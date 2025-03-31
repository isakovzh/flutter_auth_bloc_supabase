import 'package:app/core/common/entities/user.dart';
import 'package:app/core/error/failure.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class SignUpWithEmailPassword implements Usecase<User, SignUpParams> {
  final AuthRepository repository;

  SignUpWithEmailPassword(this.repository);

  @override
  Future<Either<Failure, User>> call(SignUpParams params) {
    return repository.signUpWithEmailPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginWithEmailPassword implements Usecase<User, LoginParams> {
  final AuthRepository repository;

  LoginWithEmailPassword(this.repository);

  @override
  Future<Either<Failure, User>> call(LoginParams params) {
    return repository.loginWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({
    required this.email,
    required this.password,
  });
}

class CurrentUserData implements Usecase<User, NoParams> {
  final AuthRepository repository;

  CurrentUserData(this.repository);

  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.currentUserData();
  }
}
