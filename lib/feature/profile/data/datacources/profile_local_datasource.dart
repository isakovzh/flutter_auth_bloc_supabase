import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:hive/hive.dart';

abstract interface class ProfileLocalDataSource {
  Future<void> updateProfileDetails(UserProfileDetailsModel model);
  Future<UserProfileDetailsModel?> getProfileDetails(
      String userId); // <-- обновлённый метод
  Future<void> clearProfileDetails(String userId); // <-- обновлённый
  Future<void> saveProfile(UserProfileDetailsModel model); // <-- новый
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  final Box<UserProfileDetailsModel> _box;

  ProfileLocalDataSourceImpl(this._box);

  @override
  Future<void> updateProfileDetails(UserProfileDetailsModel model) async {
    await _box.put(model.userId, model); // userId как ключ
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
}
