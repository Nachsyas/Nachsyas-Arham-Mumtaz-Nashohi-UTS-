import 'package:flutter/foundation.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/data/dummy_data.dart';

class MovieDataService {
  static final ValueNotifier<List<Movie>> allMoviesNotifier =
      ValueNotifier<List<Movie>>([...allForYouMovies]);
  
  static final ValueNotifier<List<Movie>> forYouMoviesNotifier =
      ValueNotifier<List<Movie>>(_getForYouMovies());
  
  static void addMovie(Movie newMovie) {
    final currentList = allMoviesNotifier.value;
    currentList.insert(0, newMovie);
    allMoviesNotifier.value = [...currentList];
    _updateForYouNotifier();
  }

  static void updateMovie(Movie updatedMovie) {
    final currentList = allMoviesNotifier.value;
    final index = currentList.indexWhere((movie) => movie.id == updatedMovie.id);
    if (index != -1) {
      currentList[index] = updatedMovie;
      allMoviesNotifier.value = [...currentList];
      _updateForYouNotifier();
    }
  }

  static void deleteMovie(String movieId) {
    final currentList = allMoviesNotifier.value;
    currentList.removeWhere((movie) => movie.id == movieId);
    allMoviesNotifier.value = [...currentList];
    _updateForYouNotifier();
  }
  
  static List<Movie> _getForYouMovies() {
    return allMoviesNotifier.value.take(8).toList();
  }
  
  static void _updateForYouNotifier() {
    forYouMoviesNotifier.value = _getForYouMovies();
  }
}