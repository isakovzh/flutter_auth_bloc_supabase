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
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<LessonBloc>()..add(LoadLessonsEvent())),
        BlocProvider(
            create: (_) =>
                sl<ProfileBloc>()..add(const GetProfileDetailsEvent())),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lessons'),
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
                              Text("XP: $totalXP",
                                  style: theme.textTheme.bodyLarge),
                              Text(
                                "Lessons Completed: $completedCount / ${lessons.length}",
                                style: theme.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: progress,
                                backgroundColor: theme.dividerColor,
                                color: theme.colorScheme.primary,
                                minHeight: 10,
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
                                    color: Colors.red.shade50,
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
                                              const Icon(Icons.error_outline,
                                                  color: Colors.red),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Text(
                                                  'Error Quiz',
                                                  style: theme
                                                      .textTheme.titleMedium
                                                      ?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red.shade700,
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                '${preparedErrorQuestions.length} questions',
                                                style:
                                                    theme.textTheme.bodySmall,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Practice your mistakes to improve!',
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                              color: theme
                                                  .textTheme.bodySmall?.color
                                                  ?.withOpacity(0.7),
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
                                                const Text('Start Error Quiz'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.red.shade600,
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
                                    ? Colors.green.shade100
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
                                          Expanded(
                                            child: Text(
                                              lesson.title,
                                              style: theme.textTheme.titleMedium
                                                  ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (isCompleted)
                                            Row(
                                              children: [
                                                Icon(
                                                  correctAnswers ==
                                                          totalQuestions
                                                      ? Icons.check_circle
                                                      : Icons
                                                          .check_circle_outline,
                                                  color: correctAnswers ==
                                                          totalQuestions
                                                      ? Colors.green
                                                      : Colors.orange,
                                                ),
                                                const SizedBox(width: 6),
                                                Text(
                                                  '$correctAnswers/$totalQuestions correct',
                                                  style: theme
                                                      .textTheme.bodySmall
                                                      ?.copyWith(
                                                    color: correctAnswers ==
                                                            totalQuestions
                                                        ? Colors.green.shade700
                                                        : Colors
                                                            .orange.shade700,
                                                  ),
                                                ),
                                              ],
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
                                          ElevatedButton.icon(
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
                                            label: const Text("Open"),
                                          ),
                                          const SizedBox(width: 10),
                                          ElevatedButton.icon(
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
                                                  ? "Retake Quiz"
                                                  : "Take Quiz",
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isCompleted
                                                  ? Colors.green.shade600
                                                  : null,
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
                  'Error: ${lessonState.message}',
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
