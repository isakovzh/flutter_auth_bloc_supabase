// lib/feature/profile/data/models/profile_details_model.dart

// ignore_for_file: overridden_fields

import 'package:hive/hive.dart';
import 'package:app/feature/profile/domain/entities/proflie_deteils_entitie.dart';

part 'profilie_deteils_model.g.dart';

@HiveType(typeId: 0)
class ProfileDetailsModel extends ProfileDetailsEntity with HiveObjectMixin {
  @override
  @HiveField(0)
  final String id;

  @override
  @HiveField(1)
  final String username;

  @override
  @HiveField(2)
  final String avatarUrl;

  @override
  @HiveField(3)
  final int level;

  @override
  @HiveField(4)
  final int xp;

  @override
  @HiveField(5)
  final List<String> achievements;

  @override
  @HiveField(6)
  final int lessonsCompleted;

  @override
  @HiveField(7)
  final int mistakes;

   ProfileDetailsModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    required this.level,
    required this.xp,
    required this.achievements,
    required this.lessonsCompleted,
    required this.mistakes,
  }) : super(
          id: id,
          username: username,
          avatarUrl: avatarUrl,
          level: level,
          xp: xp,
          achievements: achievements,
          lessonsCompleted: lessonsCompleted,
          mistakes: mistakes,
        );
}
