import 'package:flutter/material.dart';

/// Color palette for Inspirare landing page.
class Palette {
  static const Color primary = Color(0xFF75CCCC);
  static const Color primaryLight = Color(0xFF7EEAF4);
  static const Color primaryDark = Color(0xFF069AAA);
  static const Color dark = Color(0xFF212630);
  static const Color darkLight = Color(0xFF3A4252);
  static const Color background = Color(0xFFFFF9F5);
  static const Color accentWarm = Color(0xFFF4A259);
  static const Color footerDark = Color(0xFF212630);

  // Product-specific colors
  static const Color contasasPrimary = Color(0xFF08C4D4);
  static const Color dtePrimary = Color(0xFF0D1753);
  static const Color dteSecondary = Color(0xFF0A1140);

  // Text colors
  static const Color textSecondary = Color(0xFF555555);
  static const Color textMuted = Color(0xFF888888);

  // Status colors
  static const Color success = Color(0xFF2DB764);
}

/// Font families used across the app.
class Fonts {
  static const String brand = 'PlayfairDisplay-Blackitalic';
  static const String title = 'PlayfairDisplay-ExtraBold';
  static const String body = 'Roboto-Medium';
  static const String about = 'PlayfairDisplay-Regular';
}

/// Responsive breakpoints.
class Breakpoints {
  static const double mobile = 768;
  static const double tablet = 1024;
  static const double desktop = 1024;
}

/// Shared animation constants.
class AppTransitions {
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve bounce = Curves.elasticOut;
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}
