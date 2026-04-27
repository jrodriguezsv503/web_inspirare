import 'dart:async';

import 'package:flutter/material.dart';

import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/core/l10n/locale_provider.dart';
import 'package:inspirare/pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase Analytics in the background so a slow/blocked
  // request to Firebase Installations API never delays first paint.
  // AnalyticsService.init() is idempotent and tolerant to failure.
  unawaited(AnalyticsService.instance.init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LocaleScope(
      child: MaterialApp(
        title: 'INSPIRARE — Nearshore Software Development',
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
