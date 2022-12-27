import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJl0v6E9EYr54EiLSjwPxNxB5DAFONX3w',
    appId: '1:1055045397214:android:b3a5e35e992aca373fb04f',
    messagingSenderId: '1055045397214',
    projectId: 'quick-letter-in',
    storageBucket: 'quick-letter-in.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArXwfxnpOAe3Gk5t9gpFhu7sXrROYJRHk',
    appId: '1:1055045397214:ios:148b42903215ca073fb04f',
    messagingSenderId: '1055045397214',
    projectId: 'quick-letter-in',
    storageBucket: 'quick-letter-in.appspot.com',
    iosClientId:
        '1055045397214-gbnofk6hctcv5brr2ob6uu1cmrl4bh44.apps.googleusercontent.com',
    iosBundleId: 'com.example.testApp',
  );
}
