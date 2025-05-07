// lib/feature/lesson/presentation/pages/quiz_page.dart

import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/feature/profile/presentation/bloc/profile_state.dart';
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
  int score = 0;
  bool answered = false;
  int? selectedIndex;
  bool isQuizCompleted = false;

  void _answer(int index) {
    if (answered) return;

    setState(() {
      selectedIndex = index;
      answered = true;

      final currentQuestion =
          widget.lesson.quiz.questions[currentQuestionIndex];
      if (index == currentQuestion.correctIndex) {
        score++;
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
        setState(() {
          isQuizCompleted = true;
        });
      }
    });
  }

  void _onDonePressed() {
    final profileBloc = context.read<ProfileBloc>();
    final currentState = profileBloc.state;

    if (currentState is ProfileLoaded) {
      final profile = currentState.profile;

      // Обновляем профиль: добавляем id завершённого урока
      final updatedProfile = profile.copyWith(
        completedLessons: List.from(profile.completedLessons)
          ..add(widget.lesson.id),
      );

      // Отправляем событие обновления профиля
      profileBloc.add(UpdateProfileDetailsEvent(updatedProfile));
    }

    // Возвращаемся на HomePage
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.lesson.quiz.questions;

    if (isQuizCompleted) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Completed')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '✅ Your Score: $score / ${questions.length}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: _onDonePressed,
                icon: const Icon(Icons.check),
                label: const Text('Done'),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                ),
              ),
            ],
          ),
        ),
      );
    }

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
                'Question ${currentQuestionIndex + 1} / ${questions.length}',
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
