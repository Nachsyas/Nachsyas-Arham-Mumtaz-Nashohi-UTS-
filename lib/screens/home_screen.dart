import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/viewmodel/recently_viewed_service.dart';
import 'package:myapp/viewmodel/movie_data_service.dart';
import 'package:myapp/widgets/movie_card.dart';
import 'package:myapp/widgets/for_you_carousel.dart';
import 'package:myapp/screens/see_all_screen.dart';
import 'package:myapp/screens/search_screen.dart';
import 'package:myapp/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(),
    SearchScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});
  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  late PageController _heroPageController;
  Timer? _heroTimer;
  int _currentHeroPage = 0;
  List<Movie> _currentHeroMovies = [];

  @override
  void initState() {
    super.initState();
    _heroPageController = PageController(viewportFraction: 0.9);
    _updateHeroMoviesAndStartTimer();
  }
  void _updateHeroMoviesAndStartTimer() {
     _heroTimer?.cancel();
     _currentHeroMovies = MovieDataService.allMoviesNotifier.value.take(3).toList();
     if (_currentHeroMovies.isEmpty) return;
     _heroTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
       if (_currentHeroPage < _currentHeroMovies.length - 1) {
         _currentHeroPage++;
       } else {
         _currentHeroPage = 0;
       }
       if (_heroPageController.hasClients) {
         _heroPageController.animateToPage(
           _currentHeroPage,
           duration: const Duration(milliseconds: 600),
           curve: Curves.easeInOut,
         );
       }
     });
  }


  @override
  void dispose() {
    _heroPageController.dispose();
    _heroTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'iNox',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
             ValueListenableBuilder<List<Movie>>(
               valueListenable: MovieDataService.allMoviesNotifier,
               builder: (context, allMovies, child) {
                  final heroMovies = allMovies.take(3).toList();
                  if (!listEquals(_currentHeroMovies, heroMovies)) {
                     _currentHeroMovies = heroMovies;
                     WidgetsBinding.instance.addPostFrameCallback((_) {
                       if(mounted) _updateHeroMoviesAndStartTimer();
                     });
                  }
                  return _buildHeroCarousel(context, heroMovies);
               },
             ),

            const SizedBox(height: 30),
            ValueListenableBuilder<List<Movie>>(
              valueListenable: MovieDataService.forYouMoviesNotifier,
              builder: (context, forYouMoviesData, child) {
                if (forYouMoviesData.isEmpty) return const SizedBox.shrink();
                return ForYouCarousel(
                  title: 'Untuk Anda',
                  movies: forYouMoviesData,
                  onSeeAllTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllScreen(
                        title: 'Untuk Anda',
                        movies: MovieDataService.allMoviesNotifier.value,
                      ),
                    ));
                  },
                );
              },
            ),
            const SizedBox(height: 30),
            _buildRecentlyViewedList(),
          ],
        ),
      ),
    );
  }
  Widget _buildRecentlyViewedList() {
    return ValueListenableBuilder<List<Movie>>(
      valueListenable: RecentlyViewedService.recentlyViewedNotifier,
      builder: (context, recentlyViewedList, child) {
        if (recentlyViewedList.isEmpty) {
          return const SizedBox.shrink();
        }
        return _buildHorizontalList(
          context: context,
          title: 'Lanjutkan Menonton',
          movieList: recentlyViewedList,
        );
      },
    );
  }
  Widget _buildHeroCarousel(BuildContext context, List<Movie> heroMovies) {
    if (heroMovies.isEmpty) return const SizedBox(height: 212);
    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _heroPageController,
            itemCount: heroMovies.length,
            onPageChanged: (int page) {
              setState(() { _currentHeroPage = page; });
            },
            itemBuilder: (context, index) {
              final movie = heroMovies[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(movie.posterURL),
                          fit: BoxFit.cover,
                           onError: (exception, stackTrace) => Container(
                             decoration: BoxDecoration( color: Colors.grey.shade800, borderRadius: BorderRadius.circular(20)),
                           ),
                        ),
                      ),
                    ),
                    Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         gradient: LinearGradient(
                           begin: Alignment.bottomCenter,
                           end: Alignment.topCenter,
                           colors: [ Colors.black.withOpacity(0.8), Colors.transparent],
                         )
                       ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                          ),
                          Text(
                            movie.synopsis,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                             maxLines: 1,
                             overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(heroMovies.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentHeroPage == index ? 24.0 : 8.0,
              decoration: BoxDecoration(
                color: _currentHeroPage == index
                    ? Theme.of(context).primaryColor
                    : Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
  Widget _buildHorizontalList({
    required BuildContext context,
    required String title,
    required List<Movie> movieList,
    VoidCallback? onSeeAllTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              if (onSeeAllTap != null)
                TextButton(
                  onPressed: onSeeAllTap,
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movie = movieList[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20.0 : 16.0,
                  right: index == movieList.length - 1 ? 20.0 : 0,
                ),
                child: SizedBox(
                  width: 140,
                  child: MovieCard(movie: movie)
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}