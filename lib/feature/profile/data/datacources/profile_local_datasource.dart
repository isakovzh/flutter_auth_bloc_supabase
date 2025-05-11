import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:hive/hive.dart';

abstract interface class ProfileLocalDataSource {
  Future<void> updateProfileDetails(UserProfileDetailsModel model);
  Future<UserProfileDetailsModel?> getProfileDetails(String userId);
  Future<void> clearProfileDetails(String userId);
  Future<void> saveProfile(UserProfileDetailsModel model);
  Future<void> unlockAchievement(
      String userId, String achievementId); // ✅ добавлено
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box<UserProfileDetailsModel> _box;

  ProfileLocalDataSourceImpl(this._box);

  @override
  Future<void> updateProfileDetails(UserProfileDetailsModel model) async {
    await _box.put(model.userId, model);
  }

  @override
  Future<UserProfileDetailsModel?> getProfileDetails(String userId) async {
    return _box.get(userId);
  }

  @override
  Future<void> clearProfileDetails(String userId) async {
    await _box.delete(userId);
  }

  @override
  Future<void> saveProfile(UserProfileDetailsModel model) async {
    await _box.put(model.userId, model);
  }

  @override
  Future<void> unlockAchievement(String userId, String achievementId) async {
    final profile = await getProfileDetails(userId);
    if (profile == null) return;

    if (!profile.achievements.contains(achievementId)) {
      final updated = profile.copyWith(
        achievements: [...profile.achievements, achievementId],
      );
      await updateProfileDetails(updated);
      print('📝 Сохраняем достижение: $achievementId');
    }
  }
}
