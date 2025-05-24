import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:app/feature/lesson/presentation/pages/quiz_page.dart';
import 'package:flutter/material.dart';
import 'package:app/l10n/app_localizations.dart';

class LessonDetailPage extends StatelessWidget {
  final LessonEntity lesson;

  const LessonDetailPage({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Урок
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      lesson.content,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Кнопка "Start Quiz"
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(lesson: lesson),
                  ),
                );
              },
              icon: const Icon(Icons.quiz),
              label: Text(l10n.startQuiz),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'user_profile_details_model.dart';

// // **************************************************************************
// // TypeAdapterGenerator
// // **************************************************************************

// class UserProfileDetailsModelAdapter
//     extends TypeAdapter<UserProfileDetailsModel> {
//   @override
//   final int typeId = 1;

//   @override
//   UserProfileDetailsModel read(BinaryReader reader) {
//     final numOfFields = reader.readByte();
//     final fields = <int, dynamic>{
//       for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
//     };
//     return UserProfileDetailsModel(
//       userId: fields[0] as String,
//       username: fields[1] as String,
//       avatarUrl: fields[2] as String,
//       xp: fields[3] as int,
//       level: fields[4] as int,
//       achievements: (fields[5] as List?)?.cast<String>() ?? [],
//       lessonsCompleted: fields[6] as int,
//       mistakes: fields[7] as int,
//       completedLessons: (fields[8] as List?)?.cast<String>() ?? [],
//     );
//   }

//   @override
//   void write(BinaryWriter writer, UserProfileDetailsModel obj) {
//     writer
//       ..writeByte(9)
//       ..writeByte(0)
//       ..write(obj.userId)
//       ..writeByte(1)
//       ..write(obj.username)
//       ..writeByte(2)
//       ..write(obj.avatarUrl)
//       ..writeByte(3)
//       ..write(obj.xp)
//       ..writeByte(4)
//       ..write(obj.level)
//       ..writeByte(5)
//       ..write(obj.achievements)
//       ..writeByte(6)
//       ..write(obj.lessonsCompleted)
//       ..writeByte(7)
//       ..write(obj.mistakes)
//       ..writeByte(8)
//       ..write(obj.completedLessons);
//   }

//   @override
//   int get hashCode => typeId.hashCode;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is UserProfileDetailsModelAdapter &&
//           runtimeType == other.runtimeType &&
//           typeId == other.typeId;
// }
