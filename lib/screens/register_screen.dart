import 'package:flutter/material.dart';
// Import widget baru kita
import 'package:myapp/widgets/auth_background.dart'; // GANTI NAMA PROJECT

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  // ... (sisanya sama)
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ... (semua kode controller dan dispose sama)
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Latar Belakang Slideshow
        const AuthBackground(),

        // 2. Konten Form
        Scaffold(
          // Buat Scaffold dan AppBar transparan
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Buat Akun Baru'),
            backgroundColor: Colors.transparent,
            elevation: 0, // Hapus bayangan app bar
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Kita beri background sedikit pada text field agar terbaca
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: const Icon(Icons.email),
                      filled: true, // Tambahkan ini
                      fillColor: Colors.black.withOpacity(0.3), // Tambahkan ini
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Hapus border
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty || !value.contains('@')) {
                        return 'Masukkan email yang valid';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      filled: true, // Tambahkan ini
                      fillColor: Colors.black.withOpacity(0.3), // Tambahkan ini
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none, // Hapus border
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 6) {
                        return 'Password minimal 6 karakter';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.')),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Registrasi'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}