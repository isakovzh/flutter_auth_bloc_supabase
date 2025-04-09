import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:flutter/material.dart';

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
      setState(() {
        currentQuestionIndex++;
        answered = false;
        selectedIndex = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final questions = widget.lesson.quiz.questions;

    if (currentQuestionIndex >= questions.length) {
      return Scaffold(
        appBar: AppBar(title: const Text('Quiz Completed')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Score: $score / ${questions.length}',
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Lessons'),
              )
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
                'Question ${currentQuestionIndex + 1}/${questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              Text(
                question.question,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
