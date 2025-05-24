import 'package:app/feature/lesson/domain/entities/eroor_quiesttion.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    final l10n = AppLocalizations.of(context);
    final totalQuestions = widget.errorQuestions.length;
    final earnedXP = correctAnswers * 5;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: Text(l10n.errorQuizCompleted),
        content: Text(
          l10n.errorQuizResults(correctAnswers, totalQuestions, earnedXP),
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.read<ProfileBloc>().add(
                    CompleteErrorQuizEvent(
                      correctAnswers: correctAnswers,
                      context: context,
                    ),
                  );

              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: Text(l10n.done),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final questions = widget.errorQuestions;
    final question = questions[currentQuestionIndex];

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text(l10n.errorQuiz)),
        body: const Center(
          child: Text(
            '🎉 No mistakes to review! Great job!',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.errorQuiz),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.questionCounter(currentQuestionIndex + 1, questions.length),
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 16),
            Text(
              question.questionText,
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
    );
  }
}
