// File generated manually for the INSPIRARE landing (web-only).
//
// To activate Firebase Analytics:
// 1. Open Firebase Console -> Project "web-inspirare" -> Project settings.
// 2. Under "Your apps", click "Add app" -> Web (</>), name it
//    "INSPIRARE Landing", register, and skip the SDK injection step
//    (we handle it via firebase_core).
// 3. Copy the config object Firebase shows and replace the REPLACE_ME
//    placeholders below with the real values.
// 4. Make sure "Google Analytics for this Firebase project" is enabled
//    (you should see a measurementId starting with "G-").
//
// Once values are in place, the AnalyticsService will start sending events
// automatically; until then it stays disabled silently.

import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show kIsWeb;

class DefaultFirebaseOptions {
  DefaultFirebaseOptions._();

  static FirebaseOptions get currentPlatform {
    if (!kIsWeb) {
      throw UnsupportedError(
        'INSPIRARE landing only targets Flutter Web. Add native config '
        'before running on mobile/desktop.',
      );
    }
    return web;
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCbscCRnozl-bBn3FS6dTtqd2hvojpz3Mw',
    appId: '1:692748378408:web:4a785aaed873854af5b01d',
    messagingSenderId: '692748378408',
    projectId: 'web-inspirare',
    authDomain: 'web-inspirare.firebaseapp.com',
    storageBucket: 'web-inspirare.firebasestorage.app',
    measurementId: 'G-YSTD0J40QM',
  );

  /// Returns true when at least one critical credential is still a placeholder.
  /// Used by AnalyticsService to disable itself until the user pastes the
  /// real Firebase Web App config.
  static bool get isPlaceholder =>
      web.apiKey.startsWith('REPLACE_ME') ||
      web.appId.startsWith('REPLACE_ME') ||
      (web.measurementId?.startsWith('REPLACE_ME') ?? true);
}
