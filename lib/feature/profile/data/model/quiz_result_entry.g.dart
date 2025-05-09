// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_result_entry.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class QuizResultEntryAdapter extends TypeAdapter<QuizResultEntry> {
  @override
  final int typeId = 2;

  @override
  QuizResultEntry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizResultEntry(
      lessonId: fields[0] as String,
      correctAnswers: fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, QuizResultEntry obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.lessonId)
      ..writeByte(1)
      ..write(obj.correctAnswers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizResultEntryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
