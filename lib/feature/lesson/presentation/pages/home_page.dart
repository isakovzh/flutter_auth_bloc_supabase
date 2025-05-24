// ignore_for_file: use_build_context_synchronously

import 'dart:math';
import 'package:app/core/common/init/init_auth_dependencies.dart';
import 'package:app/feature/lesson/domain/entities/eroor_quiesttion.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_bloc.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_event.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_state.dart';
import 'package:app/feature/lesson/presentation/pages/lesson_details_page.dart';
import 'package:app/feature/lesson/presentation/pages/quiz_page.dart';
import 'package:app/feature/lesson/presentation/pages/error_quiz_page.dart';
import 'package:app/feature/profile/presentation/bloc/profile_bloc.dart';
import 'package:app/core/theme/language_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/l10n/app_localizations.dart';
import 'package:app/core/theme/theme.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final customColors = theme.extension<CustomColors>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LessonBloc(
            getAllLessons: sl(),
            languageCubit: context.read<LanguageCubit>(),
          )..add(LoadLessonsEvent()),
        ),
        BlocProvider(
            create: (_) =>
                sl<ProfileBloc>()..add(const GetProfileDetailsEvent())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.lessons),
        ),
        body: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, lessonState) {
            if (lessonState is LessonLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (lessonState is LessonLoaded) {
              final lessons = lessonState.lessons;

              return BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, profileState) {
                  Map<String, int> quizResults = {};
                  List<String> completedLessons = [];
                  List<ErrorQuestion> preparedErrorQuestions = [];

                  if (profileState is ProfileLoaded) {
                    completedLessons = profileState.profile.completedLessons;
                    quizResults = profileState.profile.quizResults;

                    // 🔥 Подготавливаем Error Questions здесь
                    final errorProgress = profileState.profile.errorProgress;
                    final allErrorQuestions = <ErrorQuestion>[];
                    // print(profileState.profile.errorProgress);

                    for (final lesson in lessons) {
                      final errorMap = errorProgress[lesson.id];
                      if (errorMap != null) {
                        errorMap.forEach((questionIndex, attemptCount) {
                          final question = lesson.quiz.questions[questionIndex];
                          allErrorQuestions.add(
                            ErrorQuestion(
                              lessonId: lesson.id,
                              questionIndex: questionIndex,
                              questionText: question.question,
                              options: question.options,
                              correctIndex: question.correctIndex,
                            ),
                          );
                        });
                      }
                    }

                    allErrorQuestions.shuffle(Random());
                    preparedErrorQuestions = allErrorQuestions.take(5).toList();
                    // print('hell');
                    // print(profileState.profile.xpPerDay);
                  }

                  final completedCount = completedLessons.length;
                  final totalXP = profileState is ProfileLoaded
                      ? profileState.profile.xp
                      : 0;
                  final progress =
                      lessons.isEmpty ? 0.0 : completedCount / lessons.length;

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        // Progress block
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(l10n.xpPoints(totalXP.toString()),
                                  style: theme.textTheme.bodyLarge),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    l10n.lessonsCompleted(completedCount),
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                  Text(
                                    " / ${lessons.length}",
                                    style: theme.textTheme.bodyMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: theme
                                    .progressIndicatorTheme.linearTrackColor,
                                color: theme.progressIndicatorTheme.color,
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Lessons list + Error Quiz card
                        Expanded(
                          child: ListView.builder(
                            itemCount: lessons.length + 1, // +1 for Error Quiz
                            itemBuilder: (context, index) {
                              // Error Quiz card at index 0
                              if (index == 0) {
                                if (preparedErrorQuestions.length >= 5) {
                                  return Card(
                                    color: customColors?.errorCard,
                                    elevation: 3,
                                    margin: const EdgeInsets.only(bottom: 16),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(Icons.error_outline,
                                                  color:
                                                      customColors?.errorText),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  l10n.errorQuizTitle,
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        customColors?.errorText,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${preparedErrorQuestions.length} questions',
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  color: customColors?.errorText
                                                      .withOpacity(0.8),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            l10n.errorQuizDesc,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color: customColors?.errorText
                                                  .withOpacity(0.7),
                                            ),
                                          ),
                                          const SizedBox(height: 12),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (_) => ErrorQuizPage(
                                                    errorQuestions:
                                                        preparedErrorQuestions,
                                                  ),
                                                ),
                                              ).then((_) {
                                                context.read<ProfileBloc>().add(
                                                    const GetProfileDetailsEvent());
                                              });
                                            },
                                            icon: const Icon(Icons.play_arrow),
                                            label:
                                                Text(l10n.errorQuizStartButton),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  customColors?.errorText,
                                              foregroundColor:
                                                  customColors?.errorCard,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return const SizedBox.shrink();
                                }
                              }

                              // Regular lessons (index - 1)
                              final lesson = lessons[index - 1];
                              final isCompleted =
                                  completedLessons.contains(lesson.id);
                              final correctAnswers =
                                  quizResults[lesson.id] ?? 0;
                              final totalQuestions =
                                  lesson.quiz.questions.length;

                              return Card(
                                color: isCompleted
                                    ? customColors?.lessonCardCompleted
                                    : theme.cardColor,
                                elevation: 3,
                                margin: const EdgeInsets.only(bottom: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            isCompleted
                                                ? Icons.check_circle
                                                : Icons.circle_outlined,
                                            color: isCompleted
                                                ? customColors?.lessonCardText
                                                : theme.iconTheme.color,
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              lesson.title,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                color: isCompleted
                                                    ? customColors
                                                        ?.lessonCardText
                                                    : theme.textTheme
                                                        .titleMedium?.color,
                                              ),
                                            ),
                                          ),
                                          if (isCompleted)
                                            Text(
                                              l10n.correctAnswersCount(
                                                  correctAnswers,
                                                  totalQuestions),
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: customColors
                                                    ?.lessonCardText
                                                    .withOpacity(0.8),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        lesson.description,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme
                                              .textTheme.bodySmall?.color
                                              ?.withOpacity(0.7),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        LessonDetailPage(
                                                            lesson: lesson),
                                                  ),
                                                ).then((_) {
                                                  context.read<ProfileBloc>().add(
                                                      const GetProfileDetailsEvent());
                                                });
                                              },
                                              icon: const Icon(Icons.menu_book),
                                              label: Text(l10n.open),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) => QuizPage(
                                                      lesson: lesson,
                                                    ),
                                                  ),
                                                ).then((_) {
                                                  context.read<ProfileBloc>().add(
                                                      const GetProfileDetailsEvent());
                                                });
                                              },
                                              icon: const Icon(Icons.quiz),
                                              label: Text(
                                                isCompleted
                                                    ? l10n.retakeQuiz
                                                    : l10n.takeQuiz,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: isCompleted
                                                    ? customColors
                                                        ?.lessonCardText
                                                    : theme.elevatedButtonTheme
                                                        .style?.backgroundColor
                                                        ?.resolve({}),
                                                foregroundColor: isCompleted
                                                    ? customColors
                                                        ?.lessonCardCompleted
                                                    : theme.elevatedButtonTheme
                                                        .style?.foregroundColor
                                                        ?.resolve({}),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }

            if (lessonState is LessonError) {
              return Center(
                child: Text(
                  l10n.error(lessonState.message),
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
