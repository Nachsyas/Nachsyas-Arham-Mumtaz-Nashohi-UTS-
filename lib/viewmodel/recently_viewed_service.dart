
// Lokasi: lib/viewmodel/recently_viewed_service.dart

import 'package:flutter/foundation.dart';
import 'package:myapp/model/movie_model.dart'; // Sesuaikan path ke model Anda

class RecentlyViewedService {
  // ValueNotifier akan "memberi tahu" widget jika datanya berubah
  static final ValueNotifier<List<Movie>> recentlyViewedNotifier =
      ValueNotifier<List<Movie>>([]);

  // Panggil method ini saat user membuka film
  static void addMovie(Movie movie) {
    // Ambil daftar yang ada saat ini
    final list = recentlyViewedNotifier.value;

    // Cek apakah film sudah ada di daftar
    if (list.contains(movie)) {
      // Jika sudah ada, hapus dari posisi lama
      list.remove(movie);
    }
    
    // Tambahkan film ke posisi paling depan (paling baru)
    list.insert(0, movie);

    // Update notifier dengan list baru
    // Kita buat list baru [...list] agar notifier mendeteksi perubahan
    recentlyViewedNotifier.value = [...list];
  }
}