import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Portfolio section with case study cards.
class PortfolioSection extends StatelessWidget {
  final bool isMobile;

  const PortfolioSection({super.key, this.isMobile = false});

  static const _liveUrls = [
    'https://contasas.inspirare.app',
    'https://dte.inspirare.app',
    'https://elbichoia.com',
    'https://trama.store',
  ];

  static const _accentColors = [
    Color(0xFF08C4D4),
    Color(0xFF0D1753),
    Color(0xFF2DB764),
    Color(0xFFF4A259),
  ];

  static const _projectTags = [
    ['Flutter Web', 'Firebase', 'Vertex AI', 'RAG'],
    ['Flutter Web', 'Firebase', 'Government API', 'SaaS'],
    ['Vertex AI', 'Gemma 3', 'QLoRA', 'RAG', 'Flutter Web'],
    ['Flutter Web', 'Firebase', 'E-Commerce'],
  ];

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
                  label: s.portfolioLabel,
                  title: s.portfolioTitle,
                  subtitle: s.portfolioSubtitle,
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              _buildProjects(context, isSmall, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjects(BuildContext context, bool isSmall, bool isTablet) {
    final s = AppStrings.of(context);
    final projectStrings = s.projects;

    final projects = List.generate(
      projectStrings.length,
      (i) => _ProjectData(
        name: projectStrings[i].name,
        subtitle: projectStrings[i].subtitle,
        challenge: projectStrings[i].challenge,
        solution: projectStrings[i].solution,
        results: projectStrings[i].results,
        tags: _projectTags[i],
        accentColor: _accentColors[i],
        status: projectStrings[i].status,
        liveUrl: _liveUrls[i],
      ),
    );

    if (isSmall) {
      return Column(
        children: [
          for (int i = 0; i < projects.length; i++) ...[
            AnimatedSection(
              delay: Duration(milliseconds: 100 * (i + 1)),
              child: _ProjectCard(data: projects[i]),
            ),
            if (i < projects.length - 1) const SizedBox(height: 24),
          ],
        ],
      );
    }

    final rows = <Widget>[];
    for (int i = 0; i < projects.length; i += 2) {
      final rowWidgets = <Widget>[
        Expanded(
          child: AnimatedSection(
            delay: Duration(milliseconds: 100 * (i + 1)),
            child: _ProjectCard(data: projects[i]),
          ),
        ),
      ];
      if (i + 1 < projects.length) {
        rowWidgets.add(const SizedBox(width: 24));
        rowWidgets.add(
          Expanded(
            child: AnimatedSection(
              delay: Duration(milliseconds: 100 * (i + 2)),
              child: _ProjectCard(data: projects[i + 1]),
            ),
          ),
        );
      } else {
        rowWidgets.add(const SizedBox(width: 24));
        rowWidgets.add(const Expanded(child: SizedBox()));
      }
      rows.add(Row(crossAxisAlignment: CrossAxisAlignment.start, children: rowWidgets));
      if (i + 2 < projects.length) {
        rows.add(const SizedBox(height: 24));
      }
    }

    return Column(children: rows);
  }
}

class _ProjectData {
  final String name;
  final String subtitle;
  final String challenge;
  final String solution;
  final List<String> results;
  final List<String> tags;
  final Color accentColor;
  final String status;
  final String? liveUrl;

  const _ProjectData({
    required this.name,
    this.subtitle = '',
    required this.challenge,
    required this.solution,
    required this.results,
    required this.tags,
    required this.accentColor,
    required this.status,
    this.liveUrl,
  });
}

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;

  const _ProjectCard({required this.data});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
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
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.data.accentColor,
                    widget.data.accentColor.withValues(alpha: 0.6),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status + Name
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Palette.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Text(
                          widget.data.status,
                          style: const TextStyle(
                            fontFamily: Fonts.body,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Palette.success,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.data.name,
                    style: const TextStyle(
                      fontFamily: Fonts.title,
                      fontSize: 22,
                      color: Palette.dark,
                      letterSpacing: -0.3,
                    ),
                  ),
                  if (widget.data.subtitle.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      widget.data.subtitle,
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                        color: Palette.textMuted.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  // Challenge
                  _SectionLabel(label: s.portfolioChallenge),
                  const SizedBox(height: 6),
                  Text(
                    widget.data.challenge,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Solution
                  _SectionLabel(label: s.portfolioSolution),
                  const SizedBox(height: 6),
                  Text(
                    widget.data.solution,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.textSecondary,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Results
                  _SectionLabel(label: s.portfolioResults),
                  const SizedBox(height: 6),
                  ...widget.data.results.map(
                    (result) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '\u2713',
                            style: TextStyle(
                              color: Palette.success,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              result,
                              style: const TextStyle(
                                fontFamily: Fonts.body,
                                fontSize: 13,
                                color: Palette.textSecondary,
                                height: 1.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tags
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
                  if (widget.data.liveUrl != null) ...[
                    const SizedBox(height: 20),
                    _ViewLiveButton(
                      url: widget.data.liveUrl!,
                      label: s.portfolioViewLive,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ViewLiveButton extends StatefulWidget {
  final String url;
  final String label;

  const _ViewLiveButton({required this.url, required this.label});

  @override
  State<_ViewLiveButton> createState() => _ViewLiveButtonState();
}

class _ViewLiveButtonState extends State<_ViewLiveButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => safeLaunchUrl(context, widget.url),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.open_in_new,
              size: 14,
              color: _isHovered ? Palette.primary : Palette.textMuted,
            ),
            const SizedBox(width: 6),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: _isHovered ? Palette.primary : Palette.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: Fonts.body,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: Palette.textMuted.withValues(alpha: 0.7),
      ),
    );
  }
}
