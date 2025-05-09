// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_details_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserProfileDetailsModelAdapter
    extends TypeAdapter<UserProfileDetailsModel> {
  @override
  final int typeId = 1;

  @override
  UserProfileDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserProfileDetailsModel(
      userId: fields[0] as String,
      username: fields[1] as String,
      avatarUrl: fields[2] as String,
      xp: fields[3] as int,
      level: fields[4] as int,
      achievements: (fields[5] as List?)?.cast<String>() ?? [],
      lessonsCompleted: fields[6] as int,
      mistakes: fields[7] as int,
      completedLessons: (fields[8] as List?)?.cast<String>() ?? [],
      quizResults: (fields[9] as List?)?.cast<QuizResultEntry>() ?? [],
    );
  }

  @override
  void write(BinaryWriter writer, UserProfileDetailsModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.xp)
      ..writeByte(4)
      ..write(obj.level)
      ..writeByte(5)
      ..write(obj.achievements)
      ..writeByte(6)
      ..write(obj.lessonsCompleted)
      ..writeByte(7)
      ..write(obj.mistakes)
      ..writeByte(8)
      ..write(obj.completedLessons)
      ..writeByte(9)
      ..write(obj.quizResults);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfileDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
