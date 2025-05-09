import 'package:hive/hive.dart';
part 'quiz_result_entry.g.dart';

@HiveType(typeId: 2)
class QuizResultEntry {
  @HiveField(0)
  final String lessonId;

  @HiveField(1)
  final int correctAnswers;

  QuizResultEntry({
    required this.lessonId,
    required this.correctAnswers,
  });
}
