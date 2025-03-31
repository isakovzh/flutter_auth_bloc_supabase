import 'package:app/core/error/execption.dart';
import 'package:app/feature/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDataSource {
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<UserModel> getCurrentUserData();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient supabaseClient;

  AuthRemoteDataSourceImpl(this.supabaseClient);

  Session? get _currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> getCurrentUserData() async {
    try {
      if (_currentUserSession == null) {
        throw const ServerException("No active session");
      }

      final userId = _currentUserSession!.user.id;
      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return UserModel.fromJson(userData).copyWith(
        email: _currentUserSession!.user.email,
      );
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final response = await supabaseClient.auth.signInWithPassword(
        email: email.trim(),
        password: password.trim(),
      );

      if (response.user == null) {
        throw const ServerException("Login failed");
      }

      return await getCurrentUserData();
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // 🔍 Логируем входные данные
      print("SIGNUP DEBUG → name: $name, email: $email, password: $password");

      final response = await supabaseClient.auth.signUp(
        email: email.trim(),
        password: password.trim(),
        data: {'name': name.trim()},
      );

      // 🔐 Проверяем, если включена email confirmation
      if (response.user == null || response.session == null) {
        throw const ServerException(
          "Signup failed. Possibly email already in use or email confirmation required.",
        );
      }

      return await getCurrentUserData();
    } catch (e) {
      print('Signup Exception → $e');

      if (e is AuthException) {
        print('AuthException → ${e.message}');
      }

      throw ServerException(e.toString());
    }
  }
}
