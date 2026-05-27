import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_events.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/atmospheric_backdrop.dart';

/// Hero section — landing entry point.
///
/// Sits inside an [AtmosphericBackdrop] so the brand metaphor (white clouds
/// on a blue sky) lives in the layout, not only the typography.
class HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onPortfolioTap;
  final VoidCallback? onContactTap;

  const HeroSection({
    super.key,
    this.isMobile = false,
    this.onPortfolioTap,
    this.onContactTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final heroFontSize = (screenWidth * 0.058).clamp(44.0, 80.0);
    final s = AppStrings.of(context);

    return AtmosphericBackdrop(
      cloudCount: isSmall ? 3 : 5,
      child: Padding(
        padding: EdgeInsets.only(
          top: isSmall ? 140 : 180,
          bottom: isSmall ? 48 : 88,
          left: isSmall ? 24 : 40,
          right: isSmall ? 24 : 40,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              children: [
                AnimatedSection(child: _HeroBadge(isMobile: isSmall)),
                const SizedBox(height: 36),
                AnimatedSection(
                  delay: const Duration(milliseconds: 120),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 920),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: Fonts.title,
                          fontSize: heroFontSize,
                          height: 1.04,
                          color: Palette.dark,
                          letterSpacing: -2.2,
                        ),
                        children: [
                          TextSpan(text: s.heroHeadlinePart1),
                          TextSpan(
                            text: s.heroHeadlineAccent,
                            style: const TextStyle(
                              color: Palette.primaryDark,
                            ),
                          ),
                          TextSpan(text: s.heroHeadlinePart2),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),
                AnimatedSection(
                  delay: const Duration(milliseconds: 220),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 620),
                    child: Text(
                      s.heroSubtitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: isSmall ? 16 : 18.5,
                        color: Palette.textSecondary,
                        height: 1.72,
                        letterSpacing: 0.1,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 44),
                AnimatedSection(
                  delay: const Duration(milliseconds: 320),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _PrimaryButton(
                        label: s.heroCtaPrimary,
                        onTap: () {
                          AnalyticsService.instance.logLeadGenerated(
                            source: 'hero',
                            extra: {'cta_id': CtaIds.heroPrimary},
                          );
                          onContactTap?.call();
                        },
                        fullWidth: isSmall,
                      ),
                      _SecondaryButton(
                        label: s.heroCtaSecondary,
                        onTap: () {
                          AnalyticsService.instance.logSelectContent(
                            contentType: 'portfolio',
                            itemId: CtaIds.heroSecondary,
                          );
                          onPortfolioTap?.call();
                        },
                        fullWidth: isSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: isSmall ? 64 : 96),
                AnimatedSection(
                  delay: const Duration(milliseconds: 420),
                  child: _TrustBadgesRow(isMobile: isSmall),
                ),
                SizedBox(height: isSmall ? 28 : 40),
                AnimatedSection(
                  delay: const Duration(milliseconds: 520),
                  child: _MetricsBar(isMobile: isSmall),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Badge with a slow vertical "float" — the cloud is alive but unhurried.
class _HeroBadge extends StatefulWidget {
  final bool isMobile;

  const _HeroBadge({this.isMobile = false});

  @override
  State<_HeroBadge> createState() => _HeroBadgeState();
}

class _HeroBadgeState extends State<_HeroBadge>
    with TickerProviderStateMixin {
  late final AnimationController _pulse;
  late final AnimationController _float;
  late final Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulse = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 0.55).animate(
      CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
    );
    _float = AnimationController(vsync: this, duration: AppDurations.float)
      ..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulse.dispose();
    _float.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = widget.isMobile;
    final s = AppStrings.of(context);
    final reduceMotion = MediaQuery.of(context).disableAnimations;

    final badge = Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 14 : 20,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.72),
        border: Border.all(color: Palette.primaryDark.withValues(alpha: 0.22)),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F069AAA),
            blurRadius: 24,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnim,
            builder: (context, child) {
              return Opacity(
                opacity: _pulseAnim.value,
                child: Transform.scale(
                  scale: 0.8 + (_pulseAnim.value * 0.2),
                  child: child,
                ),
              );
            },
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Palette.primaryDark,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              s.heroBadge,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: isMobile ? 11 : 13,
                fontWeight: FontWeight.w600,
                color: Palette.primaryDark,
                letterSpacing: isMobile ? 0 : 0.5,
              ),
            ),
          ),
        ],
      ),
    );

    if (reduceMotion) return badge;

    return AnimatedBuilder(
      animation: _float,
      builder: (context, child) {
        final dy = math.sin(_float.value * math.pi) * 3.0;
        return Transform.translate(offset: Offset(0, -dy), child: child);
      },
      child: badge,
    );
  }
}

