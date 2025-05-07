import 'package:hive/hive.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';

part 'user_profile_details_model.g.dart';

@HiveType(typeId: 1)
class UserProfileDetailsModel extends HiveObject {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String username;

  @HiveField(2)
  final String avatarUrl;

  @HiveField(3)
  final int xp;

  @HiveField(4)
  final int level;

  @HiveField(5)
  final List<String> achievements;

  @HiveField(6)
  final int lessonsCompleted;

  @HiveField(7)
  final int mistakes;

  @HiveField(8) // ← новое поле в Hive
  final List<String> completedLessons;

  UserProfileDetailsModel({
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.xp,
    required this.level,
    required this.achievements,
    required this.lessonsCompleted,
    required this.mistakes,
    required this.completedLessons,
  });

  factory UserProfileDetailsModel.fromEntity(UserProfileDetailsEntity entity) {
    return UserProfileDetailsModel(
      userId: entity.userId,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      xp: entity.xp,
      level: entity.level,
      achievements: entity.achievements,
      lessonsCompleted: entity.lessonsCompleted,
      mistakes: entity.mistakes,
      completedLessons: entity.completedLessons,
    );
  }

  UserProfileDetailsEntity toEntity() {
    return UserProfileDetailsEntity(
      userId: userId,
      username: username,
      avatarUrl: avatarUrl,
      xp: xp,
      level: level,
      achievements: achievements,
      lessonsCompleted: lessonsCompleted,
      mistakes: mistakes,
      completedLessons: completedLessons,
    );
  }
}
