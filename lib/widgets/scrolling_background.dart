// Lokasi: lib/widgets/scrolling_background.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:myapp/data/dummy_data.dart'; // Sesuaikan path

class ScrollingBackground extends StatefulWidget {
  const ScrollingBackground({super.key});

  @override
  State<ScrollingBackground> createState() => _ScrollingBackgroundState();
}

class _ScrollingBackgroundState extends State<ScrollingBackground> {
  late ScrollController _scrollController;
  // Ambil semua poster film, dan ulangi 5x agar listnya panjang
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
    // Tambahkan listener ini untuk auto-scroll
    WidgetsBinding.instance.addPostFrameCallback((_) => _autoScroll());
  }

  void _autoScroll() async {
    if (_isDisposed || !_scrollController.hasClients) return;

    // Hitung durasi scroll berdasarkan panjang list
    // (misal: 200 milidetik per gambar)
    final duration = Duration(milliseconds: _posters.length * 200);
    final maxScroll = _scrollController.position.maxScrollExtent;

    // Animasikan ke paling bawah
    await _scrollController.animateTo(
      maxScroll,
      duration: duration,
      curve: Curves.linear, // Linear agar terlihat mengalir stabil
    );

    // Setelah sampai bawah, lompat ke atas dan ulangi
    if (!_isDisposed) {
       _scrollController.jumpTo(0);
       _autoScroll();
    }
  }

  @override
  void dispose() {
    _isDisposed = true; // Tandai bahwa widget sudah di-dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // IgnorePointer agar user tidak bisa berinteraksi dengan background
    return IgnorePointer(
      child: Stack(
        children: [
          // 1. Grid gambar yang bergerak
          GridView.builder(
            controller: _scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 kolom gambar di background
              childAspectRatio: 0.7,
            ),
            itemCount: _posters.length,
            itemBuilder: (context, index) {
              return Image.network(
                _posters[index],
                fit: BoxFit.cover,
                // Error builder sederhana
                errorBuilder: (context, error, stackTrace) => 
                  Container(color: Colors.grey.shade900),
              );
            },
          ),
          
          // 2. Filter Blur
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(color: Colors.transparent),
          ),

          // 3. Lapisan Gelap
          Container(
            color: const Color(0xFF1B1D2A).withOpacity(0.9), // Warna background utama
          ),
        ],
      ),
    );
  }
}