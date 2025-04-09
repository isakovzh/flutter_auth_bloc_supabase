import 'dart:convert';
import 'package:app/feature/lesson/data/model/lesson_model.dart';
import 'package:app/feature/lesson/domain/entities/lesson.dart';
import 'package:flutter/services.dart';

abstract interface class LessonLocalDataSource {
  Future<List<LessonEntity>> loadLessons();
}

class LessonLocalDataSourceImpl implements LessonLocalDataSource {
  @override
  Future<List<LessonEntity>> loadLessons() async {
    final jsonString = await rootBundle.loadString('assets/json/lessons.json');
    final List<dynamic> jsonList = json.decode(jsonString);


    return jsonList.map((json) => LessonModel.fromJson(json)).toList();
  }
}
