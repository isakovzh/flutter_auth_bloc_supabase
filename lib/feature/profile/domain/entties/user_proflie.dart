class UserProfileDetailsEntity {
  final String userId;
  final String username;
  final String avatarUrl;
  final int level;
  final int xp;
  final List<String> achievements;
  final int lessonsCompleted;
  final int mistakes;
  final List<String> completedLessons;
  final Map<String, int> quizResults; // 🆕 добавили сюда

  const UserProfileDetailsEntity({
    required this.userId,
    required this.username,
    required this.avatarUrl,
    required this.level,
    required this.xp,
    required this.achievements,
    required this.lessonsCompleted,
    required this.mistakes,
    required this.completedLessons,
    required this.quizResults, // 👈 добавили в конструктор
  });

  UserProfileDetailsEntity copyWith({
    String? userId,
    String? username,
    String? avatarUrl,
    int? xp,
    int? level,
    List<String>? achievements,
    int? lessonsCompleted,
    int? mistakes,
    List<String>? completedLessons,
    Map<String, int>? quizResults, // 👈 сюда тоже добавляем
  }) {
    return UserProfileDetailsEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      achievements: achievements ?? this.achievements,
      lessonsCompleted: lessonsCompleted ?? this.lessonsCompleted,
      mistakes: mistakes ?? this.mistakes,
      completedLessons: completedLessons ?? this.completedLessons,
      quizResults: quizResults ?? this.quizResults, // 👈 здесь тоже
    );
  }
}
