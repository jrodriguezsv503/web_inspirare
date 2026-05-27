import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Visual mood for [AtmosphericBackdrop].
enum BackdropMood {
  /// Warm cream → sky tint at the top. Default for hero.
  sky,

  /// Almost flat, very subtle clouds. Use for mid-page sections that
  /// shouldn't compete with content.
  ambient,

  /// Dark sky with subtle primary aurora. For dark sections (Why, footer-ish).
  night,
}

/// Renders the "cielo + nubes algodonadas" mood that anchors the INSPIRARE
/// brand metaphor. Composes a vertical gradient with slow-drifting cloud
/// blobs underneath the [child].
///
/// Honors [MediaQueryData.disableAnimations] — when reduce-motion is on,
/// the clouds stop drifting but stay visible.
class AtmosphericBackdrop extends StatefulWidget {
  final Widget child;
  final BackdropMood mood;

  /// Number of cloud blobs to render. 3-5 is the sweet spot. More than 6
  /// becomes noisy and hurts performance on lower-end devices.
  final int cloudCount;

  /// When true (default), draws a sunrise-style gradient. Disable for
  /// sections that already have their own background treatment.
  final bool showGradient;

  const AtmosphericBackdrop({
    super.key,
    required this.child,
    this.mood = BackdropMood.sky,
    this.cloudCount = 4,
    this.showGradient = true,
  });

  @override
  State<AtmosphericBackdrop> createState() => _AtmosphericBackdropState();
}

class _AtmosphericBackdropState extends State<AtmosphericBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _drift;
  late final List<_CloudSpec> _clouds;

  @override
  void initState() {
    super.initState();
    _drift = AnimationController(vsync: this, duration: AppDurations.drift)
      ..repeat();
    _clouds = _seedClouds(widget.cloudCount, widget.mood);
  }

  @override
  void didUpdateWidget(covariant AtmosphericBackdrop oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.cloudCount != widget.cloudCount ||
        oldWidget.mood != widget.mood) {
      _clouds = _seedClouds(widget.cloudCount, widget.mood);
    }
  }

  @override
  void dispose() {
    _drift.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    return Stack(
      children: [
        if (widget.showGradient)
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(gradient: _gradientFor(widget.mood)),
            ),
          ),
        Positioned.fill(
          child: IgnorePointer(
            child: RepaintBoundary(
              child: AnimatedBuilder(
                animation: _drift,
                builder: (context, _) {
                  final t = reduceMotion ? 0.0 : _drift.value;
                  return CustomPaint(
                    painter: _CloudPainter(clouds: _clouds, t: t),
                  );
                },
              ),
            ),
          ),
        ),
        widget.child,
      ],
    );
  }

  static LinearGradient _gradientFor(BackdropMood mood) {
    switch (mood) {
      case BackdropMood.sky:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.primary.withValues(alpha: 0.10),
            Palette.background,
            Palette.background,
          ],
          stops: const [0.0, 0.55, 1.0],
        );
      case BackdropMood.ambient:
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.background,
            Palette.primary.withValues(alpha: 0.04),
            Palette.background,
          ],
          stops: const [0.0, 0.5, 1.0],
        );
      case BackdropMood.night:
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2B3140), // darkLight-ish at top
            Palette.dark,
            Color(0xFF1B1F28),
          ],
          stops: [0.0, 0.55, 1.0],
        );
    }
  }

  static List<_CloudSpec> _seedClouds(int count, BackdropMood mood) {
    // Deterministic seed so clouds don't reshuffle on every rebuild.
    final rng = math.Random(42 + mood.index * 7);
    return List.generate(count, (i) {
      final isNight = mood == BackdropMood.night;
      return _CloudSpec(
        // Normalized x/y center (0..1) — painter will multiply by size.
        cx: rng.nextDouble(),
        cy: 0.05 + rng.nextDouble() * 0.85,
        // Radius as fraction of the smallest side.
        radius: 0.18 + rng.nextDouble() * 0.22,
        phase: rng.nextDouble() * math.pi * 2,
        // Drift amplitude — how far it sways horizontally.
        amplitude: 0.04 + rng.nextDouble() * 0.06,
        // Color: white-ish for light moods, tinted primary aurora for night.
        color: isNight
            ? Palette.primary.withValues(alpha: 0.10 + rng.nextDouble() * 0.06)
            : Colors.white.withValues(alpha: 0.65 + rng.nextDouble() * 0.20),
      );
    });
  }
}

class _CloudSpec {
  final double cx;
  final double cy;
  final double radius;
  final double phase;
  final double amplitude;
  final Color color;

  const _CloudSpec({
    required this.cx,
    required this.cy,
    required this.radius,
    required this.phase,
    required this.amplitude,
    required this.color,
  });
}

class _CloudPainter extends CustomPainter {
  final List<_CloudSpec> clouds;
  final double t; // 0..1 normalized drift progress

  _CloudPainter({required this.clouds, required this.t});

  @override
  void paint(Canvas canvas, Size size) {
    final shortSide = math.min(size.width, size.height);
    for (final c in clouds) {
      // Smooth horizontal sway using sine; vertical sway half amplitude for subtlety.
      final theta = (t * math.pi * 2) + c.phase;
      final dx = math.sin(theta) * c.amplitude * size.width;
      final dy = math.cos(theta) * (c.amplitude * 0.4) * size.height;

      final center = Offset(c.cx * size.width + dx, c.cy * size.height + dy);
      final radius = c.radius * shortSide;

      final paint = Paint()
        ..shader = RadialGradient(
          colors: [c.color, c.color.withValues(alpha: 0)],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));

      canvas.drawCircle(center, radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CloudPainter old) =>
      old.t != t || old.clouds != clouds;
}
