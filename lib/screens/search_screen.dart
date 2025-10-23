// Lokasi: lib/screens/search_screen.dart

import 'package:flutter/material.dart';
// No longer importing dummy_data directly
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/viewmodel/movie_data_service.dart'; // Import central data service
import 'package:myapp/widgets/movie_card.dart';
import 'package:myapp/widgets/scrolling_background.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Movie> _filteredMovies = []; // List to hold search results

  // Get initial data from the service
  List<Movie> _allMovies = MovieDataService.allMoviesNotifier.value;

  @override
  void initState() {
    super.initState();
    // Initially, show all movies
    _filteredMovies = _allMovies;
    _searchController.addListener(_onSearchChanged);
    // Listen for global data changes (e.g., deletions from Profile)
    MovieDataService.allMoviesNotifier.addListener(_onGlobalDataChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    // Remove the listener when the widget is disposed
    MovieDataService.allMoviesNotifier.removeListener(_onGlobalDataChanged);
    super.dispose();
  }

  // Called when the global movie list changes
  void _onGlobalDataChanged() {
    // Update the local copy and re-apply the filter
    if (mounted) { // Check if the widget is still in the tree
      setState(() {
        _allMovies = MovieDataService.allMoviesNotifier.value;
        _onSearchChanged(); // Re-filter results with the current query
      });
    }
  }

  // Called every time the text in the search bar changes
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // If search bar is empty, show all movies from the current global list
        _filteredMovies = _allMovies;
      } else {
        // Otherwise, filter the current global list based on the title
        _filteredMovies = _allMovies
            .where((movie) => movie.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  // Clears the search bar text
  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // --- 1. Scrolling Background ---
        const ScrollingBackground(),

        // --- 2. Page Content (Search Bar + Grid) ---
        Scaffold(
          backgroundColor: Colors.transparent, // Required for background visibility
          body: SafeArea(
            child: CustomScrollView( // Use CustomScrollView for floating AppBar effect
              slivers: [
                // --- Search Bar ---
                SliverAppBar(
                  backgroundColor: Colors.transparent, // Transparent AppBar
                  elevation: 0,
                  pinned: true, // Keep search bar visible while scrolling
                  title: _buildSearchBar(),
                ),

                // --- Search Results Grid ---
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: _buildResultsGrid(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Builds the search text field
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration( // Uses theme from main.dart
        hintText: 'Cari film, serial, dan lainnya...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Icon(Icons.search), // Color comes from theme
        // Show clear button only if there's text
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey.shade400),
                onPressed: _clearSearch,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
        // Border styling is handled by the theme in main.dart
      ),
    );
  }

  // Builds the grid displaying search results
  Widget _buildResultsGrid() {
    // Show a message if no movies match the filter
    if (_filteredMovies.isEmpty) {
      return const SliverToBoxAdapter( // Use SliverToBoxAdapter for non-sliver content inside CustomScrollView
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 50.0),
            child: Text(
              'Tidak ada film yang ditemukan',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
          ),
        ),
      );
    }

    // Show the grid if there are results
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final movie = _filteredMovies[index];
          // Use the updated MovieCard which uses Expanded
          return MovieCard(movie: movie);
        },
        childCount: _filteredMovies.length,
      ),
      // Configure the grid layout
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // 3 columns
        childAspectRatio: 0.55, // Adjusted aspect ratio for MovieCard with Expanded
        crossAxisSpacing: 16.0, // Horizontal spacing
        mainAxisSpacing: 16.0,  // Vertical spacing
      ),
    );
  }
}