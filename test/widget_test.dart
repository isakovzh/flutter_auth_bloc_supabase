// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}

 
 
  // final today = DateTime.now();
  //     final todayStr =
  //         "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";

  //     final updatedXpPerDay = Map<String, double>.from(profile.xpPerDay);
  //     updatedXpPerDay[todayStr] = (updatedXpPerDay[todayStr] ?? 0) + xpGain;

      //   userId: fields[0] as String,
      // username: fields[1] as String,
      // avatarUrl: fields[2] as String,
      // xp: fields[3] as int,
      // level: fields[4] as int,
      // achievements: (fields[5] as List?)?.cast<String>() ?? [],
      // lessonsCompleted: fields[6] as int,
      // mistakes: fields[7] as int,
      // completedLessons: (fields[8] as List?)?.cast<String>() ?? [],
      // quizResults: (fields[9] as List?)?.cast<QuizResultEntry>() ?? [],
      // errorProgress: (fields[10] as Map?)?.map((dynamic k, dynamic v) =>
      //         MapEntry(k as String, (v as Map).cast<int, int>())) ??
      //     {},
      // xpPerDay: (fields[11] is Map)
      //     ? (fields[11] as Map)
      //         .map((key, value) => MapEntry(key.toString(), value as double))
      //     : {},