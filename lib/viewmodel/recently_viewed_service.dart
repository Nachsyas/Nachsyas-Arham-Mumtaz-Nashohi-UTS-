import 'package:flutter/foundation.dart';
import 'package:myapp/model/movie_model.dart';

class RecentlyViewedService {
  static final ValueNotifier<List<Movie>> recentlyViewedNotifier =
      ValueNotifier<List<Movie>>([]);

  static void addMovie(Movie movie) {
    final list = recentlyViewedNotifier.value;
    
    if (list.contains(movie)) {
      list.remove(movie);
    }
    list.insert(0, movie);
    recentlyViewedNotifier.value = [...list];
  }
}