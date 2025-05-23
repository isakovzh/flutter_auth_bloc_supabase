import 'package:app/core/common/entities/user.dart';
import 'package:app/core/usecases/usercase.dart';
import 'package:app/feature/auth/domain/usercases/auth_usecase.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';
import 'package:app/core/common/init/init_profile_dependencies.dart';
import 'package:app/core/common/init/init_character_dependencie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpWithEmailPassword signUp;
  final LoginWithEmailPassword login;
  final CurrentUserData currentUser;
  final Logout logout;
  final ProfileRepository? profileRepository;

  AuthBloc({
    required this.signUp,
    required this.login,
    required this.currentUser,
    required this.logout,
    this.profileRepository,
  }) : super(const AuthInitial()) {
    on<AuthSignUpRequested>(_onSignUp);
    on<AuthLoginRequested>(_onLogin);
    on<AuthCheckStatusRequested>(_onCheck);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _reinitializeDependencies() async {
    try {
      // Reinitialize profile dependencies
      await initProfileDependencies();

      // Reinitialize character dependencies with current language
      await initCharacterDependencies();
    } catch (e) {
      print('Error reinitializing dependencies after login: $e');
      // Continue even if reinitialization fails
    }
  }

  Future<void> _onSignUp(
      AuthSignUpRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    final result = await signUp(SignUpParams(
      name: event.name,
      email: event.email,
      password: event.password,
    ));

    await result.match(
      (failure) {
        final is422 = failure.message.contains("422");
        final message =
            is422 ? "Invalid input or email already in use." : failure.message;
        emit(AuthFailure(message));
      },
      (user) async {
        try {
          await _reinitializeDependencies();
        } catch (e) {
          print('Error initializing dependencies after signup: $e');
          // Continue even if initialization fails
        }
        emit(AuthSuccess(user));
      },
    );
  }

  Future<void> _onLogin(
      AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await login(LoginParams(
      email: event.email,
      password: event.password,
    ));

    await result.match((failure) async => emit(AuthFailure(failure.message)),
        (user) async {
      try {
        await _reinitializeDependencies();
        emit(AuthSuccess(user));
      } catch (e) {
        print('Error initializing dependencies after login: $e');
        // Continue even if initialization fails
        emit(AuthSuccess(user));
      }
    });
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

  Future<void> _onLogout(
      AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());
    final result = await logout(NoParams());

    result.match(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(const AuthInitial()),
    );
  }
}
