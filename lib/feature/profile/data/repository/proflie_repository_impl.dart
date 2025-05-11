import 'package:app/core/error/failure.dart';
import 'package:app/core/utils/global_keys.dart';
import 'package:app/core/utils/show_achievement_toast.dart';
import 'package:app/feature/profile/data/model/quiz_result_entry.dart';
import 'package:flutter/material.dart';

import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/feature/profile/data/datacources/profile_local_datasource.dart';
import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final SupabaseClient supabase;

  ProfileRepositoryImpl(this.localDataSource, this.supabase);

  int _calculateLevel(int xp) => (xp ~/ 100) + 1;

  @override
  Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails() async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      final profile = await localDataSource.getProfileDetails(user.id);
      if (profile != null) {
        return right(profile.toEntity());
      }

      final newProfile = UserProfileDetailsModel(
        userId: user.id,
        username: user.userMetadata?['name'] ?? 'Unnamed',
        avatarUrl: 'https://default-avatar.png',
        xp: 0,
        level: 1,
        achievements: [],
        lessonsCompleted: 0,
        mistakes: 0,
        completedLessons: [],
        quizResults: [],
        errorProgress: {},
        xpPerDay: {},
      );
      await localDataSource.saveProfile(newProfile);
      return right(newProfile.toEntity());
    } catch (e) {
      return left(Failure("Error: \${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateProfileDetails(
      UserProfileDetailsEntity entity) async {
    try {
      await localDataSource
          .updateProfileDetails(UserProfileDetailsModel.fromEntity(entity));
      return right(unit);
    } catch (e) {
      return left(Failure("Error: \${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> clearProfileDetails() async {
    try {
      final user = supabase.auth.currentUser;
      if (user != null) {
        await localDataSource.clearProfileDetails(user.id);
      }
      return right(unit);
    } catch (e) {
      return left(Failure("Error: \${e.toString()}"));
    }
  }
// === Обновлено: используем BuildContext напрямую ===

  @override
  Future<Either<Failure, Unit>> addQuizResult({
    required String lessonId,
    required int correctAnswers,
    required int totalQuestions,
    required BuildContext context, // добавлен контекст
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      final profile = await localDataSource.getProfileDetails(user.id);
      if (profile == null) {
        return left(Failure("Profile not found"));
      }

      final oldResult = profile.quizResults.firstWhere(
        (e) => e.lessonId == lessonId,
        orElse: () => QuizResultEntry(lessonId: '', correctAnswers: 0),
      );

      final hasOldResult = oldResult.lessonId.isNotEmpty;
      final oldCorrectAnswers = hasOldResult ? oldResult.correctAnswers : 0;

      if (correctAnswers <= oldCorrectAnswers) {
        return right(unit);
      }

      final diff = correctAnswers - oldCorrectAnswers;
      final xpGain = ((diff / totalQuestions) * 100).round();
      final today = DateTime.now();
      final todayStr =
          "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

      final updatedXpPerDay = Map<String, double>.from(profile.xpPerDay);
      updatedXpPerDay[todayStr] = (updatedXpPerDay[todayStr] ?? 0) + xpGain;

      List<QuizResultEntry> updatedResults;
      if (hasOldResult) {
        updatedResults = profile.quizResults.map((e) {
          if (e.lessonId == lessonId) {
            return QuizResultEntry(
              lessonId: lessonId,
              correctAnswers: correctAnswers,
            );
          }
          return e;
        }).toList();
      } else {
        updatedResults = [
          ...profile.quizResults,
          QuizResultEntry(
            lessonId: lessonId,
            correctAnswers: correctAnswers,
          ),
        ];
      }

      final updatedProfile = profile.copyWith(
        xp: profile.xp + xpGain,
        level: _calculateLevel(profile.xp + xpGain),
        quizResults: updatedResults,
        completedLessons: profile.completedLessons.contains(lessonId)
            ? profile.completedLessons
            : [...profile.completedLessons, lessonId],
        xpPerDay: updatedXpPerDay,
      );

      await localDataSource.updateProfileDetails(updatedProfile);

      final unlocked = await checkAndUnlockAchievements(
        profile: updatedProfile,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      );

      for (final id in unlocked) {
        Future.delayed(const Duration(milliseconds: 300), () {
          showAchievementToast(context, id);
        });
      }
      return right(unit);
    } catch (e) {
      return left(Failure("Error: \${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateErrorProgress({
    required String lessonId,
    required int questionIndex,
    required bool isCorrect,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      final profile = await localDataSource.getProfileDetails(user.id);
      if (profile == null) {
        return left(Failure("Profile not found"));
      }

      final errorProgress = {...profile.errorProgress};
      final currentLessonErrors =
          Map<int, int>.from(errorProgress[lessonId] ?? {});

      if (isCorrect) {
        final count = (currentLessonErrors[questionIndex] ?? 0) + 1;
        if (count >= 3) {
          currentLessonErrors.remove(questionIndex);
        } else {
          currentLessonErrors[questionIndex] = count;
        }
      } else {
        currentLessonErrors[questionIndex] = 0;
      }

      if (currentLessonErrors.isEmpty) {
        errorProgress.remove(lessonId);
      } else {
        errorProgress[lessonId] = currentLessonErrors;
      }

      final updated = profile.copyWith(errorProgress: errorProgress);
      await localDataSource.updateProfileDetails(updated);
      return right(unit);
    } catch (e) {
      return left(Failure("Error updating error progress: \${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> completeErrorQuiz({
    required int correctAnswers,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      final profile = await localDataSource.getProfileDetails(user.id);
      if (profile == null) {
        return left(Failure("Profile not found"));
      }

      final int xpGain = correctAnswers * 5;
      final today = DateTime.now();
      final todayStr =
          "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

      final updatedXpPerDay = Map<String, double>.from(profile.xpPerDay);
      updatedXpPerDay[todayStr] = (updatedXpPerDay[todayStr] ?? 0) + xpGain;

      final updated = profile.copyWith(
        xp: profile.xp + xpGain,
        level: _calculateLevel(profile.xp + xpGain),
        xpPerDay: updatedXpPerDay,
      );

      await localDataSource.updateProfileDetails(updated);

      final unlocked = await checkAndUnlockErrorAchievement(updated);

      for (final id in unlocked) {
        Future.delayed(const Duration(milliseconds: 300), () {
          final ctx = navigatorKey.currentContext;
          if (ctx != null) {
            showAchievementToast(ctx, id);
            
          }
        });
      }
      return right(unit);
    } catch (e) {
      return left(Failure("Error: \${e.toString()}"));
    }
  }
}

extension ProfileAchievementChecker on ProfileRepositoryImpl {
  Future<List<String>> checkAndUnlockAchievements({
    required UserProfileDetailsModel profile,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    final userId = profile.userId;
    List<String> unlockedNow = [];

    if (!profile.achievements.contains("first_quiz_passed")) {
      await localDataSource.unlockAchievement(userId, "first_quiz_passed");
      unlockedNow.add("first_quiz_passed");
    }

    if (correctAnswers == totalQuestions &&
        !profile.achievements.contains("perfect_quiz_score")) {
      await localDataSource.unlockAchievement(userId, "perfect_quiz_score");
      unlockedNow.add("perfect_quiz_score");
    }

    if ((profile.xp >= 100) && !profile.achievements.contains("xp_100")) {
      await localDataSource.unlockAchievement(userId, "xp_100");
      unlockedNow.add("xp_100");
    }

    if ((profile.completedLessons.length >= 5) &&
        !profile.achievements.contains("lesson_5_completed")) {
      await localDataSource.unlockAchievement(userId, "lesson_5_completed");
      unlockedNow.add("lesson_5_completed");
    }

    return unlockedNow;
  }

  Future<List<String>> checkAndUnlockErrorAchievement(
      UserProfileDetailsModel profile) async {
    List<String> unlockedNow = [];
    if (profile.mistakes == 0 &&
        !profile.achievements.contains("cleared_all_mistakes")) {
      await localDataSource.unlockAchievement(
          profile.userId, "cleared_all_mistakes");
      unlockedNow.add("cleared_all_mistakes");
    }
    return unlockedNow;
  }
}
