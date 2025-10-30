import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart';

class ScrollingBackground extends StatefulWidget {
  const ScrollingBackground({super.key});

  @override
  State<ScrollingBackground> createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground> {
  late ScrollController _scrollController;
  final List<String> _posters = allForYouMovies
      .map((movie) => movie.posterURL)
      .toList()
    ..addAll(allForYouMovies.map((movie) => movie.posterURL))
    ..addAll(allForYouMovies.map((movie) => movie.posterURL))
    ..addAll(allForYouMovies.map((movie) => movie.posterURL))
    ..addAll(allForYouMovies.map((movie) => movie.posterURL));
  
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoScroll());
  }

  void _autoScroll() async {
    if (_isDisposed || !_scrollController.hasClients) return;

    
    final duration = Duration(milliseconds: _posters.length * 200);
    final maxScroll = _scrollController.position.maxScrollExtent;
    
    await _scrollController.animateTo(
      maxScroll,
      duration: duration,
      curve: Curves.linear,
    );
    
    if (!_isDisposed) {
       _scrollController.jumpTo(0);
       _autoScroll();
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Stack(
        children: [
          GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, 
              childAspectRatio: 0.7,
            ),
            itemCount: _posters.length,
            itemBuilder: (context, index) {
              return Image.network(
                _posters[index],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  Container(color: Colors.grey.shade900),
              );
            },
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.transparent),
          ),
          Container(
            color: const Color(0xFF1B1D2A).withOpacity(0.9),
          ),
        ],
      ),
    );
  }
}