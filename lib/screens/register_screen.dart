import 'package:flutter/material.dart';
import 'package:myapp/widgets/auth_background.dart';
import 'package:myapp/viewmodel/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
 const RegisterScreen({super.key});

 @override
 State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
 final _formKey = GlobalKey<FormState>();
 final _emailController = TextEditingController();
 final _passwordController = TextEditingController();
 final AuthService _authService = AuthService();
 bool _isLoading = false;

 @override
 void dispose() {
   _emailController.dispose();
   _passwordController.dispose();
   super.dispose();
 }

 Future<void> _tryRegister() async {
   if (!_formKey.currentState!.validate()) {
     return;
   }
   _formKey.currentState!.save();

   setState(() => _isLoading = true);

   try {
     await _authService.registerWithEmailPassword(
       email: _emailController.text.trim(),
       password: _passwordController.text.trim(),
     );

     if (mounted) {
       ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(content: Text('Registrasi Berhasil! Silakan Login.'), backgroundColor: Colors.green),
       );
       Navigator.pop(context);
     }

   } on FirebaseAuthException catch (e) {
     String errorMessage = 'Terjadi kesalahan saat registrasi.';
     if (e.code == 'weak-password') {
       errorMessage = 'Password terlalu lemah.';
     } else if (e.code == 'email-already-in-use') {
       errorMessage = 'Email ini sudah terdaftar.';
     } else if (e.code == 'invalid-email') {
       errorMessage = 'Format email tidak valid.';
     } 

     if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
       );
     }
   } catch (e) {
      if (mounted) {
         ScaffoldMessenger.of(context).showSnackBar(
           SnackBar(content: Text('Error: ${e.toString()}'), backgroundColor: Colors.red),
         );
      }
   } finally {
     if (mounted) {
        setState(() => _isLoading = false);
     }
   }
 }


 @override
 Widget build(BuildContext context) {
   return Stack(
     children: [
       const AuthBackground(),
       Scaffold(
         backgroundColor: Colors.transparent,
         appBar: AppBar(
           title: const Text('Buat Akun Baru'),
         ),
         body: Padding(
           padding: const EdgeInsets.all(20.0),
           child: Form(
             key: _formKey,
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 TextFormField(
                   controller: _emailController,
                   enabled: !_isLoading, 
                   decoration: const InputDecoration(
                     labelText: 'Email',
                     prefixIcon: Icon(Icons.email),
                     contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
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

                 // Password Field
                 TextFormField(
                   controller: _passwordController,
                   enabled: !_isLoading, 
                   decoration: const InputDecoration(
                     labelText: 'Password',
                     prefixIcon: Icon(Icons.lock),
                     contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
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
                    child: _isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: _isLoading ? null : _tryRegister, 
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