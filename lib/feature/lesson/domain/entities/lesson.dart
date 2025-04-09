class LessonEntity {
  final String id;
  final String title;
  final String description;
  final String content;
  final QuizEntity quiz;

  LessonEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.quiz,
  });
}

class QuizEntity {
  final List<QuestionEntity> questions;

  QuizEntity({required this.questions});
}

class QuestionEntity {
  final String question;
  final List<String> options;
  final int correctIndex;

  QuestionEntity({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
