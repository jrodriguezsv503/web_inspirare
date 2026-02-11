import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/pages/landing/desktop_layout.dart';
import 'package:inspirare/pages/landing/mobile_layout.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > Breakpoints.mobile) {
          return const HeroSectionWeb();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
