import 'dart:convert';
import 'package:app/feature/lesson/data/model/lesson_model.dart';
import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:flutter/services.dart';

abstract interface class LessonLocalDataSource {
  Future<List<LessonEntity>> loadLessons(String languageCode);
}

class LessonLocalDataSourceImpl implements LessonLocalDataSource {
  @override
  Future<List<LessonEntity>> loadLessons(String languageCode) async {
    try {
      final assetPath = 'assets/json/locales/$languageCode/lessons.json';
      print('Loading lessons from: $assetPath'); // Debug log

      final jsonString = await rootBundle.loadString(assetPath);
      if (jsonString.isEmpty) {
        throw Exception('Empty lessons file');
      }

      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => LessonModel.fromJson(json)).toList();
    } catch (e) {
      print('Error loading lessons for $languageCode: $e'); // Debug log

      // Fallback to English if the requested language file doesn't exist
      if (languageCode != 'en') {
        print('Falling back to English lessons'); // Debug log
        return loadLessons('en');
      }

      // If English fails, try loading from the old location
      try {
        print('Trying to load from fallback location'); // Debug log
        final jsonString =
            await rootBundle.loadString('assets/json/lessons.json');
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => LessonModel.fromJson(json)).toList();
      } catch (e) {
        print('Failed to load from fallback location: $e'); // Debug log
        throw Exception('Failed to load lessons from any location');
      }
    }
  }
}
