import 'package:flutter/material.dart';
import 'package:app/feature/profile/presentation/widgets/achievement_toast.dart';

void showAchievementToast(BuildContext context, String achievementId) {
  print('🏆 Показываем тост для: $achievementId');

  final overlay = Overlay.of(context);
  if (overlay == null) {
    print('❌ Overlay не найден');
    return;
  }

  final message = _getDescription(achievementId);

  final entry = OverlayEntry(
    builder: (_) => AchievementToast(message: message),
  );

  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 4), () => entry.remove());
}

String _getDescription(String id) {
  switch (id) {
    case 'first_quiz_passed':
      return 'Ты прошёл свой первый тест!';
    case 'perfect_quiz_score':
      return 'Идеальный результат — все ответы верны!';
    case 'xp_100':
      return 'Ты набрал 100 XP!';
    case 'lesson_5_completed':
      return 'Ты завершил 5 уроков!';
    case 'cleared_all_mistakes':
      return 'Ты исправил все ошибки!';
    default:
      return 'Новое достижение!';
  }
}
