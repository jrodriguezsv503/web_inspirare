import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';

class ContactSection extends StatelessWidget {
  final bool isMobile;

  const ContactSection({super.key, this.isMobile = false});

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
            bottom: -100,
            left: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Palette.primary.withValues(alpha: 0.15),
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
        // Contact info
        Expanded(
          child: AnimatedSection(
            child: _buildContactInfo(),
          ),
        ),
        const SizedBox(width: 60),
        // CTA Card
        Expanded(
          child: AnimatedSection(
            delay: const Duration(milliseconds: 200),
            child: _buildCtaCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        AnimatedSection(child: _buildContactInfo()),
        const SizedBox(height: 40),
        AnimatedSection(
          delay: const Duration(milliseconds: 200),
          child: _buildCtaCard(),
        ),
      ],
    );
  }

  Widget _buildContactInfo() {
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
              const TextSpan(text: '¡Hablemos de '),
              TextSpan(
                text: 'tu proyecto!',
                style: TextStyle(color: Palette.primary),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          'Estamos listos para hacer realidad tus ideas. Cuéntanos sobre tu proyecto y juntos encontraremos la mejor solución para llevarlo al siguiente nivel.',
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: isMobile ? 16 : 18,
            color: Palette.background.withValues(alpha: 0.8),
            height: 1.7,
          ),
        ),
        const SizedBox(height: 40),
        // Contact methods
        _ContactMethod(
          icon: Icons.phone_outlined,
          text: '+503 7933-6960',
          onTap: () => launchUrl(Uri.parse('tel:+50379336960')),
        ),
        const SizedBox(height: 16),
        _ContactMethod(
          icon: Icons.email_outlined,
          text: 'info@inspirare.app',
          onTap: () => launchUrl(Uri.parse('mailto:info@inspirare.app')),
        ),
        const SizedBox(height: 16),
        _ContactMethod(
          icon: Icons.language_outlined,
          text: 'inspirare.app',
          onTap: () => launchUrl(Uri.parse('https://inspirare.app')),
        ),
        const SizedBox(height: 16),
        _ContactMethod(
          icon: Icons.location_on_outlined,
          text: 'Soyapango, San Salvador, El Salvador',
          onTap: null,
        ),
      ],
    );
  }

  Widget _buildCtaCard() {
    return Container(
      padding: EdgeInsets.all(isMobile ? 32 : 48),
      decoration: BoxDecoration(
        color: Palette.background.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Palette.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          Text(
            '¿Listo para empezar?',
            style: TextStyle(
              fontFamily: Fonts.title,
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w700,
              color: Palette.background,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Respuesta en menos de 24 horas',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 16,
              color: Palette.background.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 32),
          // WhatsApp button
          _CtaButton(
            icon: FontAwesomeIcons.whatsapp,
            text: 'Chatea por WhatsApp',
            color: const Color(0xFF25D366),
            onTap: () => launchUrl(
              Uri.parse(
                'https://wa.me/50379336960?text=Hola%20Inspirare!%20Me%20interesa%20conocer%20más%20sobre%20sus%20servicios.',
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Email button
          _CtaButton(
            icon: Icons.email_outlined,
            text: 'Escríbenos un email',
            color: Colors.transparent,
            borderColor: Palette.primary,
            textColor: Palette.primary,
            onTap: () => launchUrl(Uri.parse('mailto:info@inspirare.app')),
          ),
        ],
      ),
    );
  }
}

class _ContactMethod extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  const _ContactMethod({
    required this.icon,
    required this.text,
    this.onTap,
  });

  @override
  State<_ContactMethod> createState() => _ContactMethodState();
}

class _ContactMethodState extends State<_ContactMethod> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTransitions.normal,
          transform: _isHovered
              ? Matrix4.translationValues(5.0, 0.0, 0.0)
              : Matrix4.identity(),
          child: Row(
            children: [
              AnimatedContainer(
                duration: AppTransitions.normal,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _isHovered
                      ? Palette.primary
                      : Palette.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.icon,
                  size: 20,
                  color: _isHovered ? Colors.white : Palette.primary,
                ),
              ),
              const SizedBox(width: 16),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 16,
                  color: _isHovered
                      ? Palette.primary
                      : Palette.background.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CtaButton extends StatefulWidget {
  final IconData icon;
  final String text;
  final Color color;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback onTap;

  const _CtaButton({
    required this.icon,
    required this.text,
    required this.color,
    this.borderColor,
    this.textColor,
    required this.onTap,
  });

  @override
  State<_CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<_CtaButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isOutlined = widget.color == Colors.transparent;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTransitions.normal,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          decoration: BoxDecoration(
            color: isOutlined
                ? (_isHovered ? widget.borderColor : Colors.transparent)
                : widget.color,
            borderRadius: BorderRadius.circular(50),
            border: widget.borderColor != null
                ? Border.all(color: widget.borderColor!, width: 2)
                : null,
            boxShadow: !isOutlined
                ? [
                    BoxShadow(
                      color: widget.color.withValues(alpha: _isHovered ? 0.4 : 0.3),
                      blurRadius: _isHovered ? 30 : 20,
                      offset: Offset(0, _isHovered ? 8 : 4),
                    ),
                  ]
                : null,
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -3.0, 0.0)
              : Matrix4.identity(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 24,
                color: isOutlined
                    ? (_isHovered ? Colors.white : widget.textColor)
                    : (widget.textColor ?? Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: isOutlined
                      ? (_isHovered ? Colors.white : widget.textColor)
                      : (widget.textColor ?? Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
