import 'package:app/feature/lesson/domain/entities/lesson.dart';

class LessonModel extends LessonEntity {
  LessonModel({
    required super.id,
    required super.title,
    required super.description,
    required super.content,
    required QuizModel super.quiz,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      content: json['content'],
      quiz: QuizModel.fromJson(json['quiz']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'content': content,
        'quiz': (quiz as QuizModel).toJson(),
      };
}

class QuizModel extends QuizEntity {
  QuizModel({required List<QuestionModel> questions})
      : super(questions: questions);

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'questions':
            questions.map((q) => (q as QuestionModel).toJson()).toList(),
      };
}

class QuestionModel extends QuestionEntity {
  QuestionModel({
    required super.question,
    required super.options,
    required super.correctIndex,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correctIndex'],
    );
  }

  Map<String, dynamic> toJson() => {
        'question': question,
        'options': options,
        'correctIndex': correctIndex,
      };
}
