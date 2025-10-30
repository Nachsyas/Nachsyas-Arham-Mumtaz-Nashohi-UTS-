import 'package:flutter/material.dart';
import 'package:myapp/model/movie_model.dart';
import 'package:myapp/viewmodel/movie_data_service.dart';
import 'package:myapp/widgets/movie_card.dart';
import 'package:myapp/widgets/scrolling_background.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  List<Movie> _filteredMovies = [];
  List<Movie> _allMovies = MovieDataService.allMoviesNotifier.value;

  @override
  void initState() {
    super.initState();
    _filteredMovies = _allMovies;
    _searchController.addListener(_onSearchChanged);
    MovieDataService.allMoviesNotifier.addListener(_onGlobalDataChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    MovieDataService.allMoviesNotifier.removeListener(_onGlobalDataChanged);
    super.dispose();
  }
  void _onGlobalDataChanged() {
    if (mounted) {
      setState(() {
        _allMovies = MovieDataService.allMoviesNotifier.value;
        _onSearchChanged();
      });
    }
  }
  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMovies = _allMovies;
      } else {
        _filteredMovies = _allMovies
            .where((movie) => movie.title.toLowerCase().contains(query))
            .toList();
      }
    });
  }
  void _clearSearch() {
    _searchController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const ScrollingBackground(),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  pinned: true,
                  title: _buildSearchBar(),
                ),
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
  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Cari film, serial, dan lainnya...',
        hintStyle: TextStyle(color: Colors.grey.shade400),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: _searchController.text.isNotEmpty
            ? IconButton(
                icon: Icon(Icons.clear, color: Colors.grey.shade400),
                onPressed: _clearSearch,
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(vertical: 14.0),
      ),
    );
  }
  Widget _buildResultsGrid() {
    if (_filteredMovies.isEmpty) {
      return const SliverToBoxAdapter(
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
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final movie = _filteredMovies[index];
          return MovieCard(movie: movie);
        },
        childCount: _filteredMovies.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.55,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,  
      ),
    );
  }
}