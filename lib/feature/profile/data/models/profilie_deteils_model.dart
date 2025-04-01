import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';

class ProfileDetailsModel extends ProfileDetailsEntity {
  const ProfileDetailsModel({
    required super.id,
    required super.username,
    required super.avatarUrl,
    required super.level,
    required super.xp,
    required super.achievements,
    required super.lessonsCompleted,
    required super.mistakes,
  });

  factory ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    return ProfileDetailsModel(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String? ?? '',
      level: json['level'] as int? ?? 1,
      xp: json['xp'] as int? ?? 0,
      achievements: List<String>.from(json['achievements'] ?? []),
      lessonsCompleted: json['lessons_completed'] as int? ?? 0,
      mistakes: json['mistakes'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'avatar_url': avatarUrl,
      'level': level,
      'xp': xp,
      'achievements': achievements,
      'lessons_completed': lessonsCompleted,
      'mistakes': mistakes,
    };
  }

  ProfileDetailsEntity toEntity() => ProfileDetailsEntity(
        id: id,
        username: username,
        avatarUrl: avatarUrl,
        level: level,
        xp: xp,
        achievements: achievements,
        lessonsCompleted: lessonsCompleted,
        mistakes: mistakes,
      );
  factory ProfileDetailsModel.fromEntity(ProfileDetailsEntity entity) {
    return ProfileDetailsModel(
      id: entity.id,
      username: entity.username,
      avatarUrl: entity.avatarUrl,
      level: entity.level,
      xp: entity.xp,
      achievements: entity.achievements,
      lessonsCompleted: entity.lessonsCompleted,
      mistakes: entity.mistakes,
    );
  }
}
