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
    apiKey: 'AIzaSyAnBNER68VlqRZH2DGddrwDct1im5mTSTM',
    appId: '1:363754349311:web:df63580d5601bf8079a2ca',
    messagingSenderId: '363754349311',
    projectId: 'flutteriaproject',
    authDomain: 'flutteriaproject.firebaseapp.com',
    storageBucket: 'flutteriaproject.firebasestorage.app',
    measurementId: 'G-WMKYWXG2JF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXlu4rE6aZiO9UmetM5mSOxnl80MRibXQ',
    appId: '1:363754349311:android:1ca6de0a7bb8385279a2ca',
    messagingSenderId: '363754349311',
    projectId: 'flutteriaproject',
    storageBucket: 'flutteriaproject.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWQhkgdlSr0ZRSsUEggTibg-COkoLdgDI',
    appId: '1:363754349311:ios:d5e8c7b8fe8ed46479a2ca',
    messagingSenderId: '363754349311',
    projectId: 'flutteriaproject',
    storageBucket: 'flutteriaproject.firebasestorage.app',
    iosBundleId: 'com.example.monsifHarchaouiTp2Flutteraiclothing',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWQhkgdlSr0ZRSsUEggTibg-COkoLdgDI',
    appId: '1:363754349311:ios:d5e8c7b8fe8ed46479a2ca',
    messagingSenderId: '363754349311',
    projectId: 'flutteriaproject',
    storageBucket: 'flutteriaproject.firebasestorage.app',
    iosBundleId: 'com.example.monsifHarchaouiTp2Flutteraiclothing',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAnBNER68VlqRZH2DGddrwDct1im5mTSTM',
    appId: '1:363754349311:web:bd568a6f83e16a9979a2ca',
    messagingSenderId: '363754349311',
    projectId: 'flutteriaproject',
    authDomain: 'flutteriaproject.firebaseapp.com',
    storageBucket: 'flutteriaproject.firebasestorage.app',
    measurementId: 'G-G1Z4SJ73TC',
  );
}