import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_events.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Pricing section with engagement model cards.
class PricingSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onContactTap;

  const PricingSection({
    super.key,
    this.isMobile = false,
    this.onContactTap,
  });

  // Unified accent — uses the brand teal across all tiers.
  // Featured card differentiation comes from border + badge, not color noise.
  static const _accentGradients = [
    [Palette.dark, Palette.darkLight],
    [Palette.primaryDark, Palette.primary],
    [Palette.dark, Palette.darkLight],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final s = AppStrings.of(context);
    final cards = s.pricingCards;

    return Container(
      color: Palette.background,
      padding: EdgeInsets.only(
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
        top: isSmall ? 80 : 120,
        bottom: isSmall ? 80 : 120,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: s.pricingLabel,
                  title: s.pricingTitle,
                  subtitle: s.pricingSubtitle,
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              AnimatedSection(
                delay: const Duration(milliseconds: 300),
                child: _buildCards(s, cards, isSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCards(
      AppStrings s, List<PricingCardStrings> cards, bool isSmall) {
    const tierIds = [
      CtaIds.pricingFixed,
      CtaIds.pricingTimeMaterials,
      CtaIds.pricingDedicated,
    ];
    final cardWidgets = List.generate(
      cards.length,
      (i) => _PricingCard(
        title: cards[i].title,
        description: cards[i].description,
        idealForLabel: s.pricingIdealFor,
        idealFor: cards[i].idealFor,
        features: cards[i].features,
        accentGradient: _accentGradients[i],
        isFeatured: i == 1,
        mostPopularLabel: s.pricingMostPopular,
        ctaLabel: s.pricingCta,
        onContactTap: () {
          AnalyticsService.instance.logPricingSelect(tierId: tierIds[i]);
          onContactTap?.call();
        },
      ),
    );

    if (isSmall) {
      return Column(
        children: [
          for (int i = 0; i < cardWidgets.length; i++) ...[
            cardWidgets[i],
            if (i < cardWidgets.length - 1) const SizedBox(height: 24),
          ],
        ],
      );
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < cardWidgets.length; i++) ...[
            Expanded(child: cardWidgets[i]),
            if (i < cardWidgets.length - 1) const SizedBox(width: 24),
          ],
        ],
      ),
    );
  }
}

class _PricingCard extends StatefulWidget {
  final String title;
  final String description;
  final String idealForLabel;
  final String idealFor;
  final List<String> features;
  final List<Color> accentGradient;
  final bool isFeatured;
  final String mostPopularLabel;
  final String ctaLabel;
  final VoidCallback? onContactTap;

  const _PricingCard({
    required this.title,
    required this.description,
    required this.idealForLabel,
    required this.idealFor,
    required this.features,
    required this.accentGradient,
    this.isFeatured = false,
    required this.mostPopularLabel,
    required this.ctaLabel,
    this.onContactTap,
  });

  @override
  State<_PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<_PricingCard> {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        curve: AppCurves.easeOutStrong,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.isFeatured
                ? Palette.primaryDark.withValues(alpha: 0.45)
                : Palette.hairline,
            width: widget.isFeatured ? 1.5 : 1,
          ),
          boxShadow: _isHovered || widget.isFeatured
              ? [
                  BoxShadow(
                    color: widget.isFeatured
                        ? Palette.primary.withValues(alpha: 0.14)
                        : Palette.dark.withValues(alpha: 0.06),
                    blurRadius: widget.isFeatured ? 40 : 32,
                    offset: const Offset(0, 10),
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        // Outer Column uses spaceBetween with two non-flex children so it works
        // inside IntrinsicHeight without "unbounded constraints" errors.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Top group: accent bar + content (excludes CTA).
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: widget.isFeatured ? 36 : 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: widget.accentGradient),
                  ),
                  child: widget.isFeatured
                      ? Center(
                          child: Text(
                            widget.mostPopularLabel.toUpperCase(),
                            style: const TextStyle(
                              fontFamily: Fonts.body,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : null,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 32, 32, 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontFamily: Fonts.title,
                      fontSize: 24,
                      color: Palette.dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.textMuted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.background,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Palette.hairline),
                    ),
                    child: Text(
                      '${widget.idealForLabel} ${widget.idealFor}',
                      style: const TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Palette.textSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Features
                  ...widget.features.map(
                    (feature) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withValues(alpha: 0.04),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '\u2713',
                            style: TextStyle(
                              color: Palette.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontFamily: Fonts.body,
                                fontSize: 14,
                                color: Palette.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                    ],
                  ),
                ),
              ],
            ),
            // Bottom: CTA — anchored to card bottom via spaceBetween.
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 32, 32),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => setState(() => _isButtonHovered = true),
                onExit: (_) => setState(() => _isButtonHovered = false),
                child: GestureDetector(
                  onTap: widget.onContactTap,
                  child: AnimatedContainer(
                    duration: AppTransitions.fast,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    transform: _isButtonHovered
                        ? Matrix4.translationValues(0, -2, 0)
                        : Matrix4.identity(),
                    decoration: BoxDecoration(
                      color: Palette.dark,
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: _isButtonHovered
                          ? [
                              BoxShadow(
                                color: Palette.dark.withValues(alpha: 0.3),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ]
                          : [],
                    ),
                    child: Center(
                      child: Text(
                        widget.ctaLabel,
                        style: const TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
