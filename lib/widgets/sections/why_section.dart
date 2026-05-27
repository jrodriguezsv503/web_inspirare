import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/atmospheric_backdrop.dart';
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

    return AtmosphericBackdrop(
      mood: BackdropMood.night,
      cloudCount: 4,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 24 : 40,
          vertical: isSmall ? 88 : 140,
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
                    labelColor: Palette.primaryLight.withValues(alpha: 0.9),
                    titleColor: Colors.white,
                    subtitleColor: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                SizedBox(height: isSmall ? 48 : 72),
                _buildGrid(context, isSmall, isTablet),
                SizedBox(height: isSmall ? 56 : 88),
                AnimatedSection(child: _TechStackRibbon(isMobile: isSmall)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, bool isSmall, bool isTablet) {
    final s = AppStrings.of(context);
    final cardStrings = s.whyCards;

    // Icon mapping by card meaning:
    // 0 DUNS verified, 1 IP ownership, 2 SaaS in production,
    // 3 Senior delivery, 4 Cloud-native, 5 Same timezone.
    const icons = [
      Icons.verified_outlined,
      Icons.lock_outline,
      Icons.trending_up,
      Icons.business_center_outlined,
      Icons.cloud_outlined,
      Icons.access_time,
    ];

    final cards = List.generate(
      cardStrings.length,
      (i) => _WhyCardData(
        icon: icons[i],
        title: cardStrings[i].title,
        description: cardStrings[i].description,
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
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowCards,
          ),
        ),
      );
      if (i + crossAxisCount < cards.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(children: rows);
  }
}

class _WhyCardData {
  final IconData icon;
  final String title;
  final String description;

  const _WhyCardData({
    required this.icon,
    required this.title,
    required this.description,
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
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 380),
        curve: AppCurves.cloud,
        padding: const EdgeInsets.all(28),
        transform: _isHovered
            ? Matrix4.translationValues(0, -3, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.07)
              : Colors.white.withValues(alpha: 0.035),
          border: Border.all(
            color: _isHovered
                ? Palette.primaryLight.withValues(alpha: 0.45)
                : Colors.white.withValues(alpha: 0.10),
          ),
          borderRadius: BorderRadius.circular(AppRadii.lg),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Palette.primary.withValues(alpha: 0.18),
                    blurRadius: 48,
                    offset: const Offset(0, 12),
                  ),
                ]
              : const [],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: Palette.primary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppRadii.md),
                border: Border.all(
                  color: Palette.primary.withValues(alpha: 0.28),
                ),
              ),
              child: Center(
                child: Icon(
                  widget.data.icon,
                  size: 20,
                  color: Palette.primaryLight,
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
                letterSpacing: -0.4,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 12),
            Flexible(
              child: Text(
                widget.data.description,
                overflow: TextOverflow.fade,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 14,
                  color: Colors.white.withValues(alpha: 0.72),
                  height: 1.6,
                ),
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
        vertical: 40,
        horizontal: isMobile ? 0 : 40,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
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
                    size: 20,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item,
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      color: Colors.white.withValues(alpha: 0.78),
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
