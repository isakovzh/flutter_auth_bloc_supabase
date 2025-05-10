import 'package:app/core/error/failure.dart';
import 'package:app/feature/profile/data/model/quiz_result_entry.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app/feature/profile/data/datacources/profile_local_datasource.dart';
import 'package:app/feature/profile/data/model/user_profile_details_model.dart';
import 'package:app/feature/profile/domain/entties/user_proflie.dart';
import 'package:app/feature/profile/domain/repository/profile_details_repository.dart';

// class ProfileRepositoryImpl implements ProfileRepository {
//   final ProfileLocalDataSource localDataSource;
//   final SupabaseClient supabase;

//   ProfileRepositoryImpl(this.localDataSource, this.supabase);

//   @override
//   Future<Either<Failure, UserProfileDetailsEntity>> getProfileDetails() async {
//     try {
//       final user = supabase.auth.currentUser;

//       if (user == null) {
//         return left(Failure("Пользователь не авторизован"));
//       }

//       final userId = user.id;
//       final localProfile = await localDataSource.getProfileDetails(userId);

//       if (localProfile != null) {
//         return right(localProfile.toEntity());
//       }

//       // Если профиль не найден — создаём новый
//       final newProfile = UserProfileDetailsModel(
//         userId: userId,
//         username: user.userMetadata?['name'] ?? 'Unnamed',
//         avatarUrl:
//             'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQVrQvJV3oC7yD2UTGgiq1rSVCHpMFAetEnIg&s',
//         xp: 0,
//         level: 1,
//         achievements: [],
//         lessonsCompleted: 0,
//         mistakes: 0,
//         completedLessons: [],
//       );

//       await localDataSource.saveProfile(newProfile);
//       return right(newProfile.toEntity());
//     } catch (e) {
//       return left(Failure("Ошибка при получении профиля: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateProfileDetails(
//       UserProfileDetailsEntity entity) async {
//     try {
//       final model = UserProfileDetailsModel.fromEntity(entity);
//       await localDataSource.updateProfileDetails(model);
//       return right(unit);
//     } catch (e) {
//       return left(Failure("Ошибка при обновлении профиля: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> clearProfileDetails() async {
//     try {
//       final user = supabase.auth.currentUser;
//       if (user != null) {
//         await localDataSource.clearProfileDetails(user.id);
//       }
//       return right(unit);
//     } catch (e) {
//       return left(Failure("Ошибка при удалении профиля: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> markLessonAsCompleted(String lessonId) async {
//     try {
//       final user = supabase.auth.currentUser;
//       if (user == null) {
//         return left(Failure("User not authenticated"));
//       }

//       final localProfile = await localDataSource.getProfileDetails(user.id);
//       if (localProfile == null) {
//         return left(Failure("Profile not found"));
//       }

//       if (!localProfile.completedLessons.contains(lessonId)) {
//         localProfile.completedLessons.add(lessonId);
//         await localDataSource.updateProfileDetails(localProfile);
//       }

//       return right(unit);
//     } catch (e) {
//       return left(
//           Failure("Error marking lesson as completed: ${e.toString()}"));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> addQuizResult({
//     required String lessonId,
//     required int correctAnswers,
//     required int totalQuestions,
//   }) async {
//     try {
//       final user = supabase.auth.currentUser;
//       if (user == null) {
//         return left(Failure("Пользователь не авторизован"));
//       }

//       final profile = await localDataSource.getProfileDetails(user.id);

//       if (profile == null) {
//         return left(Failure("Профиль не найден"));
//       }

//       // Проверка, завершён ли уже урок
//       if (profile.completedLessons.contains(lessonId)) {
//         return right(unit); // Уже завершён — ничего не делаем
//       }

//       // Вычисляем XP за тест
//       final xpEarned = ((correctAnswers / totalQuestions) * 100).round();

//       final updatedProfile = profile.copyWith(
//         xp: profile.xp + xpEarned,
//         lessonsCompleted: profile.lessonsCompleted + 1,
//         completedLessons: [...profile.completedLessons, lessonId],
//       );

//       await localDataSource.updateProfileDetails(updatedProfile);

//       return right(unit);
//     } catch (e) {
//       return left(Failure("Ошибка при добавлении результата: ${e.toString()}"));
//     }
//   }
// }

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileLocalDataSource localDataSource;
  final SupabaseClient supabase;

  ProfileRepositoryImpl(this.localDataSource, this.supabase);

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
      );
      await localDataSource.saveProfile(newProfile);
      return right(newProfile.toEntity());
    } catch (e) {
      return left(Failure("Error: ${e.toString()}"));
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
      return left(Failure("Error: ${e.toString()}"));
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
      return left(Failure("Error: ${e.toString()}"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addQuizResult({
    required String lessonId,
    required int correctAnswers,
    required int totalQuestions,
  }) async {
    try {
      final user = supabase.auth.currentUser;
      if (user == null) {
        return left(Failure("User not authenticated"));
      }

      // 1️⃣ Получаем профиль из локальной базы (Hive)
      final profile = await localDataSource.getProfileDetails(user.id);
      if (profile == null) {
        return left(Failure("Profile not found"));
      }

      // 2️⃣ Ищем старый результат по этому уроку
      final oldResult = profile.quizResults.firstWhere(
        (e) => e.lessonId == lessonId,
        orElse: () => QuizResultEntry(lessonId: '', correctAnswers: 0),
      );

      final bool hasOldResult = oldResult.lessonId.isNotEmpty;
      final int oldCorrectAnswers = hasOldResult ? oldResult.correctAnswers : 0;

      // 3️⃣ Проверка: если новый результат не лучше старого — ничего не делаем
      if (correctAnswers <= oldCorrectAnswers) {
        return right(unit);
      }

      // 4️⃣ Вычисляем XP за улучшение результата
      final diff = correctAnswers - oldCorrectAnswers;
      final xpGain = ((diff / totalQuestions) * 100).round();

      // 5️⃣ Обновляем список результатов
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

      // 6️⃣ Обновляем профиль
      final updatedProfile = profile.copyWith(
        xp: profile.xp + xpGain,
        quizResults: updatedResults,
        completedLessons: profile.completedLessons.contains(lessonId)
            ? profile.completedLessons
            : [...profile.completedLessons, lessonId],
      );

      await localDataSource.updateProfileDetails(updatedProfile);
      return right(unit);
    } catch (e) {
      return left(Failure("Error: ${e.toString()}"));
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
      return left(Failure("Error updating error progress: ${e.toString()}"));
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

      final updated = profile.copyWith(
        xp: profile.xp + xpGain,
      );

      await localDataSource.updateProfileDetails(updated);

      return right(unit);
    } catch (e) {
      return left(Failure("Error: ${e.toString()}"));
    }
  }
}
