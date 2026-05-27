import 'package:flutter/material.dart';

/// Color palette for INSPIRARE landing page.
class Palette {
  static const Color primary = Color(0xFF75CCCC);
  static const Color primaryLight = Color(0xFF7EEAF4);
  static const Color primaryDark = Color(0xFF069AAA);
  static const Color dark = Color(0xFF212630);
  static const Color darkLight = Color(0xFF3A4252);
  static const Color background = Color(0xFFFFF9F5);
  static const Color accentWarm = Color(0xFFF4A259);
  static const Color footerDark = Color(0xFF212630);

  // Text colors
  static const Color textSecondary = Color(0xFF555555);
  static const Color textMuted = Color(0xFF888888);

  // Status colors
  static const Color success = Color(0xFF2DB764);

  // Surface tokens (light theme)
  static const Color surface = Colors.white;
  static const Color hairline = Color(0x14000000); // 8%
  static const Color hairlineSoft = Color(0x0A000000); // 4%

  // Surface tokens (dark theme)
  static const Color surfaceDark = Color(0xFF2A303C);
  static const Color hairlineDark = Color(0x1FFFFFFF); // 12%
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

/// Custom motion curves.
///
/// Includes punchy curves for UI feedback and ethereal "cloud" curves
/// for the sky/atmospheric metaphor — slow, breathy, sine-based motion.
class AppCurves {
  /// Strong ease-out: starts fast, settles smoothly. Use for entries/hovers.
  static const Cubic easeOutStrong = Cubic(0.23, 1.0, 0.32, 1.0);

  /// Strong ease-in-out: punchy on both ends. Use for in-screen movement.
  static const Cubic easeInOutStrong = Cubic(0.77, 0.0, 0.175, 1.0);

  /// iOS-style drawer feel — good for sheets and modals.
  static const Cubic drawer = Cubic(0.32, 0.72, 0.0, 1.0);

  // — Sky/cloud system —

  /// Soft, breathy ease — feels like air settling. Use for hero entries,
  /// section reveals, anything that should "float in" not "snap in".
  static const Cubic cloud = Cubic(0.22, 0.61, 0.36, 1.0);

  /// Material 3 emphasized decelerate — buena para modales grandes y
  /// transiciones que necesitan presencia sin agresividad.
  static const Cubic emphasizedDecelerate = Cubic(0.05, 0.7, 0.1, 1.0);

  /// Sine-based slow drift — perfect for cloud blob motion or floating elements.
  /// Use with [AppDurations.drift] for ambient background motion.
  static const Cubic drift = Cubic(0.45, 0.05, 0.55, 0.95);
}

/// Curated durations aligned with the cloud metaphor.
class AppDurations {
  /// 700ms — entries from below the fold. Slower than UI, gives the
  /// sensation of weight settling like a cloud descending.
  static const Duration ethereal = Duration(milliseconds: 700);

  /// 60s — full cycle for ambient cloud drift across the viewport.
  static const Duration drift = Duration(seconds: 60);

  /// 3.2s — slow float oscillation for hero elements (badge, accents).
  static const Duration float = Duration(milliseconds: 3200);
}

/// Tokens for cloud-soft shadows.
///
/// Clouds don't cast hard shadows — they bloom. These presets favor
/// large blur radii with very low alpha, so elements feel suspended.
class CloudShadows {
  /// Default resting state — barely there.
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x0A000000), // 4%
      blurRadius: 32,
      offset: Offset(0, 4),
    ),
    BoxShadow(
      color: Color(0x05000000), // 2%
      blurRadius: 8,
      offset: Offset(0, 1),
    ),
  ];

  /// Hover/elevated state — the cloud lifts slightly.
  static const List<BoxShadow> lifted = [
    BoxShadow(
      color: Color(0x14000000), // 8%
      blurRadius: 48,
      offset: Offset(0, 12),
    ),
    BoxShadow(
      color: Color(0x08000000), // 3%
      blurRadius: 12,
      offset: Offset(0, 2),
    ),
  ];

  /// Hero metrics bar / feature cards — more presence.
  static const List<BoxShadow> floating = [
    BoxShadow(
      color: Color(0x12000000), // 7%
      blurRadius: 64,
      offset: Offset(0, 16),
    ),
    BoxShadow(
      color: Color(0x06000000),
      blurRadius: 16,
      offset: Offset(0, 2),
    ),
  ];
}

/// Border radius scale — cloud-friendly (generous, soft).
class AppRadii {
  static const double sm = 10;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double pill = 999;
}
