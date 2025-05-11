import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizPage extends StatefulWidget {
  final LessonEntity lesson;

  const QuizPage({super.key, required this.lesson});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool answered = false;
  int? selectedIndex;

  void _answer(int index) {
    if (answered) return;

    final currentQuestion = widget.lesson.quiz.questions[currentQuestionIndex];
    final isCorrect = index == currentQuestion.correctIndex;

    setState(() {
      selectedIndex = index;
      answered = true;

      if (!isCorrect) {
        context.read<ProfileBloc>().add(UpdateErrorProgressEvent(
              lessonId: widget.lesson.id,
              questionIndex: currentQuestionIndex,
              isCorrect: isCorrect,
            ));
      }
      if (isCorrect) {
        correctAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex + 1 < widget.lesson.quiz.questions.length) {
        setState(() {
          currentQuestionIndex++;
          answered = false;
          selectedIndex = null;
        });
      } else {
        _showCompletionDialog();
      }
    });
  }

  void _showCompletionDialog() {
    final totalQuestions = widget.lesson.quiz.questions.length;
    final earnedXP = (correctAnswers / totalQuestions * 100).round();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text(
          'You answered $correctAnswers / $totalQuestions correctly.\nYou earned $earnedXP XP!',
        ),
        actions: [
          TextButton(
            onPressed: () async {
              // Отправляем AddQuizResultEvent
              context.read<ProfileBloc>().add(AddQuizResultEvent(
                    lessonId: widget.lesson.id,
                    correctAnswers: correctAnswers,
                    totalQuestions: totalQuestions,
                    context: context,
                  ));

              Navigator.pop(context); // Закрыть диалог
              Navigator.pop(context); // Закрыть QuizPage
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.lesson.quiz.questions;
    final question = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.lesson.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...List.generate(question.options.length, (index) {
                final isSelected = index == selectedIndex;
                final isCorrect = index == question.correctIndex;

                Color? buttonColor;
                if (answered) {
                  if (isSelected && isCorrect) {
                    buttonColor = Colors.green;
                  } else if (isSelected && !isCorrect) {
                    buttonColor = Colors.red;
                  } else if (isCorrect) {
                    buttonColor = Colors.green;
                  }
                }

                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _answer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(question.options[index]),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
