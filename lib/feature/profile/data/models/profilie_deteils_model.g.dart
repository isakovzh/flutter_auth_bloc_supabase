// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profilie_deteils_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProfileDetailsModelAdapter extends TypeAdapter<ProfileDetailsModel> {
  @override
  final int typeId = 0;

  @override
  ProfileDetailsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProfileDetailsModel(
      id: fields[0] as String,
      username: fields[1] as String,
      avatarUrl: fields[2] as String,
      level: fields[3] as int,
      xp: fields[4] as int,
      achievements: (fields[5] as List).cast<String>(),
      lessonsCompleted: fields[6] as int,
      mistakes: fields[7] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ProfileDetailsModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.avatarUrl)
      ..writeByte(3)
      ..write(obj.level)
      ..writeByte(4)
      ..write(obj.xp)
      ..writeByte(5)
      ..write(obj.achievements)
      ..writeByte(6)
      ..write(obj.lessonsCompleted)
      ..writeByte(7)
      ..write(obj.mistakes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProfileDetailsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
