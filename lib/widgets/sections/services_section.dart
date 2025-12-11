import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

class ServicesSection extends StatelessWidget {
  final bool isMobile;

  const ServicesSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 60 : 100,
      ),
      child: Column(
        children: [
          AnimatedSection(
            child: SectionHeader(
              label: 'Nuestros Servicios',
              title: 'Soluciones a tu medida',
              subtitle:
                  'Cada proyecto es único. Diseñamos y desarrollamos soluciones personalizadas que se adaptan perfectamente a tus necesidades.',
            ),
          ),
          SizedBox(height: isMobile ? 40 : 60),
          _buildServicesGrid(),
        ],
      ),
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {
        'icon': Icons.smartphone_outlined,
        'title': 'Aplicaciones Móviles',
        'description':
            'Creamos aplicaciones móviles intuitivas y atractivas para iOS y Android, diseñadas para ofrecer una experiencia de usuario excepcional y adaptarse a las necesidades específicas de tu negocio.',
      },
      {
        'icon': Icons.language_outlined,
        'title': 'Desarrollo Web',
        'description':
            'Diseñamos y desarrollamos sitios web modernos, rápidos y adaptables, enfocados en potenciar tu presencia digital y atraer más clientes con interfaces que convierten.',
      },
      {
        'icon': Icons.headset_mic_outlined,
        'title': 'Soporte & Mantenimiento',
        'description':
            'Tu tecnología siempre funcionando. Te acompañamos con asistencia técnica confiable, actualizaciones constantes y soporte continuo para garantizar el éxito de tus proyectos digitales.',
      },
    ];

    if (isMobile) {
      return Column(
        children: services.asMap().entries.map((entry) {
          return Padding(
            padding: EdgeInsets.only(bottom: entry.key < 2 ? 20 : 0),
            child: AnimatedSection(
              delay: Duration(milliseconds: 100 * entry.key),
              child: _ServiceCard(
                icon: entry.value['icon'] as IconData,
                title: entry.value['title'] as String,
                description: entry.value['description'] as String,
                isMobile: true,
              ),
            ),
          );
        }).toList(),
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: services.asMap().entries.map((entry) {
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              left: entry.key > 0 ? 16 : 0,
              right: entry.key < 2 ? 16 : 0,
            ),
            child: AnimatedSection(
              delay: Duration(milliseconds: 100 * entry.key),
              child: _ServiceCard(
                icon: entry.value['icon'] as IconData,
                title: entry.value['title'] as String,
                description: entry.value['description'] as String,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ServiceCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final bool isMobile;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    this.isMobile = false,
  });

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
        curve: AppTransitions.smooth,
        padding: EdgeInsets.all(widget.isMobile ? 24 : 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Palette.dark.withValues(alpha: 0.08),
          ),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Palette.dark.withValues(alpha: 0.12),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ]
              : [],
        ),
        transform: _isHovered
            ? Matrix4.translationValues(0.0, -10.0, 0.0)
            : Matrix4.identity(),
        child: Stack(
          children: [
            // Top accent line
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AnimatedContainer(
                duration: AppTransitions.normal,
                height: _isHovered ? 4 : 0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Palette.primary, Palette.primaryLight],
                  ),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                AnimatedContainer(
                  duration: AppTransitions.normal,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Palette.primary, Palette.primaryLight],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  transform: _isHovered
                      ? (Matrix4.diagonal3Values(1.1, 1.1, 1.0)..rotateZ(-0.087))
                      : Matrix4.identity(),
                  child: Icon(
                    widget.icon,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                // Title
                Text(
                  widget.title,
                  style: TextStyle(
                    fontFamily: Fonts.title,
                    fontSize: widget.isMobile ? 20 : 24,
                    fontWeight: FontWeight.w700,
                    color: Palette.dark,
                  ),
                ),
                const SizedBox(height: 12),
                // Description
                Text(
                  widget.description,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: widget.isMobile ? 14 : 16,
                    color: Palette.darkLight,
                    height: 1.7,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
