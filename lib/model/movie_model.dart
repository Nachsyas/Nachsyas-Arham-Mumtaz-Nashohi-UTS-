class Movie {
  final String id;
  final String title;
  final String posterURL;
  
  final String synopsis;
  final double rating;

  const Movie({
    required this.id,
    required this.title,
    required this.posterURL,
    this.synopsis = 'Sinopsis film belum tersedia.',
    this.rating = 0.0,
  });
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Movie && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}