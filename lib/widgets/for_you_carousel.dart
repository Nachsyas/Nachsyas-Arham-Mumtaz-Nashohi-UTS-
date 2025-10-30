import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/widgets/movie_card.dart';

class ForYouCarousel extends StatefulWidget {
  final String title;
  final List<Movie> movies;
  final VoidCallback onSeeAllTap;

  const ForYouCarousel({
    super.key,
    required this.title,
    required this.movies,
    required this.onSeeAllTap,
  });

  @override
  State<ForYouCarousel> createState() => _ForYouCarouselState();
}

class _ForYouCarouselState extends State<ForYouCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.35);
    _timer = Timer.periodic(const Duration(seconds: 4), (Timer timer) {
      if (_currentPage < widget.movies.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row( 
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              TextButton(
                onPressed: widget.onSeeAllTap,
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _pageController,
            itemCount: widget.movies.length,
            onPageChanged: (int page) {
            },
            itemBuilder: (context, index) {
              final movie = widget.movies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0), 
                child: MovieCard(movie: movie), 
              );
            },
          ),
        ),
      ],
    );
  }
}