class _TrustBadgesRow extends StatelessWidget {
  final bool isMobile;

  const _TrustBadgesRow({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final badges = [
      (s.heroBadgeDuns, Icons.verified_outlined),
      (s.heroBadgeIp, Icons.lock_outline),
    ];

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: isMobile ? 12 : 20,
      runSpacing: 10,
      children: badges
          .map(
            (b) => Container(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 11 : 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(AppRadii.pill),
                border: Border.all(
                  color: Palette.dark.withValues(alpha: 0.08),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    b.$2,
                    size: isMobile ? 13 : 15,
                    color: Palette.primaryDark,
                  ),
                  const SizedBox(width: 7),
                  Text(
                    b.$1,
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: isMobile ? 10 : 12,
                      fontWeight: FontWeight.w600,
                      color: Palette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

/// Metrics bar — a suspended white cloud carrying the proof points.
class _MetricsBar extends StatelessWidget {
  final bool isMobile;

  const _MetricsBar({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final metrics = [
      (s.heroMetric1Value, s.heroMetric1Label),
      (s.heroMetric2Value, s.heroMetric2Label),
      (s.heroMetric3Value, s.heroMetric3Label),
      (s.heroMetric4Value, s.heroMetric4Label),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 940),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.78),
          borderRadius: BorderRadius.circular(AppRadii.xl),
          boxShadow: CloudShadows.floating,
          border: Border.all(color: Colors.white.withValues(alpha: 0.9)),
        ),
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 36 : 44,
          horizontal: isMobile ? 8 : 16,
        ),
        child: isMobile
            ? Wrap(
                alignment: WrapAlignment.center,
                spacing: 0,
                runSpacing: 28,
                children: metrics
                    .map(
                      (m) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _MetricItem(number: m.$1, label: m.$2),
                      ),
                    )
                    .toList(),
              )
            : IntrinsicHeight(
                child: Row(
                  children: [
                    for (int i = 0; i < metrics.length; i++) ...[
                      Expanded(
                        child: _MetricItem(
                          number: metrics[i].$1,
                          label: metrics[i].$2,
                        ),
                      ),
                      if (i < metrics.length - 1)
                        Container(
                          width: 1,
                          height: 40,
                          color: Palette.hairline,
                        ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String number;
  final String label;

  const _MetricItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontFamily: Fonts.title,
            fontSize: 38,
            fontWeight: FontWeight.w800,
            color: Palette.dark,
            letterSpacing: -1.4,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: Fonts.body,
            fontSize: 12.5,
            color: Palette.textSecondary,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _PrimaryButton({
    required this.label,
    this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.97 : 1.0;
    final lift = _isHovered && !_isPressed ? -2.0 : 0.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 120),
          curve: AppCurves.cloud,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: AppCurves.cloud,
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 17),
            transform: Matrix4.translationValues(0, lift, 0),
            decoration: BoxDecoration(
              color: Palette.dark,
              borderRadius: BorderRadius.circular(AppRadii.pill),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: Palette.dark.withValues(alpha: 0.22),
                        blurRadius: 36,
                        offset: const Offset(0, 12),
                      ),
                      const BoxShadow(
                        color: Color(0x0A000000),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ]
                  : const [
                      BoxShadow(
                        color: Color(0x14000000),
                        blurRadius: 18,
                        offset: Offset(0, 6),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize:
                  widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.label,
                  style: const TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _SecondaryButton({
    required this.label,
    this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _isPressed ? 0.97 : 1.0;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() {
        _isHovered = false;
        _isPressed = false;
      }),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 120),
          curve: AppCurves.cloud,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: AppCurves.cloud,
            width: widget.fullWidth ? double.infinity : null,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 17),
            decoration: BoxDecoration(
              color: _isHovered
                  ? Colors.white.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.35),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(
                color: _isHovered
                    ? Palette.dark.withValues(alpha: 0.5)
                    : Palette.dark.withValues(alpha: 0.18),
                width: 1,
              ),
            ),
            child: Text(
              widget.label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: Fonts.body,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Palette.dark,
                letterSpacing: 0.2,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
