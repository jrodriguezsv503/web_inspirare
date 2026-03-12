import 'package:flutter/material.dart';
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
              const AnimatedSection(
                child: SectionHeader(
                  label: 'What We Do',
                  title: 'End-to-End Software\nDevelopment',
                  subtitle:
                      'From idea to launch and beyond. We handle design, development, '
                      'and deployment so you can focus on growing your business.',
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              _buildGrid(isSmall, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGrid(bool isSmall, bool isTablet) {
    final cards = [
      _ServiceCardData(
        icon: Icons.web,
        title: 'Custom Web Applications',
        description:
            'Scalable, responsive web apps built with modern frameworks. '
            'From dashboards to SaaS platforms.',
        tags: ['Flutter Web', 'Firebase', 'Cloud Run'],
        iconBg: Palette.primary.withValues(alpha: 0.15),
      ),
      _ServiceCardData(
        icon: Icons.phone_iphone,
        title: 'Mobile App Development',
        description:
            'Native-quality iOS & Android apps from a single codebase. '
            'Faster delivery, lower cost.',
        tags: ['Flutter', 'iOS', 'Android'],
        iconBg: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
      ),
      _ServiceCardData(
        icon: Icons.rocket_launch,
        title: 'MVP & Startup Development',
        description:
            'Go from idea to market in weeks. We help startups validate, '
            'build, and launch their first product.',
        tags: ['Rapid Prototyping', 'Lean MVP'],
        iconBg: Palette.accentWarm.withValues(alpha: 0.15),
      ),
      _ServiceCardData(
        icon: Icons.auto_awesome,
        title: 'AI & ML Integration',
        description:
            'Add intelligent features to your apps — chatbots, document '
            'processing, predictive analytics, and more.',
        tags: ['Gemini', 'OpenAI', 'Custom Models'],
        iconBg: const Color(0xFF06B6D4).withValues(alpha: 0.15),
      ),
      _ServiceCardData(
        icon: Icons.cloud,
        title: 'Cloud Architecture',
        description:
            'Design and deploy on Google Cloud Platform and Firebase. '
            'Serverless, scalable, cost-optimized.',
        tags: ['GCP', 'Firebase', 'Cloud Functions'],
        iconBg: Palette.success.withValues(alpha: 0.15),
      ),
      _ServiceCardData(
        icon: Icons.palette,
        title: 'UI/UX Design',
        description:
            'User-centered design that converts. Research, wireframes, '
            'prototypes, and polished interfaces.',
        tags: ['Figma', 'User Research', 'Prototyping'],
        iconBg: const Color(0xFFEF4444).withValues(alpha: 0.15),
      ),
    ];

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
