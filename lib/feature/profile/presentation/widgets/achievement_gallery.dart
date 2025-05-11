import 'package:flutter/material.dart';

class AchievementGalleryPage extends StatelessWidget {
  final List<String> unlocked;
  const AchievementGalleryPage({super.key, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final all = [
      'first_quiz_passed',
      'perfect_quiz_score',
      'xp_100',
      'lesson_5_completed',
      'cleared_all_mistakes',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Achievements Gallery')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: all.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          final id = all[index];
          final isUnlocked = unlocked.contains(id);

          return GestureDetector(
            onTap: () => showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: Text(
                    isUnlocked ? 'Achievement Unlocked!' : 'Как получить?'),
                content: Text(
                  isUnlocked ? _getDescription(id) : _getRequirementHint(id),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('OK'),
                  ),
                ],
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: isUnlocked ? Colors.amber : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.black12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isUnlocked ? Icons.star : Icons.star_border,
                    size: 40,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    id.replaceAll('_', ' '),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getDescription(String id) {
    switch (id) {
      case 'first_quiz_passed':
        return 'Ты прошёл свой первый тест. Молодец!';
      case 'perfect_quiz_score':
        return 'Ты прошёл тест без единой ошибки!';
      case 'xp_100':
        return 'Ты набрал 100 очков опыта!';
      case 'lesson_5_completed':
        return 'Ты завершил 5 уроков. Продолжай в том же духе!';
      case 'cleared_all_mistakes':
        return 'Ты исправил все свои ошибки. Настоящий герой!';
      default:
        return 'Достижение получено!';
    }
  }

  String _getRequirementHint(String id) {
    switch (id) {
      case 'first_quiz_passed':
        return 'Пройди хотя бы один тест.';
      case 'perfect_quiz_score':
        return 'Ответь правильно на все вопросы одного теста.';
      case 'xp_100':
        return 'Набери как минимум 100 XP.';
      case 'lesson_5_completed':
        return 'Заверши 5 разных уроков.';
      case 'cleared_all_mistakes':
        return 'Пройди все ошибки повторно без ошибок.';
      default:
        return 'Выполни условие для получения.';
    }
  }
}
