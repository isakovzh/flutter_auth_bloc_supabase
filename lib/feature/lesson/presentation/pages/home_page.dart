import 'package:app/core/common/init/init_auth_dependencies.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_bloc.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_event.dart';
import 'package:app/feature/lesson/presentation/bloc/lesson_state.dart';
import 'package:app/feature/lesson/presentation/pages/lesson_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<LessonBloc>()..add(LoadLessonsEvent()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lessons'),
        ),
        body: BlocBuilder<LessonBloc, LessonState>(
          builder: (context, state) {
            if (state is LessonLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is LessonLoaded) {
              final lessons = state.lessons;

              // ✅ Пример завершённых уроков
              final completedLessons = ['lesson_1', 'lesson_2'];
              final completedCount = lessons
                  .where((lesson) => completedLessons.contains(lesson.id))
                  .length;
              final totalXP = completedCount * 100;
              final progress =
                  lessons.isEmpty ? 0.0 : completedCount / lessons.length;

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    // 🔄 Progress bar
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.brown.shade50,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("XP: $totalXP",
                              style: const TextStyle(fontSize: 18)),
                          Text(
                              "Lessons Completed: $completedCount / ${lessons.length}"),
                          const SizedBox(height: 10),
                          LinearProgressIndicator(
                            value: progress,
                            backgroundColor: Colors.grey[300],
                            color: Colors.brown,
                            minHeight: 10,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // 📚 Cards
                    Expanded(
                      child: ListView.builder(
                        itemCount: lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = lessons[index];
                          final isCompleted =
                              completedLessons.contains(lesson.id);

                          return Card(
                            elevation: 3,
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    lesson.title,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    lesson.description,
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      ElevatedButton.icon(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => LessonDetailPage(
                                                  lesson: lesson),
                                            ),
                                          );
                                        },
                                        icon: const Icon(Icons.menu_book),
                                        label: const Text("Open"),
                                      ),
                                      const SizedBox(width: 10),
                                      if (isCompleted)
                                        ElevatedButton.icon(
                                          onPressed: () {
                                            // TODO: Quiz page
                                          },
                                          icon: const Icon(Icons.check),
                                          label: const Text("Test"),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                Colors.green.shade600,
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
            }

            if (state is LessonError) {
              return Center(child: Text('Error: ${state.message}'));
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
