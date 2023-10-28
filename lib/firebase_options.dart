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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCqo5dOUjQiyD05LMWj_LFaf92JXS_0LCI',
    appId: '1:550240836366:web:f1c1f98393544380a0955f',
    messagingSenderId: '550240836366',
    projectId: 'learniverse-1a7e5',
    authDomain: 'learniverse-1a7e5.firebaseapp.com',
    databaseURL: 'https://learniverse-1a7e5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learniverse-1a7e5.appspot.com',
    measurementId: 'G-3YVXS9CJJR',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD_MXD5LIIZCXBihi2Hh6Dv9E0wLXmY3bM',
    appId: '1:550240836366:android:bc2a2f097d853dd1a0955f',
    messagingSenderId: '550240836366',
    projectId: 'learniverse-1a7e5',
    databaseURL: 'https://learniverse-1a7e5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learniverse-1a7e5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmHfnfpG3qL4ZJUwMGyb__h5hnkpLoxyY',
    appId: '1:550240836366:ios:7fc6650e5cb328a4a0955f',
    messagingSenderId: '550240836366',
    projectId: 'learniverse-1a7e5',
    databaseURL: 'https://learniverse-1a7e5-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'learniverse-1a7e5.appspot.com',
    iosBundleId: 'com.example.learniverse',
  );
}
