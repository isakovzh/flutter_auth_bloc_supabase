import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../lesson/presentation/pages/home_page.dart'; // Импортируй свой ErrorQuestion

class ErrorQuizPage extends StatefulWidget {
  final List<ErrorQuestion> errorQuestions;

  const ErrorQuizPage({super.key, required this.errorQuestions});

  @override
  State<ErrorQuizPage> createState() => _ErrorQuizPageState();
}

class _ErrorQuizPageState extends State<ErrorQuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  bool answered = false;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    if (widget.errorQuestions.isEmpty) {
      debugPrint('⚠️ ErrorQuizPage: empty errorQuestions list!');
    }
  }

  void _answer(int index) {
    if (answered) return;

    setState(() {
      selectedIndex = index;
      answered = true;

      final current = widget.errorQuestions[currentQuestionIndex];
      final isCorrect = index == current.correctIndex;

      context.read<ProfileBloc>().add(
            UpdateErrorProgressEvent(
              lessonId: current.lessonId,
              questionIndex: current.questionIndex,
              isCorrect: isCorrect,
            ),
          );

      if (isCorrect) {
        correctAnswers++;
      }
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (currentQuestionIndex + 1 < widget.errorQuestions.length) {
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
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Error Quiz Completed'),
        content: Text(
          '✅ You answered $correctAnswers / ${widget.errorQuestions.length} correctly.\nYou earned ${correctAnswers * 5} XP!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              context
                  .read<ProfileBloc>()
                  .add(CompleteErrorQuizEvent(correctAnswers));

              Navigator.pop(context); // Закрыть диалог
              Navigator.pop(context); // Вернуться на HomePage
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.errorQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error Quiz')),
        body: const Center(
          child: Text(
            '🎉 No mistakes to review! Great job!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    final current = widget.errorQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} / ${widget.errorQuestions.length}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              current.questionText,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ...List.generate(current.options.length, (index) {
              final isSelected = index == selectedIndex;
              final isCorrect = index == current.correctIndex;

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
                  child: Text(current.options[index]),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
