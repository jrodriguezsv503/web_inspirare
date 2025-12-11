import 'package:flutter/material.dart';

import 'package:inspirare/pages/landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inspirare.app',
      debugShowCheckedModeBanner: false,
      // Usa tu LandingPage como la pantalla de inicio
      home: const LandingPage(), //LandingPage(),
    );
  }
}
