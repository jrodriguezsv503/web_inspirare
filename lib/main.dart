import 'package:flutter/material.dart';

import 'package:inspirare/core/l10n/locale_provider.dart';
import 'package:inspirare/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const LocaleScope(
      child: MaterialApp(
        title: 'INSPIRARE \u2014 Nearshore Software Development',
        debugShowCheckedModeBanner: false,
        home: LandingPage(),
      ),
    );
  }
}
