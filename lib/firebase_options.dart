import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCaMF79hspPgG-cngv3_lWtFOebsOtRAwg',
    appId: '1:120010424765:web:0ee42872bf9c350dc512d4',
    messagingSenderId: '120010424765',
    projectId: 'islamic-movie-platform-1',
    authDomain: 'islamic-movie-platform-1.firebaseapp.com',
    storageBucket: 'islamic-movie-platform-1.firebasestorage.app',
    measurementId: 'G-MKWQK43YLM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB1U5ihWWs1kNZxEkq1MHQkZ0rs7AZwwXg',
    appId: '1:120010424765:android:1c11aa324bf58acbc512d4',
    messagingSenderId: '120010424765',
    projectId: 'islamic-movie-platform-1',
    storageBucket: 'islamic-movie-platform-1.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAu715zFab0yGPQQd5XnZsiyf1cEv1PaBs',
    appId: '1:120010424765:ios:528ec927c7c716d7c512d4',
    messagingSenderId: '120010424765',
    projectId: 'islamic-movie-platform-1',
    storageBucket: 'islamic-movie-platform-1.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAu715zFab0yGPQQd5XnZsiyf1cEv1PaBs',
    appId: '1:120010424765:ios:528ec927c7c716d7c512d4',
    messagingSenderId: '120010424765',
    projectId: 'islamic-movie-platform-1',
    storageBucket: 'islamic-movie-platform-1.firebasestorage.app',
    iosBundleId: 'com.example.myapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCaMF79hspPgG-cngv3_lWtFOebsOtRAwg',
    appId: '1:120010424765:web:f3c197b1e8a36519c512d4',
    messagingSenderId: '120010424765',
    projectId: 'islamic-movie-platform-1',
    authDomain: 'islamic-movie-platform-1.firebaseapp.com',
    storageBucket: 'islamic-movie-platform-1.firebasestorage.app',
    measurementId: 'G-2F8J1R4J18',
  );

}