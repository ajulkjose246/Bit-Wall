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
    apiKey: 'AIzaSyCazd8wf3SpsI96PhJfEIQN3yZSqnpfu1A',
    appId: '1:951354216930:web:b64312413355465dc969bb',
    messagingSenderId: '951354216930',
    projectId: 'bitwall-app',
    authDomain: 'bitwall-app.firebaseapp.com',
    storageBucket: 'bitwall-app.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD-IYSevRaV1FDJF5pYhwHrIN7-JeK51cc',
    appId: '1:951354216930:android:bd2342512048ba9cc969bb',
    messagingSenderId: '951354216930',
    projectId: 'bitwall-app',
    storageBucket: 'bitwall-app.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAStuhD-7oX7ZDZHeH023HbYMDmASMRNF8',
    appId: '1:951354216930:ios:0927c18d1e6135b9c969bb',
    messagingSenderId: '951354216930',
    projectId: 'bitwall-app',
    storageBucket: 'bitwall-app.appspot.com',
    iosBundleId: 'com.example.bitwall',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAStuhD-7oX7ZDZHeH023HbYMDmASMRNF8',
    appId: '1:951354216930:ios:0927c18d1e6135b9c969bb',
    messagingSenderId: '951354216930',
    projectId: 'bitwall-app',
    storageBucket: 'bitwall-app.appspot.com',
    iosBundleId: 'com.example.bitwall',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCazd8wf3SpsI96PhJfEIQN3yZSqnpfu1A',
    appId: '1:951354216930:web:3c3a5911eafa836dc969bb',
    messagingSenderId: '951354216930',
    projectId: 'bitwall-app',
    authDomain: 'bitwall-app.firebaseapp.com',
    storageBucket: 'bitwall-app.appspot.com',
  );
}
