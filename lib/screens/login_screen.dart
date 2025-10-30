import 'package:flutter/material.dart';
import 'package:myapp/widgets/auth_background.dart';
import 'package:myapp/screens/home_screen.dart';
import 'package:myapp/screens/register_screen.dart';
import 'package:myapp/viewmodel/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
class LoginScreen extends StatefulWidget {
 const LoginScreen({super.key});

 @override
 State<LoginScreen> createState() => _LoginScreenState();
}
class _LoginScreenState extends State<LoginScreen> {
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
 Future<void> _tryLogin() async {
   if (!_formKey.currentState!.validate()) {
     return;
   }
    _formKey.currentState!.save();

   setState(() => _isLoading = true);

   try {
     await _authService.signInWithEmailPassword(
       email: _emailController.text.trim(),
       password: _passwordController.text.trim(),
     );
     if (mounted) {
       Navigator.pushReplacement(
         context,
         MaterialPageRoute(builder: (context) => const HomeScreen()),
       );
     }
   } on FirebaseAuthException catch (e) {
     String errorMessage = 'Terjadi kesalahan saat login.';
     if (e.code == 'user-not-found' || e.code == 'wrong-password' || e.code == 'invalid-credential') {
       errorMessage = 'Email atau password salah.';
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
   return Scaffold(
     backgroundColor: Colors.transparent,
     body: Stack(
       children: [
         const AuthBackground(),
         Center(
           child: SingleChildScrollView(
             padding: const EdgeInsets.symmetric(horizontal: 30),
             child: Form(
               key: _formKey,
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     'iNox',
                     style: Theme.of(context).textTheme.displaySmall?.copyWith(
                           fontWeight: FontWeight.bold,
                           color: Colors.white,
                         ),
                   ),
                   const SizedBox(height: 40),
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
                        if (value == null || value.isEmpty) {
                         return 'Password tidak boleh kosong';
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
                         onPressed: _isLoading ? null : _tryLogin,
                         child: const Text('Login'),
                     ),
                   ),
                   const SizedBox(height: 20),
                   TextButton(
                     onPressed: _isLoading ? null : () {
                       Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const RegisterScreen()),
                       );
                     },
                     child: Text(
                       'Belum punya akun? Registrasi di sini',
                       style: TextStyle(color: Theme.of(context).primaryColor),
                     ),
                   ),
                    const SizedBox(height: 40),
                 ],
               ),
             ),
           ),
         ),
       ],
     ),
   );
 }
}