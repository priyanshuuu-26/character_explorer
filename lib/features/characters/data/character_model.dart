class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String imageUrl;
  final int episodeCount;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.imageUrl,
    required this.episodeCount,
  });

  // Factory constructor to create character from JSON
  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      species: json['species'],
      imageUrl: json['image'],
      episodeCount: (json['episode'] as List).length,
    );
  }
}