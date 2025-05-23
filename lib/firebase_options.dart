// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
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
    apiKey: 'AIzaSyBv2yulL-FSjFGz9Zm7r82zpdRlr66zxP0',
    appId: '1:852474821326:web:4fdad4e0f5e082602bae9f',
    messagingSenderId: '852474821326',
    projectId: 'test-soldier-tracker',
    authDomain: 'test-soldier-tracker.firebaseapp.com',
    storageBucket: 'test-soldier-tracker.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAmdaXOHrvaVBUZq02k4tXHAv9feUrqb5g',
    appId: '1:852474821326:android:11a9ea211b888e3e2bae9f',
    messagingSenderId: '852474821326',
    projectId: 'test-soldier-tracker',
    storageBucket: 'test-soldier-tracker.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA64ojuBBjLp0BCvwcaE1To0AsrqyWgmL8',
    appId: '1:852474821326:ios:816bbb5b7e9cb9032bae9f',
    messagingSenderId: '852474821326',
    projectId: 'test-soldier-tracker',
    storageBucket: 'test-soldier-tracker.firebasestorage.app',
    iosBundleId: 'com.example.soldierTracker',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA64ojuBBjLp0BCvwcaE1To0AsrqyWgmL8',
    appId: '1:852474821326:ios:816bbb5b7e9cb9032bae9f',
    messagingSenderId: '852474821326',
    projectId: 'test-soldier-tracker',
    storageBucket: 'test-soldier-tracker.firebasestorage.app',
    iosBundleId: 'com.example.soldierTracker',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBv2yulL-FSjFGz9Zm7r82zpdRlr66zxP0',
    appId: '1:852474821326:web:e037ebdc022868182bae9f',
    messagingSenderId: '852474821326',
    projectId: 'test-soldier-tracker',
    authDomain: 'test-soldier-tracker.firebaseapp.com',
    storageBucket: 'test-soldier-tracker.firebasestorage.app',
  );

}