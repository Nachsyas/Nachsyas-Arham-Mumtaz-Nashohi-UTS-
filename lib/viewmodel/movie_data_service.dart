// Lokasi: lib/viewmodel/movie_data_service.dart

import 'package:flutter/foundation.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/data/dummy_data.dart'; // Import data awal

class MovieDataService {
  // 1. Notifier untuk SEMUA film
  //    Kita mulai dengan data dari allForYouMovies
  static final ValueNotifier<List<Movie>> allMoviesNotifier =
      ValueNotifier<List<Movie>>([...allForYouMovies]); // Buat salinan agar bisa diubah

  // 2. Notifier HANYA untuk film "Untuk Anda" (8 film)
  //    Ini akan otomatis terupdate jika film di allMoviesNotifier dihapus
  static final ValueNotifier<List<Movie>> forYouMoviesNotifier =
      ValueNotifier<List<Movie>>(_getForYouMovies());

  // === METODE CRUD ===

  static void addMovie(Movie newMovie) {
    final currentList = allMoviesNotifier.value;
    // Tambahkan ke paling depan
    currentList.insert(0, newMovie);
    // Update notifier utama
    allMoviesNotifier.value = [...currentList];
    // Update notifier "Untuk Anda"
    _updateForYouNotifier();
  }

  static void updateMovie(Movie updatedMovie) {
    final currentList = allMoviesNotifier.value;
    // Cari index film yang mau diupdate berdasarkan ID
    final index = currentList.indexWhere((movie) => movie.id == updatedMovie.id);
    if (index != -1) { // Jika ditemukan
      currentList[index] = updatedMovie;
      // Update notifier utama
      allMoviesNotifier.value = [...currentList];
      // Update notifier "Untuk Anda"
      _updateForYouNotifier();
    }
  }

  static void deleteMovie(String movieId) {
    final currentList = allMoviesNotifier.value;
    // Hapus film berdasarkan ID
    currentList.removeWhere((movie) => movie.id == movieId);
    // Update notifier utama
    allMoviesNotifier.value = [...currentList];
    // Update notifier "Untuk Anda"
    _updateForYouNotifier();
  }

  // === Helper Methods ===

  // Helper untuk mendapatkan 8 film pertama dari list utama
  static List<Movie> _getForYouMovies() {
    // Ambil maksimal 8 film dari list utama
    return allMoviesNotifier.value.take(8).toList();
  }

  // Helper untuk memperbarui notifier "Untuk Anda"
  static void _updateForYouNotifier() {
    forYouMoviesNotifier.value = _getForYouMovies();
  }
}