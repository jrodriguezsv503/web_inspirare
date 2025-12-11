import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';

class AboutSection extends StatelessWidget {
  final bool isMobile;

  const AboutSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.dark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Stack(
        children: [
          // Decorative gradient
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Palette.primary.withValues(alpha: 0.1),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          // Content
          isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text content
        Expanded(
          child: AnimatedSection(
            child: _buildTextContent(),
          ),
        ),
        const SizedBox(width: 60),
        // Stats grid
        Expanded(
          child: AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: _buildStatsGrid(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        AnimatedSection(child: _buildTextContent()),
        const SizedBox(height: 40),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: _buildStatsGrid(),
        ),
      ],
    );
  }

  Widget _buildTextContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: Fonts.title,
              fontSize: isMobile ? 28 : 36,
              fontWeight: FontWeight.w800,
              color: Palette.background,
              height: 1.2,
            ),
            children: [
              const TextSpan(text: 'Transformamos ideas en '),
              TextSpan(
                text: 'realidades digitales',
                style: TextStyle(color: Palette.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'En Inspirare, somos un equipo de desarrolladores y diseñadores apasionados por la tecnología y la creación de productos digitales que marcan la diferencia. Combinamos creatividad y experiencia técnica para llevar tu visión al siguiente nivel.',
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: isMobile ? 16 : 18,
            color: Palette.background.withValues(alpha: 0.85),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Desde El Salvador para el mundo, construimos soluciones que no solo funcionan, sino que inspiran a quienes las usan.',
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: isMobile ? 16 : 18,
            color: Palette.background.withValues(alpha: 0.85),
            height: 1.8,
          ),
        ),
        const SizedBox(height: 32),
        // Mission box
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Palette.primary.withValues(alpha: 0.1),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            border: Border(
              left: BorderSide(color: Palette.primary, width: 3),
            ),
          ),
          child: Text(
            'Nuestra misión: Ayudarte a crecer en el mundo digital con herramientas confiables, seguras e innovadoras.',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: isMobile ? 15 : 17,
              fontStyle: FontStyle.italic,
              color: Palette.background.withValues(alpha: 0.9),
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    final stats = [
      {'number': '3+', 'label': 'Años de experiencia'},
      {'number': '15+', 'label': 'Proyectos entregados'},
      {'number': '100%', 'label': 'Clientes satisfechos'},
      {'number': '24/7', 'label': 'Soporte continuo'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: isMobile ? 12 : 20,
        mainAxisSpacing: isMobile ? 12 : 20,
        childAspectRatio: isMobile ? 1.3 : 1.5,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        return _StatCard(
          number: stats[index]['number']!,
          label: stats[index]['label']!,
          isMobile: isMobile,
        );
      },
    );
  }
}

class _StatCard extends StatefulWidget {
  final String number;
  final String label;
  final bool isMobile;

  const _StatCard({
    required this.number,
    required this.label,
    this.isMobile = false,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        padding: EdgeInsets.all(widget.isMobile ? 16 : 24),
        decoration: BoxDecoration(
          color: _isHovered
              ? Palette.primary.withValues(alpha: 0.1)
              : Palette.background.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: _isHovered
                ? Palette.primary
                : Palette.primary.withValues(alpha: 0.2),
          ),
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -5.0, 0.0)
            : Matrix4.identity(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.number,
              style: TextStyle(
                fontFamily: Fonts.title,
                fontSize: widget.isMobile ? 32 : 48,
                fontWeight: FontWeight.w800,
                color: Palette.primary,
                height: 1,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.label.toUpperCase(),
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: widget.isMobile ? 11 : 13,
                letterSpacing: 1.5,
                color: Palette.background.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
