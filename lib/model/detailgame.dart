import 'package:json_annotation/json_annotation.dart'; // [cite: 400]

part 'detailgame.g.dart'; // [cite: 401]

@JsonSerializable()
class MinimumSystemRequirements {
  final String os; // [cite: 409]
  final String processor; // [cite: 411]
  final String memory; // [cite: 413]
  final String graphics; // [cite: 415]
  final String storage; // [cite: 417]

  MinimumSystemRequirements({
    required this.os, // [cite: 422]
    required this.processor, // [cite: 424]
    required this.memory, // [cite: 427]
    required this.graphics, // [cite: 428]
    required this.storage, // [cite: 430]
  });

  factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json) =>
      _$MinimumSystemRequirementsFromJson(json);
  Map<String, dynamic> toJson() => _$MinimumSystemRequirementsToJson(this);
}

@JsonSerializable()
class Screenshot {
  final int id; // [cite: 446]
  final String image; // [cite: 448]

  Screenshot({required this.id, required this.image}); // [cite: 451]

  factory Screenshot.fromJson(Map<String, dynamic> json) =>
      _$ScreenshotFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenshotToJson(this);
}

@JsonSerializable()
class DetailGame {
  final int id;
  final String title;
  final String thumbnail;
  final String status;
  final String short_description;
  final String description;
  final String game_url;
  final String genre;
  final String platform;
  final String publisher;
  final String developer;
  final String release_date;
  final String freetogame_profile_url;
  final MinimumSystemRequirements minimum_system_requirements;
  final List<Screenshot> screenshots;

  DetailGame({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.status,
    required this.short_description,
    required this.description,
    required this.game_url,
    required this.genre,
    required this.platform,
    required this.publisher,
    required this.developer,
    required this.release_date,
    required this.freetogame_profile_url,
    required this.minimum_system_requirements,
    required this.screenshots,
  });

  factory DetailGame.fromJson(Map<String, dynamic> json) =>
      _$DetailGameFromJson(json);
  Map<String, dynamic> toJson() => _$DetailGameToJson(this);
}