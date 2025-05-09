import 'package:app/feature/profile/data/model/quiz_result_entry.dart';
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

  @HiveField(8)
  final List<String> completedLessons;

  @HiveField(9)
  late List<QuizResultEntry> quizResults;

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
    required this.quizResults,
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
      quizResults: entity.quizResults.entries
          .map((e) => QuizResultEntry(
                lessonId: e.key,
                correctAnswers: e.value,
              ))
          .toList(),
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
      quizResults: {
        for (var e in quizResults) e.lessonId: e.correctAnswers,
      },
    );
  }

  UserProfileDetailsModel copyWith({
    String? userId,
    String? username,
    String? avatarUrl,
    int? xp,
    int? level,
    List<String>? achievements,
    int? lessonsCompleted,
    int? mistakes,
    List<String>? completedLessons,
    List<QuizResultEntry>? quizResults,
  }) {
    return UserProfileDetailsModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      achievements: achievements ?? this.achievements,
      lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
      mistakes: mistakes ?? this.mistakes,
      completedLessons: completedLessons ?? this.completedLessons,
      quizResults: quizResults ?? this.quizResults,
    );
  }
}
