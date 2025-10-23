// Lokasi: lib/screens/movie_management_screen.dart

import 'package:flutter/material.dart';
// Hapus import dummy_data
// import 'package:myapp/data/dummy_data.dart'; 
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/screens/add_edit_movie_screen.dart'; 
import 'package:myapp/viewmodel/movie_data_service.dart'; // <-- IMPORT SERVICE BARU

class MovieManagementScreen extends StatefulWidget {
  const MovieManagementScreen({super.key});

  @override
  State<MovieManagementScreen> createState() => _MovieManagementScreenState();
}

class _MovieManagementScreenState extends State<MovieManagementScreen> {
  // HAPUS state '_movies' lokal
  // late List<Movie> _movies;

  // @override
  // void initState() {
  //   super.initState();
  //   _movies = List<Movie>.from(allForYouMovies); 
  // }

  void _navigateToAddMovie() async {
    final result = await Navigator.push<Movie?>( 
      context,
      MaterialPageRoute(builder: (context) => const AddEditMovieScreen()),
    );

    if (result != null && mounted) {
      // --- GUNAKAN SERVICE ---
      MovieDataService.addMovie(result); 
      // ---------------------
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Film baru berhasil ditambahkan!'), backgroundColor: Colors.green),
      );
    }
  }

  void _navigateToEditMovie(Movie movie, int index) async {
    final result = await Navigator.push<Movie?>(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditMovieScreen(movieToEdit: movie), 
      ),
    );

     if (result != null && mounted) {
       // --- GUNAKAN SERVICE ---
       MovieDataService.updateMovie(result);
       // ---------------------
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Film berhasil diperbarui!'), backgroundColor: Colors.blue),
      );
    }
  }

  void _confirmDeleteMovie(Movie movie, int index) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: Text('Apakah Anda yakin ingin menghapus film "${movie.title}"?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(ctx).pop(), 
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Hapus'),
            onPressed: () {
              Navigator.of(ctx).pop(); 
              // --- GUNAKAN SERVICE ---
              MovieDataService.deleteMovie(movie.id); 
              // ---------------------
               ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Film "${movie.title}" dihapus!'), backgroundColor: Colors.red),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kelola Film'),
      ),
      // --- GUNAKAN ValueListenableBuilder ---
      body: ValueListenableBuilder<List<Movie>>(
        valueListenable: MovieDataService.allMoviesNotifier, // Dengarkan perubahan
        builder: (context, movies, child) { // 'movies' adalah list terbaru
          // Jika kosong, tampilkan pesan
          if (movies.isEmpty) {
            return const Center(child: Text('Belum ada film.'));
          }
          // Jika ada data, tampilkan ListView
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Card( 
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: ListTile(
                  leading: Image.network(
                    movie.posterURL,
                    width: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => const Icon(Icons.movie_creation_outlined, size: 40, color: Colors.white24),
                  ),
                  title: Text(movie.title),
                  subtitle: Text('Rating: ${movie.rating}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min, 
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Theme.of(context).primaryColor),
                        // Kirim index dari list 'movies' terbaru
                        onPressed: () => _navigateToEditMovie(movie, movies.indexOf(movie)), 
                        tooltip: 'Edit Film',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),
                         // Kirim index dari list 'movies' terbaru
                        onPressed: () => _confirmDeleteMovie(movie, movies.indexOf(movie)),
                         tooltip: 'Hapus Film',
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      // ---------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddMovie,
        tooltip: 'Tambah Film Baru',
        child: const Icon(Icons.add),
      ),
    );
  }
}