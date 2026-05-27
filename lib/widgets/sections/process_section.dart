import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Process section showing the 5-step development workflow.
class ProcessSection extends StatelessWidget {
  final bool isMobile;

  const ProcessSection({super.key, this.isMobile = false});

  static const _stepIcons = [
    Icons.search,
    Icons.palette,
    Icons.code,
    Icons.rocket_launch,
    Icons.support_agent,
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final s = AppStrings.of(context);

    final steps = s.processSteps;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: Palette.dark),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isSmall ? 24 : 40,
          vertical: isSmall ? 80 : 120,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              children: [
                AnimatedSection(
                  child: SectionHeader(
                    label: s.processLabel,
                    title: s.processTitle,
                    subtitle: s.processSubtitle,
                    labelColor: Palette.primaryLight.withValues(alpha: 0.9),
                    titleColor: Colors.white,
                    subtitleColor: Colors.white.withValues(alpha: 0.72),
                  ),
                ),
                SizedBox(height: isSmall ? 48 : 80),
                isSmall
                    ? _buildVerticalTimeline(steps)
                    : _buildHorizontalTimeline(steps),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalTimeline(List<StepStrings> steps) {
    return AnimatedSection(
      delay: const Duration(milliseconds: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < steps.length; i++) ...[
            Expanded(
              child: _StepCard(
                title: steps[i].title,
                description: steps[i].description,
                icon: _stepIcons[i],
                index: i,
              ),
            ),
            if (i < steps.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 44),
                child: Icon(
                  Icons.arrow_forward,
                  size: 22,
                  color: Palette.primary.withValues(alpha: 0.7),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerticalTimeline(List<StepStrings> steps) {
    return Column(
      children: [
        for (int i = 0; i < steps.length; i++) ...[
          AnimatedSection(
            delay: Duration(milliseconds: 100 * (i + 1)),
            child: _StepCard(
              title: steps[i].title,
              description: steps[i].description,
              icon: _stepIcons[i],
              index: i,
            ),
          ),
          if (i < steps.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Container(
                width: 1,
                height: 28,
                color: Palette.primary.withValues(alpha: 0.4),
              ),
            ),
        ],
      ],
    );
  }
}

class _StepCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final int index;

  const _StepCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // Number circle
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.16),
              shape: BoxShape.circle,
              border: Border.all(
                color: Palette.primary.withValues(alpha: 0.35),
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                size: 24,
                color: Palette.primaryLight,
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Step number
          Text(
            '0${index + 1}',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.4,
              color: Palette.primary.withValues(alpha: 0.85),
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: Fonts.title,
              fontSize: 18,
              color: Colors.white,
              letterSpacing: -0.4,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 13.5,
              color: Colors.white.withValues(alpha: 0.72),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
