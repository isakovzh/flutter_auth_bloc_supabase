import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final List<Map<String, dynamic>> lessons = const [
    {
      'title': 'Lesson 1: The Birth of Manas',
      'isCompleted': true,
    },
    {
      'title': 'Lesson 2: The Childhood',
      'isCompleted': true,
    },
    {
      'title': 'Lesson 3: Becoming a Hero',
      'isCompleted': false,
    },
  ];

  final int xp = 850;
  final int completed = 2;
  final int totalLessons = 10;

  @override
  Widget build(BuildContext context) {
    final double progress = completed / totalLessons;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lessons'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 👤 Progress Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.brown.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("XP: $xp", style: const TextStyle(fontSize: 18)),
                  Text("Lessons Completed: $completed / $totalLessons"),
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

            // 📚 Lesson Cards
            Expanded(
              child: ListView.builder(
                itemCount: lessons.length,
                itemBuilder: (context, index) {
                  final lesson = lessons[index];
                  return Card(
                    elevation: 4,
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
                            lesson['title'],
                            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  // TODO: open lesson
                                },
                                icon: const Icon(Icons.menu_book),
                                label: const Text("Open"),
                              ),
                              const SizedBox(width: 10),
                              if (lesson['isCompleted'])
                                ElevatedButton.icon(
                                  onPressed: () {
                                    // TODO: take test
                                  },
                                  icon: const Icon(Icons.check),
                                  label: const Text("Test"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green.shade600,
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
      ),
    );
  }
}
