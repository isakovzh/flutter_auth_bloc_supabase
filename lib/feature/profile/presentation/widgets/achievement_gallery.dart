import 'package:app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AchievementGalleryPage extends StatelessWidget {
  final List<String> unlocked;
  const AchievementGalleryPage({super.key, required this.unlocked});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final all = [
      'first_quiz_passed',
      'perfect_quiz_score',
      'xp_100',
      'lesson_5_completed',
      'cleared_all_mistakes',
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.achievementsGallery)),
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
                title: Text(isUnlocked
                    ? l10n.achievementTitle
                    : l10n.achievementHowToUnlock),
                content: Text(
                  isUnlocked
                      ? _getDescription(id, l10n)
                      : _getRequirementHint(id, l10n),
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(l10n.ok),
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
                    _getAchievementTitle(id, l10n),
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

  String _getAchievementTitle(String id, AppLocalizations l10n) {
    switch (id) {
      case 'first_quiz_passed':
        return l10n.achievementFirstQuiz;
      case 'perfect_quiz_score':
        return l10n.achievementPerfectScore;
      case 'xp_100':
        return l10n.achievement100XP;
      case 'lesson_5_completed':
        return l10n.achievement5Lessons;
      case 'cleared_all_mistakes':
        return l10n.achievementNoMistakes;
      default:
        return l10n.achievementUnlocked;
    }
  }

  String _getDescription(String id, AppLocalizations l10n) {
    switch (id) {
      case 'first_quiz_passed':
        return l10n.achievementFirstQuizDesc;
      case 'perfect_quiz_score':
        return l10n.achievementPerfectScoreDesc;
      case 'xp_100':
        return l10n.achievement100XPDesc;
      case 'lesson_5_completed':
        return l10n.achievement5LessonsDesc;
      case 'cleared_all_mistakes':
        return l10n.achievementNoMistakesDesc;
      default:
        return l10n.achievementUnlockedDesc;
    }
  }

  String _getRequirementHint(String id, AppLocalizations l10n) {
    switch (id) {
      case 'first_quiz_passed':
        return l10n.achievementFirstQuizHint;
      case 'perfect_quiz_score':
        return l10n.achievementPerfectScoreHint;
      case 'xp_100':
        return l10n.achievement100XPHint;
      case 'lesson_5_completed':
        return l10n.achievement5LessonsHint;
      case 'cleared_all_mistakes':
        return l10n.achievementNoMistakesHint;
      default:
        return l10n.achievementGenericHint;
    }
  }
}
