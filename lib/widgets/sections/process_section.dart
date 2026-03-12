import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Process section showing the 5-step development workflow.
class ProcessSection extends StatelessWidget {
  final bool isMobile;

  const ProcessSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;

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
                    label: 'How We Work',
                    title: 'From Idea to Launch\nin 5 Steps',
                    subtitle:
                        'A proven process that reduces risk and delivers results. '
                        'Transparent, predictable, and collaborative.',
                    labelColor: Palette.primary.withValues(alpha: 0.8),
                    titleColor: Colors.white,
                  ),
                ),
                SizedBox(height: isSmall ? 48 : 80),
                isSmall
                    ? _buildVerticalTimeline()
                    : _buildHorizontalTimeline(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHorizontalTimeline() {
    return AnimatedSection(
      delay: const Duration(milliseconds: 200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < _steps.length; i++) ...[
            Expanded(child: _StepCard(step: _steps[i], index: i)),
            if (i < _steps.length - 1)
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Palette.primary.withValues(alpha: 0.4),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _buildVerticalTimeline() {
    return Column(
      children: [
        for (int i = 0; i < _steps.length; i++) ...[
          AnimatedSection(
            delay: Duration(milliseconds: 100 * (i + 1)),
            child: _StepCard(step: _steps[i], index: i),
          ),
          if (i < _steps.length - 1)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Icon(
                Icons.arrow_downward,
                size: 20,
                color: Palette.primary.withValues(alpha: 0.4),
              ),
            ),
        ],
      ],
    );
  }
}

class _StepData {
  final IconData icon;
  final String title;
  final String description;

  const _StepData({
    required this.icon,
    required this.title,
    required this.description,
  });
}

const _steps = [
  _StepData(
    icon: Icons.search,
    title: 'Discovery',
    description: 'We learn your business, goals, and requirements. Define scope and roadmap.',
  ),
  _StepData(
    icon: Icons.palette,
    title: 'Design',
    description: 'Wireframes, prototypes, and UI/UX design. You approve before we code.',
  ),
  _StepData(
    icon: Icons.code,
    title: 'Develop',
    description: 'Agile sprints with weekly demos. You see progress in real time.',
  ),
  _StepData(
    icon: Icons.rocket_launch,
    title: 'Deploy',
    description: 'Testing, QA, and launch. We handle infrastructure and go-live.',
  ),
  _StepData(
    icon: Icons.support_agent,
    title: 'Support',
    description: 'Ongoing maintenance, updates, and scaling as your business grows.',
  ),
];

class _StepCard extends StatelessWidget {
  final _StepData step;
  final int index;

  const _StepCard({required this.step, required this.index});

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
              color: Palette.primary.withValues(alpha: 0.12),
              shape: BoxShape.circle,
              border: Border.all(
                color: Palette.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Center(
              child: Icon(
                step.icon,
                size: 24,
                color: Palette.primary,
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
              letterSpacing: 2,
              color: Palette.primary.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: Fonts.title,
              fontSize: 18,
              color: Colors.white,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            step.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.4),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
