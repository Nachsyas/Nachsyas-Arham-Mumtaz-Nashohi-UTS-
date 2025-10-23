import 'package:flutter/material.dart';
// Import widget baru kita
import 'package:myapp/widgets/auth_background.dart'; // GANTI NAMA PROJECT
import 'package:myapp/screens/home_screen.dart'; // GANTI NAMA PROJECT
import 'package:myapp/screens/register_screen.dart'; // GANTI NAMA PROJECT

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Kita buat scaffold transparan agar background terlihat
      backgroundColor: Colors.transparent, 
      body: Stack(
        children: [
          // 1. Latar Belakang Slideshow
          const AuthBackground(), // Gunakan widget baru kita di sini

          // 2. Konten (Teks dan Tombol)
          // (Kode ini sama persis seperti sebelumnya)
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'iNox', // Ganti dengan nama aplikasi Anda
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 48,
                      ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Temukan film Islami terbaik\nuntuk Anda dan keluarga',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white70,
                      ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('Registrasi Akun Baru'),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                     onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey.shade800,
                    ),
                    child: const Text('Sudah Punya Akun? Login'),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Dengan membuat akun, Anda setuju dengan\nSyarat & Ketentuan kami.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white54,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}