import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/atmospheric_backdrop.dart';
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

    return AtmosphericBackdrop(
      mood: BackdropMood.ambient,
      cloudCount: 3,
      child: Padding(
        padding: EdgeInsets.only(
          left: isSmall ? 24 : 40,
          right: isSmall ? 24 : 40,
          top: isSmall ? 64 : 120,
          bottom: isSmall ? 88 : 140,
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
                SizedBox(height: isSmall ? 48 : 72),
                _buildGrid(context, isSmall, isTablet),
              ],
            ),
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

    // Single accent (primary) — color signals "INSPIRARE", not category.
    // Keeps the grid focused on content rather than icon-color sorting.
    final iconBg = Palette.primary.withValues(alpha: 0.12);
    final iconBgColors = List<Color>.filled(6, iconBg);

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
              ? Colors.white
              : Colors.white.withValues(alpha: 0.92),
          border: Border.all(
            color: _isHovered
                ? Palette.primaryDark.withValues(alpha: 0.28)
                : Colors.white.withValues(alpha: 0.85),
          ),
          borderRadius: BorderRadius.circular(AppRadii.lg),
          boxShadow: _isHovered ? CloudShadows.lifted : CloudShadows.soft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: widget.data.iconBg,
                borderRadius: BorderRadius.circular(AppRadii.md),
              ),
              child: Center(
                child: Icon(
                  widget.data.icon,
                  size: 22,
                  color: Palette.primaryDark,
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
                letterSpacing: -0.4,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.data.description,
              style: const TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.textSecondary,
                height: 1.65,
              ),
            ),
            const SizedBox(height: 20),
            const Spacer(),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: widget.data.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Palette.primary.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(AppRadii.sm),
                      ),
                      child: Text(
                        tag,
                        style: const TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Palette.primaryDark,
                          letterSpacing: 0.2,
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
