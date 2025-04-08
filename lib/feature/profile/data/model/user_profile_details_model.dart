import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:hive/hive.dart';

part 'user_profile_details_model.g.dart';

@HiveType(typeId: 1)
class UserProfileDetailsModel extends UserProfileDetailsEntity {
  @override
  @HiveField(0)
  final String userId;

  @override
  @HiveField(1)
  final String username;

  @override
  @HiveField(2)
  final String avatarUrl;

  @override
  @HiveField(3)
  final int xp;

  @override
  @HiveField(4)
  final int level;

  @override
  @HiveField(5)
  final List<String> achievements;

  @override
  @HiveField(6)
  final int lessonsCompleted;

  @override
  @HiveField(7)
  final int mistakes;

  const UserProfileDetailsModel({
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.xp,
    required this.level,
    required this.achievements,
    required this.lessonsCompleted,
    required this.mistakes,
  }) : super(
          userId: userId,
          username: username,
          avatarUrl: avatarUrl,
          xp: xp,
          level: level,
          achievements: achievements,
          lessonsCompleted: lessonsCompleted,
          mistakes: mistakes,
        );

  factory UserProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return UserProfileDetailsModel(
      userId: json['userId'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String? ?? '',
      xp: json['xp'] as int? ?? 0,
      level: json['level'] as int? ?? 1,
      achievements: List<String>.from(json['achievements'] ?? []),
      lessonsCompleted: json['lessonsCompleted'] as int? ?? 0,
      mistakes: json['mistakes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'username': username,
      'avatarUrl': avatarUrl,
      'xp': xp,
      'level': level,
      'achievements': achievements,
      'lessonsCompleted': lessonsCompleted,
      'mistakes': mistakes,
    };
  }

  factory UserProfileDetailsModel.fromEntity(UserProfileDetailsEntity entity) {
    return UserProfileDetailsModel(
      userId: entity.userId,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      level: entity.level,
      xp: entity.xp,
      achievements: entity.achievements,
      lessonsCompleted: entity.lessonsCompleted,
      mistakes: entity.mistakes,
    );
  }

  UserProfileDetailsEntity toEntity() {
    return UserProfileDetailsEntity(
      userId: userId,
      username: username,
      avatarUrl: avatarUrl,
      level: level,
      xp: xp,
      achievements: achievements,
      lessonsCompleted: lessonsCompleted,
      mistakes: mistakes,
    );
  }
}
