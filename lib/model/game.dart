class Game {
  final int id; // [cite: 364]
  final String title; // [cite: 364]
  final String thumbnail; // [cite: 364]
  final String shortDescription; // [cite: 364]
  final String gameUrl; // [cite: 364]
  final String genre; // [cite: 364]
  final String platform; // [cite: 364]
  final String publisher; // [cite: 364]
  final String developer; // [cite: 364]
  final String releaseDate; // [cite: 364]
  final String freetogameProfileUrl; // [cite: 364]

  Game({
    required this.id, // [cite: 364]
    required this.title, // [cite: 364]
    required this.thumbnail, // [cite: 364]
    required this.shortDescription, // [cite: 364]
    required this.gameUrl, // [cite: 364]
    required this.genre, // [cite: 364]
    required this.platform, // [cite: 364]
    required this.publisher, // [cite: 364]
    required this.developer, // [cite: 364]
    required this.releaseDate, // [cite: 364]
    required this.freetogameProfileUrl, // [cite: 364]
  });

  factory Game.fromJson(Map<String, dynamic> json) { // [cite: 365]
    return Game(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      shortDescription: json['short_description'],
      gameUrl: json['game_url'],
      genre: json['genre'],
      platform: json['platform'],
      publisher: json['publisher'],
      developer: json['developer'],
      releaseDate: json['release_date'],
      freetogameProfileUrl: json['freetogame_profile_url'],
    );
  }
}