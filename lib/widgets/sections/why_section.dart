import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Dark section "Why INSPIRARE" with 6 benefit cards and tech stack ribbon.
class WhySection extends StatelessWidget {
  final bool isMobile;

  const WhySection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;
    final s = AppStrings.of(context);

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Palette.dark),
      child: Stack(
        children: [
          // Decorative radial gradient
          Positioned(
            top: -200,
            right: -200,
            child: Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Palette.primary.withValues(alpha: 0.08),
                    Colors.transparent,
                  ],
                  stops: const [0.0, 0.7],
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isSmall ? 24 : 40,
              vertical: isSmall ? 80 : 120,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedSection(
                      child: SectionHeader(
                        label: s.whyLabel,
                        title: s.whyTitle,
                        subtitle: s.whySubtitle,
                        isLeftAligned: true,
                        labelColor: Palette.primary.withValues(alpha: 0.8),
                        titleColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: isSmall ? 40 : 64),
                    _buildGrid(context, isSmall, isTablet),
                    SizedBox(height: isSmall ? 48 : 80),
                    AnimatedSection(child: _TechStackRibbon(isMobile: isSmall)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(BuildContext context, bool isSmall, bool isTablet) {
    final s = AppStrings.of(context);
    final cardStrings = s.whyCards;

    final emojis = [
      '\u{1F6E1}\uFE0F',
      '\u{1F512}',
      '\u{1F680}',
      '\u{1F4BC}',
      '\u{2601}\uFE0F',
      '\u{1F30E}',
    ];

    final iconBgColors = [
      Palette.primary.withValues(alpha: 0.15),
      Palette.accentWarm.withValues(alpha: 0.15),
      const Color(0xFF8B5CF6).withValues(alpha: 0.15),
      const Color(0xFF06B6D4).withValues(alpha: 0.15),
      Palette.success.withValues(alpha: 0.15),
      const Color(0xFFEF4444).withValues(alpha: 0.15),
    ];

    final cards = List.generate(
      cardStrings.length,
      (i) => _WhyCardData(
        emoji: emojis[i],
        title: cardStrings[i].title,
        description: cardStrings[i].description,
        iconBg: iconBgColors[i],
      ),
    );

    int crossAxisCount;
    if (isSmall) {
      crossAxisCount = 1;
    } else if (isTablet) {
      crossAxisCount = 2;
    } else {
      crossAxisCount = 3;
    }

    final rows = <Widget>[];
    for (int i = 0; i < cards.length; i += crossAxisCount) {
      final rowCards = <Widget>[];
      for (int j = i; j < i + crossAxisCount && j < cards.length; j++) {
        rowCards.add(
          Expanded(
            child: AnimatedSection(
              delay: Duration(milliseconds: 100 * ((j % crossAxisCount) + 1)),
              child: _WhyCard(data: cards[j]),
            ),
          ),
        );
        if (j < i + crossAxisCount - 1 && j < cards.length - 1) {
          rowCards.add(const SizedBox(width: 24));
        }
      }
      while (rowCards.length < crossAxisCount * 2 - 1) {
        rowCards.add(const SizedBox(width: 24));
        rowCards.add(const Expanded(child: SizedBox()));
      }
      rows.add(Row(children: rowCards));
      if (i + crossAxisCount < cards.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(children: rows);
  }
}

class _WhyCardData {
  final String emoji;
  final String title;
  final String description;
  final Color iconBg;

  const _WhyCardData({
    required this.emoji,
    required this.title,
    required this.description,
    required this.iconBg,
  });
}

class _WhyCard extends StatefulWidget {
  final _WhyCardData data;

  const _WhyCard({required this.data});

  @override
  State<_WhyCard> createState() => _WhyCardState();
}

class _WhyCardState extends State<_WhyCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        padding: const EdgeInsets.all(32),
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.white.withValues(alpha: 0.04),
          border: Border.all(
            color: _isHovered
                ? Palette.primary.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.06),
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: widget.data.iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  widget.data.emoji,
                  style: const TextStyle(fontSize: 22),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.data.title,
              style: const TextStyle(
                fontFamily: Fonts.title,
                fontSize: 20,
                color: Colors.white,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.data.description,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Colors.white.withValues(alpha: 0.45),
                height: 1.7,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TechStackRibbon extends StatelessWidget {
  final bool isMobile;

  const _TechStackRibbon({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Flutter',
      'Firebase',
      'Google Cloud',
      'Vertex AI',
      'Stripe',
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 48,
        horizontal: isMobile ? 0 : 40,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: isMobile ? 24 : 48,
        runSpacing: 16,
        children: items
            .map(
              (item) => Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    _iconForTech(item),
                    size: 24,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item,
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  IconData _iconForTech(String tech) {
    switch (tech) {
      case 'Flutter':
        return Icons.flutter_dash;
      case 'Firebase':
        return Icons.local_fire_department;
      case 'Google Cloud':
        return Icons.cloud;
      case 'Vertex AI':
        return Icons.auto_awesome;
      case 'Stripe':
        return Icons.payment;
      default:
        return Icons.circle;
    }
  }
}
