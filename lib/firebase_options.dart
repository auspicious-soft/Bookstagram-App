import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
class DefaultFirebaseOptions {
  static const String androidClientId =
      '407757155276-987bg5uvtvjmjv5a9mqo1j0u2qdo6ikm.apps.googleusercontent.com';
  static const String iosClientId =
      '407757155276-fv3q66tpmp83vdrvoi3pclfi9isb9ths.apps.googleusercontent.com'; // Replace with iOS Client ID from GoogleService-Info.plist

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
    apiKey: 'AIzaSyCJO14qk9TGpKvpzIuElJzugCfBX_39Ngc',
    appId: '1:407757155276:android:3e33eb9429ee013038cb69',
    messagingSenderId: '407757155276',
    projectId: 'bookstagram-cd574',
    storageBucket: 'bookstagram-cd574.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAmIlTWnq_pM4alOLYNGeKVxv9G3ERZy-0',
    appId: '1:407757155276:ios:6403cab01a25cafb38cb69',
    messagingSenderId: '407757155276',
    projectId: 'bookstagram-cd574',
    storageBucket: 'bookstagram-cd574.firebasestorage.app',
    iosClientId:
        '407757155276-fv3q66tpmp83vdrvoi3pclfi9isb9ths.apps.googleusercontent.com',
    iosBundleId: 'com.org.auskz.bookstagram',
  );
}
