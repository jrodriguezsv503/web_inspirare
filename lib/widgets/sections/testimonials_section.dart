import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

class TestimonialsSection extends StatelessWidget {
  final bool isMobile;

  const TestimonialsSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Palette.background,
            const Color(0xFFF5F0EC),
          ],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          AnimatedSection(
            child: SectionHeader(
              label: 'Historias de Éxito',
              title: 'Lo que dicen nuestros clientes',
              subtitle:
                  'La satisfacción de nuestros clientes es nuestra mayor motivación.',
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          _buildTestimonialsGrid(),
        ],
      ),
    );
  }

  Widget _buildTestimonialsGrid() {
    final testimonials = [
      {
        'logo': 'assets/images/semyp.webp',
        'text':
            'El equipo de Inspirare ha sido fundamental para el éxito de nuestro proyecto. Su dedicación, creatividad y profesionalismo han superado nuestras expectativas. Gracias a ellos, implementamos nuestro sistema de facturación electrónica en tiempo récord.',
        'author': 'Gerente General',
        'company': 'SEMYP',
      },
      {
        'logo': 'assets/images/aucom.webp',
        'text':
            'Trabajar con Inspirare ha sido una experiencia excepcional. La dedicación y profesionalismo de su equipo nos permitieron implementar nuestro sistema de facturación electrónica en tiempo récord. Sin duda, son el socio tecnológico ideal.',
        'author': 'Gerente General',
        'company': 'AUCOM S.A. de C.V.',
      },
    ];

    if (isMobile) {
      return Column(
        children: testimonials.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: entry.key < 1 ? 24 : 0),
            child: AnimatedSection(
              delay: Duration(milliseconds: 150 * entry.key),
              child: _TestimonialCard(
                logoPath: entry.value['logo'] as String,
                text: entry.value['text'] as String,
                author: entry.value['author'] as String,
                company: entry.value['company'] as String,
                isMobile: true,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: testimonials.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: entry.key > 0 ? 16 : 0,
              right: entry.key < 1 ? 16 : 0,
            ),
            child: AnimatedSection(
              delay: Duration(milliseconds: 150 * entry.key),
              child: _TestimonialCard(
                logoPath: entry.value['logo'] as String,
                text: entry.value['text'] as String,
                author: entry.value['author'] as String,
                company: entry.value['company'] as String,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _TestimonialCard extends StatefulWidget {
  final String logoPath;
  final String text;
  final String author;
  final String company;
  final bool isMobile;

  const _TestimonialCard({
    required this.logoPath,
    required this.text,
    required this.author,
    required this.company,
    this.isMobile = false,
  });

  @override
  State<_TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<_TestimonialCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        padding: EdgeInsets.all(widget.isMobile ? 24 : 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Palette.dark.withValues(alpha: _isHovered ? 0.1 : 0.06),
              blurRadius: _isHovered ? 60 : 40,
              offset: Offset(0, _isHovered ? 20 : 10),
            ),
          ],
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -5.0, 0.0)
            : Matrix4.identity(),
        child: Stack(
          children: [
            // Quote icon
            Positioned(
              top: 0,
              right: 0,
              child: Icon(
                Icons.format_quote,
                size: 48,
                color: Palette.primary.withValues(alpha: 0.2),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                AnimatedContainer(
                  duration: AppTransitions.normal,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        _isHovered ? Colors.transparent : Colors.grey,
                        _isHovered ? BlendMode.dst : BlendMode.saturation,
                      ),
                      child: Opacity(
                        opacity: _isHovered ? 1.0 : 0.7,
                        child: Image.asset(
                          widget.logoPath,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Text
                Text(
                  '"${widget.text}"',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: widget.isMobile ? 15 : 17,
                    fontStyle: FontStyle.italic,
                    color: Palette.dark,
                    height: 1.8,
                  ),
                ),
                const SizedBox(height: 24),
                // Divider
                Container(
                  height: 1,
                  color: Palette.dark.withValues(alpha: 0.1),
                ),
                const SizedBox(height: 20),
                // Author info
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.author,
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: widget.isMobile ? 15 : 16,
                        fontWeight: FontWeight.w600,
                        color: Palette.dark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.company,
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: widget.isMobile ? 14 : 15,
                        fontWeight: FontWeight.w500,
                        color: Palette.primary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
