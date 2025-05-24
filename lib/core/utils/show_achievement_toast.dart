import 'package:flutter/material.dart';
import 'package:app/feature/profile/presentation/widgets/achievement_toast.dart';
import 'package:app/l10n/app_localizations.dart';

void showAchievementToast(BuildContext context, String achievementId) {
  final l10n = AppLocalizations.of(context);
  final overlay = Overlay.of(context);

  final message = _getDescription(achievementId, l10n);

  final entry = OverlayEntry(
    builder: (_) => AchievementToast(message: message),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 4), () => entry.remove());
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
