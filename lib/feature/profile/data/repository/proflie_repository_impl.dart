import 'package:app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/feature/profile/data/datacources/profile_local_datasource.dart';
import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final SupabaseClient supabase;

  ProfileRepositoryImpl(this.localDataSource, this.supabase);

  @override
  Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails() async {
    try {
      final user = supabase.auth.currentUser;

      if (user == null) {
        return left(Failure("Пользователь не авторизован"));
      }

      final userId = user.id;
      final localProfile = await localDataSource.getProfileDetails(userId);

      if (localProfile != null) {
        return right(localProfile.toEntity());
      }

      // Если профиль не найден — создаём новый
      final newProfile = UserProfileDetailsModel(
        userId: userId,
        username: user.userMetadata?['name'] ?? 'Unnamed',
        avatarUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVrQvJV3oC7yD2UTGgiq1rSVCHpMFAetEnIg&s',
        xp: 0,
        level: 1,
        achievements: [],
        lessonsCompleted: 0,
        mistakes: 0,
        completedLessons: [],
      );

      await localDataSource.saveProfile(newProfile);
      return right(newProfile.toEntity());
    } catch (e) {
      return left(Failure("Ошибка при получении профиля: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfileDetails(
      UserProfileDetailsEntity entity) async {
    try {
      final model = UserProfileDetailsModel.fromEntity(entity);
      await localDataSource.updateProfileDetails(model);
      return right(unit);
    } catch (e) {
      return left(Failure("Ошибка при обновлении профиля: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearProfileDetails() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        await localDataSource.clearProfileDetails(user.id);
      }
      return right(unit);
    } catch (e) {
      return left(Failure("Ошибка при удалении профиля: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> markLessonAsCompleted(String lessonId) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      final localProfile = await localDataSource.getProfileDetails(user.id);
      if (localProfile == null) {
        return left(Failure("Profile not found"));
      }

      if (!localProfile.completedLessons.contains(lessonId)) {
        localProfile.completedLessons.add(lessonId);
        await localDataSource.updateProfileDetails(localProfile);
      }

      return right(unit);
    } catch (e) {
      return left(
          Failure("Error marking lesson as completed: ${e.toString()}"));
    }
  }
}
