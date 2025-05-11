class UserProfileDetailsEntity {
  final String userId;
  final String username;
  final String avatarUrl;
  final int level;
  final int xp;
  final List<String> achievements; // ✅ добавлено
  final int lessonsCompleted;
  final int mistakes;
  final List<String> completedLessons;
  final Map<String, int> quizResults;
  final Map<String, Map<int, int>> errorProgress;
  final Map<String, double> xpPerDay;

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
    required this.quizResults,
    required this.errorProgress,
    required this.xpPerDay,
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
    Map<String, int>? quizResults,
    Map<String, Map<int, int>>? errorProgress,
    Map<String, double>? xpPerDay,
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
      quizResults: quizResults ?? this.quizResults,
      errorProgress: errorProgress ?? this.errorProgress,
      xpPerDay: xpPerDay ?? this.xpPerDay,
    );
  }
}