import 'package:flutter/material.dart';
import 'package:myapp/model/movie_model.dart'; 
import 'package:myapp/screens/movie_detail_screen.dart'; 

class MovieCard extends StatelessWidget {
  final Movie movie; 

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(movie: movie),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(movie.posterURL), 
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(child: Icon(Icons.movie, color: Colors.white54)),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),
  
          Text(
            movie.title, 
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}