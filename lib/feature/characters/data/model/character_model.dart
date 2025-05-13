import 'package:hive/hive.dart';
import 'package:app/feature/characters/domain/entity/characters.dart';

part 'character_model.g.dart';

@HiveType(typeId: 3)
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

  @HiveField(5)
  final String userId;

  CharacterModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isUnlocked,
    required this.userId,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json, String userId) {
    return CharacterModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      isUnlocked: json['isUnlocked'] ?? false,
      userId: userId,
    );
  }

  factory CharacterModel.fromEntity(CharacterEntity entity, String userId) {
    return CharacterModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      imageUrl: entity.imageUrl,
      isUnlocked: entity.isUnlocked,
      userId: userId,
    );
  }

  CharacterEntity toEntity() {
    return CharacterEntity(
      id: id,
      name: name,
      description: description,
      imageUrl: imageUrl,
      isUnlocked: isUnlocked,
    );
  }

  CharacterModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isUnlocked,
    String? userId,
  }) {
    return CharacterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      userId: userId ?? this.userId,
    );
  }
}
