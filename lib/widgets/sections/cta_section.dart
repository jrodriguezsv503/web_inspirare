import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

class CTASection extends StatelessWidget {
  final bool isMobile;

  const CTASection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;

    return Container(
      color: Palette.background,
      child: Stack(
        children: [
          // Decorative radial gradient
          Positioned.fill(
            child: Center(
              child: Container(
                width: 500,
                height: 500,
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
          ),
          // Content
          Padding(
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
                  children: [
                    AnimatedSection(
                      child: SectionHeader(
                        label: 'Comienza Hoy',
                        title:
                            'Deja de perder tiempo\ncon procesos manuales',
                        subtitle:
                            '\u00danete a las empresas salvadore\u00f1as que ya automatizan su gesti\u00f3n tributaria y contable con INSPIRARE.',
                      ),
                    ),
                    const SizedBox(height: 40),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 300),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _CTAPrimaryButton(
                            label: 'Agendar una Demo',
                            onTap: () => launchUrl(
                              Uri.parse('https://wa.me/50379336960'),
                            ),
                            fullWidth: isSmall,
                          ),
                          _CTASecondaryButton(
                            label: 'info@inspirare.app',
                            onTap: () => launchUrl(
                              Uri.parse('mailto:info@inspirare.app'),
                            ),
                            fullWidth: isSmall,
                          ),
                        ],
                      ),
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
}

class _CTAPrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _CTAPrimaryButton({
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_CTAPrimaryButton> createState() => _CTAPrimaryButtonState();
}

class _CTAPrimaryButtonState extends State<_CTAPrimaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTransitions.fast,
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Palette.dark,
            borderRadius: BorderRadius.circular(100),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Palette.dark.withValues(alpha: 0.25),
                      blurRadius: 30,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize:
                widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward, size: 16, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _CTASecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool fullWidth;

  const _CTASecondaryButton({
    required this.label,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_CTASecondaryButton> createState() => _CTASecondaryButtonState();
}

class _CTASecondaryButtonState extends State<_CTASecondaryButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTransitions.fast,
          width: widget.fullWidth ? double.infinity : null,
          padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
          transform: _isHovered
              ? Matrix4.translationValues(0, -2, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(
              color: _isHovered
                  ? Palette.dark
                  : Palette.dark.withValues(alpha: 0.15),
              width: 1.5,
            ),
          ),
          child: Text(
            widget.label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Palette.dark,
            ),
          ),
        ),
      ),
    );
  }
}
