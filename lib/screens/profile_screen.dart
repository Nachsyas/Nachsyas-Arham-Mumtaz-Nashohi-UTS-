// Lokasi: lib/screens/profile_screen.dart

import 'package:flutter/material.dart';
import 'package:myapp/screens/login_screen.dart'; // Untuk logout
import 'package:myapp/screens/movie_management_screen.dart'; // Halaman manajemen film

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data user dummy (ganti dengan data asli nanti)
    const String userEmail = "admin@example.com";
    const String userName = "Admin User";

    return Scaffold(
      // AppBar agar terlihat konsisten
      appBar: AppBar(
        title: const Text('Profil Saya'),
        automaticallyImplyLeading: false, // Sembunyikan tombol kembali
      ),
      body: ListView( // Gunakan ListView agar bisa di-scroll jika kontennya banyak
        padding: const EdgeInsets.all(16.0),
        children: [
          // --- Bagian Info User ---
          Row(
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=3'), // Avatar dummy
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    userEmail,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Divider(), // Garis pemisah

          // --- Menu Manajemen Film (Khusus Admin) ---
          ListTile(
            leading: const Icon(Icons.edit_note), // <-- GANTI MENJADI INI
            title: const Text('Kelola Film'),
            subtitle: const Text('Tambah, edit, atau hapus data film'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MovieManagementScreen()),
              );
            },
          ),
          const Divider(),

          // --- Menu Pengaturan Akun (Contoh) ---
          ListTile(
            leading: const Icon(Icons.lock_outline),
            title: const Text('Ganti Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              // TODO: Tambahkan navigasi ke halaman ganti password
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur ganti password belum dibuat.')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_outline),
            title: const Text('Edit Profil'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
               // TODO: Tambahkan navigasi ke halaman edit profil
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Fitur edit profil belum dibuat.')),
              );
            },
          ),
          const Divider(),

          // --- Tombol Logout ---
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Kembali ke halaman login dan hapus semua halaman sebelumnya
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false, // Hapus semua route
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade800, // Warna merah untuk logout
              ),
              child: const Text('Logout'),
            ),
          ),
        ],
      ),
    );
  }
}