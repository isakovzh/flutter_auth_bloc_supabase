import 'package:app/core/common/init/init_auth_dependencies.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_bloc.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_event.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_state.dart';
import 'package:app/feature/lesson/presentation/pages/lesson_details_page.dart';
import 'package:app/feature/lesson/presentation/pages/quiz_page.dart';
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

                  if (profileState is ProfileLoaded) {
                    completedLessons = profileState.profile.completedLessons;
                   quizResults = profileState.profile.quizResults;
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

                        // Lessons list
                        Expanded(
                          child: ListView.builder(
                            itemCount: lessons.length,
                            itemBuilder: (context, index) {
                              final lesson = lessons[index];
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
                                              );
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
                                              );
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
