class ProfileDetailsEntity {
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
}
