class CharacterEntity {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool isUnlocked;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.isUnlocked,
  });

  CharacterEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    bool? isUnlocked,
  }) {
    return CharacterEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}
