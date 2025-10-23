// Lokasi: lib/screens/home_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart'; // <-- ADD THIS LINE

// Import files from your project structure
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/viewmodel/recently_viewed_service.dart';
import 'package:myapp/viewmodel/movie_data_service.dart'; // Import central data service
import 'package:myapp/widgets/movie_card.dart';
import 'package:myapp/widgets/for_you_carousel.dart';
import 'package:myapp/screens/see_all_screen.dart';
import 'package:myapp/screens/search_screen.dart';
import 'package:myapp/screens/profile_screen.dart';

// No longer importing dummy_data directly here

// Main screen widget holding the Bottom Navigation Bar
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0; // Tracks the active tab

  // List of pages/widgets for the BottomNavBar
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreenContent(), // Tab 0: Home Page Content
    SearchScreen(),      // Tab 1: Search Page
    ProfileScreen(),     // Tab 2: Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Display the widget based on the selected index
      body: _widgetOptions.elementAt(_selectedIndex),

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar( // Theme applied from main.dart
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        // Theming is handled globally in main.dart
        onTap: (int index) {
          // Update the state when a tab is tapped
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}


// Widget containing the specific content for the Home Page (Tab 0)
class HomeScreenContent extends StatefulWidget {
  const HomeScreenContent({super.key});
  @override
  State<HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<HomeScreenContent> {
  late PageController _heroPageController; // Renamed for clarity
  Timer? _heroTimer; // Renamed for clarity
  int _currentHeroPage = 0; // Renamed for clarity
  List<Movie> _currentHeroMovies = []; // Store current hero movies for timer logic

  @override
  void initState() {
    super.initState();
    _heroPageController = PageController(viewportFraction: 0.9); // Show parts of adjacent pages
    _updateHeroMoviesAndStartTimer(); // Initial call
  }

  // Function to update hero movies and restart timer if needed
  void _updateHeroMoviesAndStartTimer() {
     _heroTimer?.cancel(); // Stop existing timer
     // Get current hero movies from the service
     _currentHeroMovies = MovieDataService.allMoviesNotifier.value.take(3).toList();
     if (_currentHeroMovies.isEmpty) return; // Don't start timer if no movies

     _heroTimer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
       // Use the length of the *currently stored* hero movies
       if (_currentHeroPage < _currentHeroMovies.length - 1) {
         _currentHeroPage++;
       } else {
         _currentHeroPage = 0; // Loop back to the start
       }
       // Ensure the controller is still mounted before animating
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
      // Add padding for the status bar at the top
      child: Padding(
        padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // --- Header Section ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'iNox', // Your App Name
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const CircleAvatar(
                    // Dummy profile picture
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // --- Hero Banner Carousel (Listens to Data Service) ---
             ValueListenableBuilder<List<Movie>>(
               valueListenable: MovieDataService.allMoviesNotifier,
               builder: (context, allMovies, child) {
                  // Get the top 3 movies for the hero banner
                  final heroMovies = allMovies.take(3).toList();
                  // Check if the hero movies have actually changed before restarting timer
                  if (!listEquals(_currentHeroMovies, heroMovies)) {
                     _currentHeroMovies = heroMovies; // Update local copy
                     // Restart timer only if data changes significantly after initial build
                     WidgetsBinding.instance.addPostFrameCallback((_) {
                       if(mounted) _updateHeroMoviesAndStartTimer();
                     });
                  }
                  return _buildHeroCarousel(context, heroMovies);
               },
             ),

            const SizedBox(height: 30),

            // --- "For You" Section (Listens to Data Service) ---
            ValueListenableBuilder<List<Movie>>(
              valueListenable: MovieDataService.forYouMoviesNotifier, // Listen to the specific 'For You' notifier
              builder: (context, forYouMoviesData, child) {
                // Don't show the section if the list is empty
                if (forYouMoviesData.isEmpty) return const SizedBox.shrink();

                return ForYouCarousel(
                  title: 'Untuk Anda',
                  movies: forYouMoviesData, // Use data from the service
                  onSeeAllTap: () { // Action for the "Lihat Semua" button
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => SeeAllScreen(
                        title: 'Untuk Anda',
                        // Pass the *current* full list from the service to SeeAll
                        movies: MovieDataService.allMoviesNotifier.value,
                      ),
                    ));
                  },
                );
              },
            ),
            // --- End of "For You" Section ---

            const SizedBox(height: 30),

            // --- "Continue Watching" Section (Dynamically shown) ---
            _buildRecentlyViewedList(),
          ],
        ),
      ),
    );
  }

  /// Builds the dynamic "Lanjutkan Menonton" list.
  Widget _buildRecentlyViewedList() {
    // ValueListenableBuilder listens for changes in the service
    return ValueListenableBuilder<List<Movie>>(
      valueListenable: RecentlyViewedService.recentlyViewedNotifier,
      builder: (context, recentlyViewedList, child) {

        // --- CORE LOGIC: IF EMPTY, SHOW NOTHING ---
        if (recentlyViewedList.isEmpty) {
          return const SizedBox.shrink(); // An empty widget (invisible)
        }

        // If not empty, display the horizontal list
        // It still uses the _buildHorizontalList helper widget
        return _buildHorizontalList(
          context: context,
          title: 'Lanjutkan Menonton',
          movieList: recentlyViewedList, // Use data from the service
          // No 'onSeeAllTap' for this section
        );
      },
    );
  }

  /// Builds the top Hero Carousel. Requires the list of movies to display.
  Widget _buildHeroCarousel(BuildContext context, List<Movie> heroMovies) {
     // Don't show if list is empty
    if (heroMovies.isEmpty) return const SizedBox(height: 212); // Placeholder height

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PageView.builder(
            controller: _heroPageController, // Use the renamed controller
            itemCount: heroMovies.length, // Use the length of the passed data
            onPageChanged: (int page) {
              setState(() { _currentHeroPage = page; }); // Use the renamed state variable
            },
            itemBuilder: (context, index) {
              final movie = heroMovies[index]; // Use data from the parameter
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Stack(
                  children: [
                    // Background Image
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          image: NetworkImage(movie.posterURL),
                          fit: BoxFit.cover,
                           // Simple fallback for image loading errors
                           onError: (exception, stackTrace) => Container(
                             decoration: BoxDecoration( color: Colors.grey.shade800, borderRadius: BorderRadius.circular(20)),
                           ),
                        ),
                      ),
                    ),
                    // Dark gradient overlay
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
                    // Text on top of the gradient
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
                            movie.synopsis, // Using synopsis field
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white70,
                                ),
                             maxLines: 1, // Prevent long text overflow
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

        // Indicator Dots for Hero Carousel
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(heroMovies.length, (index) { // Use length of passed data
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              height: 8.0,
              width: _currentHeroPage == index ? 24.0 : 8.0, // Active dot is wider
              decoration: BoxDecoration(
                color: _currentHeroPage == index // Use renamed state variable
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

  /// Helper widget to build a standard horizontal movie list.
  /// Still used by the "Lanjutkan Menonton" section.
  Widget _buildHorizontalList({
    required BuildContext context,
    required String title,
    required List<Movie> movieList,
    VoidCallback? onSeeAllTap, // Optional callback for "Lihat Semua"
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row( // Row to hold title and "Lihat Semua" button
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              // Only show "Lihat Semua" if the callback is provided
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
        SizedBox( // Use SizedBox for height constraint on ListView
          height: 200, // Matches MovieCard height + padding/text
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // Makes the list scrollable horizontally
            itemCount: movieList.length,
            itemBuilder: (context, index) {
              final movie = movieList[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 20.0 : 16.0, // Padding for the first item
                  right: index == movieList.length - 1 ? 20.0 : 0, // Padding for the last item
                ),
                child: SizedBox(
                  width: 140, // Fixed width for items in the horizontal list
                  child: MovieCard(movie: movie) // Use the MovieCard widget
                ),
              );
            },
          ),
        ),
      ],
    );
  }
} // End of _HomeScreenContentState