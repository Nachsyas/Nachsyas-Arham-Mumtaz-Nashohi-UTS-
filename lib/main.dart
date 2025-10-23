import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Anda mungkin perlu menambahkan google_fonts di pubspec.yaml
import 'package:myapp/screens/login_screen.dart'; // GANTI NAMA PROJECT

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisikan warna tema kita
    const Color kDarkBlue = Color(0xFF1B1D2A);
    const Color kAccentBlue = Color(0xFF6A53F0);

    return MaterialApp(
      title: 'Islamic Movie Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // Tema utama aplikasi
        brightness: Brightness.dark,
        primaryColor: kAccentBlue,
        scaffoldBackgroundColor: kDarkBlue,
        
        // Tema untuk Button
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kAccentBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Tema untuk Text
        textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

        // Tema untuk AppBar
        appBarTheme: const AppBarTheme(
          backgroundColor: kDarkBlue,
          elevation: 0,
        ),
      ),
      home: const LoginScreen(), // Memulai aplikasi dari LoginScreen
    );
  }
}