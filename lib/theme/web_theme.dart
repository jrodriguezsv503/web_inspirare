import 'package:flutter/material.dart';

//COLOR PALETTE
class Palette {
  static const Color primary = Color(0xFF08C4D4);
  static const Color primaryLight = Color(0xFF7EEAF4);
  static const Color primaryDark = Color(0xFF069AAA);
  static const Color dark = Color(0xFF212630);
  static const Color darkLight = Color(0xFF3A4252);
  static const Color background = Color(0xFFFFF9F5);
  static const Color accentWarm = Color(0xFFF4A259);
  static const Color footerDark = Color(0xFF1A1D24);
}

//FONTS
class Fonts {
  static const String brand = 'PlayfairDisplay-Blackitalic';
  static const String title = 'PlayfairDisplay-ExtraBold';
  static const String body = 'Roboto-Medium';
  static const String about = 'PlayfairDisplay-Regular';
}

//TRANSITIONS
class AppTransitions {
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve bounce = Curves.elasticOut;
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

