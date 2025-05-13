class ErrorQuestion {
  final String lessonId;
  final int questionIndex;
  final String questionText;
  final List<String> options;
  final int correctIndex;

  ErrorQuestion({
    required this.lessonId,
    required this.questionIndex,
    required this.questionText,
    required this.options,
    required this.correctIndex,
  });
}