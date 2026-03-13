import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Services section with 6 service cards in a responsive grid.
class ServicesSection extends StatelessWidget {
  final bool isMobile;

  const ServicesSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;
    final s = AppStrings.of(context);

    return Container(
      color: Palette.background,
      padding: EdgeInsets.only(
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
        top: isSmall ? 40 : 60,
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
                  label: s.servicesLabel,
                  title: s.servicesTitle,
                  subtitle: s.servicesSubtitle,
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              _buildGrid(context, isSmall, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(BuildContext context, bool isSmall, bool isTablet) {
    final s = AppStrings.of(context);
    final cardStrings = s.serviceCards;

    final tags = [
      ['Flutter Web', 'Firebase', 'Cloud Run'],
      ['Flutter', 'iOS', 'Android'],
      ['Rapid Prototyping', 'Lean MVP'],
      ['Vertex AI', 'RAG', 'Fine-tuned Models'],
      ['GCP', 'Firebase', 'Cloud Functions'],
      ['Figma', 'User Research', 'Prototyping'],
    ];

    final iconBgColors = [
      Palette.primary.withValues(alpha: 0.15),
      const Color(0xFF8B5CF6).withValues(alpha: 0.15),
      Palette.accentWarm.withValues(alpha: 0.15),
      const Color(0xFF06B6D4).withValues(alpha: 0.15),
      Palette.success.withValues(alpha: 0.15),
      const Color(0xFFEF4444).withValues(alpha: 0.15),
    ];

    final icons = [
      Icons.web,
      Icons.phone_iphone,
      Icons.rocket_launch,
      Icons.auto_awesome,
      Icons.cloud,
      Icons.palette,
    ];

    final cards = List.generate(
      cardStrings.length,
      (i) => _ServiceCardData(
        icon: icons[i],
        title: cardStrings[i].title,
        description: cardStrings[i].description,
        tags: tags[i],
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
              child: _ServiceCard(data: cards[j]),
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

class _ServiceCardData {
  final IconData icon;
  final String title;
  final String description;
  final List<String> tags;
  final Color iconBg;

  const _ServiceCardData({
    required this.icon,
    required this.title,
    required this.description,
    required this.tags,
    required this.iconBg,
  });
}

class _ServiceCard extends StatefulWidget {
  final _ServiceCardData data;

  const _ServiceCard({required this.data});

  @override
  State<_ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<_ServiceCard> {
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
          color: Colors.white,
          border: Border.all(
            color: _isHovered
                ? Palette.primary.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.06),
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
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
                child: Icon(
                  widget.data.icon,
                  size: 24,
                  color: Palette.dark,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              widget.data.title,
              style: const TextStyle(
                fontFamily: Fonts.title,
                fontSize: 20,
                color: Palette.dark,
                letterSpacing: -0.3,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.data.description,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.textSecondary.withValues(alpha: 0.8),
                height: 1.7,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.data.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.dark.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Palette.textMuted,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
