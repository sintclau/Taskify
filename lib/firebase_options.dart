// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyB4diJIExeJAlhy9dgrjYlwR-kDn9N9Krc',
    appId: '1:946876735534:web:d33e3809bae97b81b37fbf',
    messagingSenderId: '946876735534',
    projectId: 'taskify-3dea3',
    authDomain: 'taskify-3dea3.firebaseapp.com',
    storageBucket: 'taskify-3dea3.appspot.com',
    measurementId: 'G-EWMF71L272',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCIN03uwtnRfttvALnqQjDSyYrbOIgPXjc',
    appId: '1:946876735534:android:612f6b5d87f70f8ab37fbf',
    messagingSenderId: '946876735534',
    projectId: 'taskify-3dea3',
    storageBucket: 'taskify-3dea3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBNo8PgomJy73VKXkjbjTBOTJsze_aT1mI',
    appId: '1:946876735534:ios:b06d6b94cf9b96d6b37fbf',
    messagingSenderId: '946876735534',
    projectId: 'taskify-3dea3',
    storageBucket: 'taskify-3dea3.appspot.com',
    iosBundleId: 'com.example.taskify',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBNo8PgomJy73VKXkjbjTBOTJsze_aT1mI',
    appId: '1:946876735534:ios:00984923ff688e86b37fbf',
    messagingSenderId: '946876735534',
    projectId: 'taskify-3dea3',
    storageBucket: 'taskify-3dea3.appspot.com',
    iosBundleId: 'com.example.taskify.RunnerTests',
  );
}
