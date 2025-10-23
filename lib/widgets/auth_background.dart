// Lokasi: lib/widgets/auth_background.dart

import 'dart:async';
import 'package:flutter/material.dart';

class AuthBackground extends StatefulWidget {
  const AuthBackground({super.key});

  @override
  State<AuthBackground> createState() => _AuthBackgroundState();
}

class _AuthBackgroundState extends State<AuthBackground> {
  // --- DAFTAR WALLPAPER (LINK BARU DARI TMDB) ---
  final List<String> _wallpapers = [
    'https://image.tmdb.org/t/p/w780/gEU2QniE6E77NI6lCU6MxlNBvIx.jpg', // Interstellar
    'https://image.tmdb.org/t/p/w780/8Gxv8gSFCU0XGDykEGv7zR1n2ua.jpg', // Oppenheimer
    'https://image.tmdb.org/t/p/w780/d5NXSklXo0qyIYkgV94XAgMIckC.jpg', // Dune
    'https://image.tmdb.org/t/p/w780/k68nPLbIST6NP96JmTxmZijEvCA.jpg', // Tenet
    'https://image.tmdb.org/t/p/w780/qJ2tW6WMUDux911r6m7haRef0WH.jpg', // The Dark Knight
  ];
  // ---------------------------------------------

  int _currentWallpaperIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    // --- INI PERBAIKANNYA ---
    super.initState(); // Hapus tanda '_'
    // ------------------------
    
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        _currentWallpaperIndex =
            (_currentWallpaperIndex + 1) % _wallpapers.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedSwitcher(
          duration: const Duration(seconds: 2), 
          child: Image.network(
            _wallpapers[_currentWallpaperIndex],
            key: ValueKey<String>(_wallpapers[_currentWallpaperIndex]), 
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
            frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
              if (wasSynchronouslyLoaded) {
                return child;
              }
              return AnimatedOpacity(
                child: child,
                opacity: frame == null ? 0 : 1,
                duration: const Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xFF1B1D2A),
                child: const Center(
                  child: Icon(Icons.signal_wifi_off_rounded, color: Colors.white24, size: 40),
                ),
              );
            },
          ),
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Color(0xFF1B1D2A), 
              ],
              stops: [0.3, 0.7],
            ),
          ),
        ),
      ],
    );
  }
}