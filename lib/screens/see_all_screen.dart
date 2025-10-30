// Lokasi: lib/screens/see_all_screen.dart

import 'package:flutter/material.dart';
import 'package:myapp/model/movie_model.dart'; 
import 'package:myapp/widgets/movie_card.dart'; 

class SeeAllScreen extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const SeeAllScreen({
    super.key,
    required this.title,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return MovieCard(movie: movie);
        },
      ),
    );
  }
}