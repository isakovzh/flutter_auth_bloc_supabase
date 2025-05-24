import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/lesson/presentation/pages/interactive_lesson_one_page.dart';
import 'package:app/feature/lesson/presentation/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';

class LessonDetailPage extends StatelessWidget {
  final LessonEntity lesson;

  const LessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    // Если это интерактивный урок
    if (lesson.id == 'lesson_1') {
      return InteractiveLessonOnePage(lesson: lesson);
    }

    // Обычные уроки, пока не интерактивны, но будет как demo
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Заголовок
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Подпись: "Скоро будет интерактивным"
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.amber.shade100,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.auto_awesome, color: Colors.orange),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              "⚡️ Этот урок скоро станет интерактивным, как в демо-версии Lesson 1!",
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Контент урока
                    Text(
                      lesson.content,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Кнопка викторины
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(lesson: lesson),
                  ),
                );
              },
              icon: const Icon(Icons.quiz),
              label: Text(l10n.startQuiz),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
