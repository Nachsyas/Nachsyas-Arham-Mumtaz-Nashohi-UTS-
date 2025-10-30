import 'package:firebase_auth/firebase_auth.dart';
import 'package:myapp/viewmodel/firestore_service.dart';
import 'package:flutter/foundation.dart'; 

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();

  Stream<User?> get userStream => _auth.authStateChanges();
  
  Future<User?> registerWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      if (user != null) {
        await _firestoreService.createUserDocument(
          user: user,
          email: email,
        );
      }
      return user;

    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException during registration:');
      debugPrint('Code: ${e.code}');
      debugPrint('Message: ${e.message}');
      rethrow; 
    } catch (e, stackTrace) {
      debugPrint('Generic error during registration: $e');
      debugPrint('Stack trace: $stackTrace'); 
      throw Exception('Terjadi kesalahan tidak terduga saat registrasi. Coba lagi nanti.'); 
    }
  }
  Future<User?> signInWithEmailPassword({
    required String email, 
    required String password,
  }) async {
    try {
      debugPrint('--> Mencoba login dengan email: "$email"');
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      debugPrint('--> Login berhasil untuk user: ${result.user?.uid}'); 
      return result.user;

    } on FirebaseAuthException catch (e) {
      debugPrint('FirebaseAuthException during login:');
      debugPrint('Code: ${e.code}');
      debugPrint('Message: ${e.message}');
      if (e.code == 'user-not-found') {
         throw FirebaseAuthException(code: 'user-not-found', message: 'Email tidak terdaftar.'); 
      } else if (e.code == 'wrong-password') {
         throw FirebaseAuthException(code: 'wrong-password', message: 'Password salah.');
      } else if (e.code == 'invalid-credential'){
          throw FirebaseAuthException(code: 'invalid-credential', message: 'Email atau password salah.');
      }
      rethrow; 
    } catch (e, stackTrace) {
      debugPrint('Generic error during login: $e');
      debugPrint('Stack trace: $stackTrace');
      throw Exception('Terjadi kesalahan tidak terduga saat login. Coba lagi nanti.');
    }
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}