import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

class WhySection extends StatelessWidget {
  final bool isMobile;

  const WhySection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Palette.dark,
      ),
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
                        label: 'Por Qu\u00e9 INSPIRARE',
                        title:
                            'Construido para\nel mercado salvadore\u00f1o',
                        subtitle:
                            'No somos una adaptaci\u00f3n de software extranjero. Cada l\u00ednea de c\u00f3digo est\u00e1 dise\u00f1ada para la realidad de El Salvador.',
                        isLeftAligned: true,
                        labelColor: Palette.primary.withValues(alpha: 0.8),
                        titleColor: Colors.white,
                      ),
                    ),
                    SizedBox(height: isSmall ? 40 : 64),
                    _buildGrid(isSmall, isTablet),
                    SizedBox(height: isSmall ? 48 : 80),
                    // Tech stack ribbon
                    AnimatedSection(
                      child: _TechStackRibbon(isMobile: isSmall),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGrid(bool isSmall, bool isTablet) {
    final cards = [
      _WhyCardData(
        emoji: '\ud83e\udd16',
        title: 'IA Especializada',
        description:
            'Asistente legal entrenado con el C\u00f3digo de Comercio, C\u00f3digo Tributario y leyes salvadore\u00f1as. No es un chatbot gen\u00e9rico.',
        iconBg: Palette.contasasPrimary.withValues(alpha: 0.15),
      ),
      _WhyCardData(
        emoji: '\ud83c\uddf8\ud83c\uddfb',
        title: '100% Local',
        description:
            'Conocemos Hacienda, los formularios F-07 y F-14, el CNR, y cada particularidad del sistema tributario salvadore\u00f1o.',
        iconBg: Palette.accentWarm.withValues(alpha: 0.15),
      ),
      _WhyCardData(
        emoji: '\u2601\ufe0f',
        title: 'Cloud Native',
        description:
            'Infraestructura en Google Cloud y Firebase. Escalable, segura y disponible 24/7 sin necesidad de instalar nada.',
        iconBg: Palette.primary.withValues(alpha: 0.15),
      ),
      _WhyCardData(
        emoji: '\ud83d\udcf1',
        title: 'Mobile First',
        description:
            'Apps construidas con Flutter para rendimiento nativo en iOS y Android. Tu negocio en tu bolsillo.',
        iconBg: const Color(0xFF8B5CF6).withValues(alpha: 0.15),
      ),
      _WhyCardData(
        emoji: '\ud83d\udcb0',
        title: 'Precio Justo',
        description:
            'Planes desde \$14.99/mes. Tecnolog\u00eda de primer nivel a precios accesibles para la realidad centroamericana.',
        iconBg: Palette.success.withValues(alpha: 0.15),
      ),
      _WhyCardData(
        emoji: '\ud83d\udee1\ufe0f',
        title: 'Soporte Directo',
        description:
            'Habla directamente con los ingenieros que construyen el producto. Sin tickets, sin esperas, sin bots.',
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
              child: _WhyCard(data: cards[j]),
            ),
          ),
        );
        if (j < i + crossAxisCount - 1 && j < cards.length - 1) {
          rowCards.add(const SizedBox(width: 24));
        }
      }
      // Fill remaining space if row is not full
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
            // Icon
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
              style: TextStyle(
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
    final items = ['Flutter', 'Firebase', 'Google Cloud', 'Dart', 'AI/ML'];

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
      case 'Dart':
        return Icons.code;
      case 'AI/ML':
        return Icons.auto_awesome;
      default:
        return Icons.circle;
    }
  }
}
