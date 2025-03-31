import 'package:app/core/common/entities/user.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailPassword signUp;
  final LoginWithEmailPassword login;
  final CurrentUserData currentUser;

  AuthBloc({
    required this.signUp,
    required this.login,
    required this.currentUser,
  }) : super(const AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthLoginRequested>(_onLogin);
    on<AuthCheckStatusRequested>(_onCheck);
  }

  Future<void> _onSignUp(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await signUp(SignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    result.match(
      (failure) {
        final is422 = failure.message.contains("422");
        final message =
            is422 ? "Invalid input or email already in use." : failure.message;
        emit(AuthFailure(message));
      },
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onLogin(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await login(LoginParams(
      email: event.email,
      password: event.password,
    ));
    result.match(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  Future<void> _onCheck(
      AuthCheckStatusRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await currentUser(NoParams());
    result.match(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }
}
