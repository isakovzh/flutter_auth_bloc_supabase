import 'package:app/feature/characters/domain/entity/characters.dart';
import 'package:hive/hive.dart';

part 'character_model.g.dart';

@HiveType(typeId:3)
class CharacterModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final String imageUrl;

  @HiveField(4)
  final bool isUnlocked;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isUnlocked,
  });

  factory CharacterModel.fromEntity(CharacterEntity entity) => CharacterModel(
        id: entity.id,
        name: entity.name,
        description: entity.description,
        imageUrl: entity.imageUrl,
        isUnlocked: entity.isUnlocked,
      );

  CharacterEntity toEntity() => CharacterEntity(
        id: id,
        name: name,
        description: description,
        imageUrl: imageUrl,
        isUnlocked: isUnlocked,
      );

  CharacterModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isUnlocked,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
  factory CharacterModel.fromJson(Map<String, dynamic> json) {
  return CharacterModel(
    id: json['id'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    imageUrl: json['imageUrl'] as String,
    isUnlocked: json['isUnlocked'] as bool? ?? false, // по умолчанию false
  );
}
}

