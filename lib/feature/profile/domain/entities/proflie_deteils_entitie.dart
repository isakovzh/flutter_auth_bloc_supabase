// lib/feature/profile/domain/entities/profile_details_entity.dart
import 'package:equatable/equatable.dart';

class ProfileDetailsEntity extends Equatable {
  final String id;
  final String username;
  final String avatarUrl;
  final int level;
  final int xp;
  final List<String> achievements;
  final int lessonsCompleted;
  final int mistakes;

  const ProfileDetailsEntity({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.level,
    required this.xp,
    required this.achievements,
    required this.lessonsCompleted,
    required this.mistakes,
  });

  @override
  List<Object?> get props => [
        id,
        username,
        avatarUrl,
        level,
        xp,
        achievements,
        lessonsCompleted,
        mistakes,
      ];
}
