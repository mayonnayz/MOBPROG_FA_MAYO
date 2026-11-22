
class Biome {
  final String name;
  final String id;
  final String dimension;
  final String category;
  final double temperature;
  final String precipitation;
  final List<String> terrainFeatures;
  final List<String> uniqueBlocks;
  final List<String> spawningMobs;
  final List<String> structuresFound;
  final String rarity;
  final String versionAdded;
  final String notes;
  final Map<String, String> colors;

  Biome({
    required this.name,
    required this.id,
    required this.dimension,
    required this.category,
    required this.temperature,
    required this.precipitation,
    required this.terrainFeatures,
    required this.uniqueBlocks,
    required this.spawningMobs,
    required this.structuresFound,
    required this.rarity,
    required this.versionAdded,
    required this.notes,
    required this.colors,
  });

  factory Biome.fromJson(Map<String, dynamic> json) {
    final colorData = json['colors'] ?? {};

    return Biome(
      name: json['name'] ?? '',
      id: json['id'] ?? '',
      dimension: json['dimension'] ?? '',
      category: json['category'] ?? '',
      temperature: (json['temperature'] ?? 0).toDouble(),
      precipitation: json['precipitation'] ?? '',
      terrainFeatures: List<String>.from(
        json['terrainFeatures'] ?? [],
      ),
      uniqueBlocks: List<String>.from(
        json['uniqueBlocks'] ?? [],
      ),
      spawningMobs: List<String>.from(
        json['spawningMobs'] ?? [],
      ),
      structuresFound: List<String>.from(
        json['structuresFound'] ?? [],
      ),
      rarity: json['rarity'] ?? '',
      versionAdded: json['versionAdded'] ?? '',
      notes: json['notes']?.toString() ?? '',
      colors: {
        'grass': colorData['grass']?.toString() ?? '',
        'water': colorData['water']?.toString() ?? '',
        'foliage': colorData['foliage']?.toString() ?? '',
        'sky': colorData['sky']?.toString() ?? '',
      },
    );
  }
}
