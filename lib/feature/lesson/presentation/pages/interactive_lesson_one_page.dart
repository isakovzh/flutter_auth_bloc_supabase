import 'package:flutter/material.dart';
import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/lesson/presentation/pages/quiz_page.dart';
import 'dart:math';

class InteractiveLessonOnePage extends StatefulWidget {
  final LessonEntity lesson;

  const InteractiveLessonOnePage({super.key, required this.lesson});

  @override
  State<InteractiveLessonOnePage> createState() =>
      _InteractiveLessonOnePageState();
}

class _InteractiveLessonOnePageState extends State<InteractiveLessonOnePage> {
  int currentStep = -1;
  String? droppedWord;
  bool showFeedback = false;
  bool isCorrect = false;

  final List<Map<String, dynamic>> steps = [
    {
      'text':
          'Manas was born in the region of ______, a place known for its rich land and strong traditions.',
      'correct': 'Talas'
    },
    {
      'text':
          'His birth took place during a time of great ______ for the Kyrgyz people.',
      'correct': 'suffering'
    },
    {
      'text':
          'At the moment of his birth, a bright and unusual ______ appeared in the sky.',
      'correct': 'star'
    },
    {
      'text':
          'This star symbolized ______ and renewal, something the people desperately needed.',
      'correct': 'hope'
    },
    {
      'text': "Manas's father was named ______, a respected and wise man.",
      'correct': 'Jakyp'
    },
    {
      'text': 'When Manas was born, people across the region ______ with joy.',
      'correct': 'celebrated'
    },
    {
      'text':
          'They believed Manas would one day ______ and protect the Kyrgyz tribes.',
      'correct': 'unite'
    },
  ];

  void checkAnswer() {
    final correct = steps[currentStep]['correct'].toString().toLowerCase();
    setState(() {
      showFeedback = true;
      isCorrect = droppedWord?.toLowerCase() == correct;
    });
  }

  void nextStep() {
    if (currentStep < steps.length - 1) {
      setState(() {
        currentStep++;
        droppedWord = null;
        showFeedback = false;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => QuizPage(lesson: widget.lesson)),
      );
    }
  }

  List<String> generateOptions(String correct) {
    final all = [
      'Talas',
      'suffering',
      'star',
      'hope',
      'Jakyp',
      'celebrated',
      'unite',
      'freedom',
      'joy',
      'light',
      'river',
      'sky'
    ];
    all.remove(correct);
    all.shuffle();
    final options = all.take(3).toList();
    options.add(correct);
    options.shuffle();
    return options;
  }

  Color getBlankColor() {
    if (droppedWord == null) return Colors.grey.shade300;
    if (isCorrect) return Colors.green.shade300;
    return Colors.red.shade300;
  }

  @override
  Widget build(BuildContext context) {
    if (currentStep == -1) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.lesson.title)),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.lesson.title,
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxHeight: 220),
                  child: Image.asset('assets/images/manas_baby.png',
                      fit: BoxFit.contain),
                ),
                const SizedBox(height: 16),
                Text(
                  widget.lesson.description,
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  widget.lesson.content.length > 300
                      ? widget.lesson.content.substring(0, 300) + '...'
                      : widget.lesson.content,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () => setState(() => currentStep = 0),
                  child: const Text("Start Lesson"),
                )
              ],
            ),
          ),
        ),
      );
    }

    final step = steps[currentStep];
    final correctWord = step['correct'];
    final options = generateOptions(correctWord);

    return Scaffold(
      appBar: AppBar(title: Text(widget.lesson.title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DragTarget<String>(
                onAccept: (data) {
                  setState(() {
                    droppedWord = data;
                  });
                  checkAnswer();
                },
                builder: (context, candidateData, rejectedData) {
                  final split = step['text'].toString().split("______");
                  return Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 4,
                    runSpacing: 8,
                    children: [
                      Text(split[0], style: const TextStyle(fontSize: 20)),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: getBlankColor(),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          droppedWord ?? "______",
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (split.length > 1)
                        Text(split[1], style: const TextStyle(fontSize: 20)),
                    ],
                  );
                },
              ),
              const SizedBox(height: 30),
              Wrap(
                spacing: 12,
                children: options.map((word) {
                  return Draggable<String>(
                    data: word,
                    feedback: Material(
                      color: Colors.transparent,
                      child: Chip(
                          label:
                              Text(word, style: const TextStyle(fontSize: 16))),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.4,
                      child: Chip(label: Text(word)),
                    ),
                    child: Chip(label: Text(word)),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              if (showFeedback)
                Text(
                  isCorrect ? '✅ Correct!' : '❌ Try again.',
                  style: TextStyle(
                    fontSize: 16,
                    color: isCorrect ? Colors.green : Colors.red,
                  ),
                ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: isCorrect ? nextStep : null,
                child: Text(
                    currentStep == steps.length - 1 ? "Go to Quiz" : "Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
