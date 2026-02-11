import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onProductsTap;

  const HeroSection({super.key, this.isMobile = false, this.onProductsTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final heroFontSize = (screenWidth * 0.055).clamp(42.0, 72.0);

    return Container(
      color: Palette.background,
      padding: EdgeInsets.only(
        top: isSmall ? 130 : 160,
        bottom: isSmall ? 32 : 48,
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              // Badge
              AnimatedSection(child: _HeroBadge()),
              const SizedBox(height: 32),
              // Headline
              AnimatedSection(
                delay: const Duration(milliseconds: 100),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 820),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: Fonts.title,
                        fontSize: heroFontSize,
                        height: 1.08,
                        color: Palette.dark,
                        letterSpacing: -1.5,
                      ),
                      children: [
                        const TextSpan(text: 'Software que '),
                        TextSpan(
                          text: 'transforma',
                          style: TextStyle(
                            fontFamily: Fonts.brand,
                            fontStyle: FontStyle.italic,
                            color: Palette.primary,
                          ),
                        ),
                        const TextSpan(text: ' negocios en El Salvador'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Subtitle
              AnimatedSection(
                delay: const Duration(milliseconds: 200),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 540),
                  child: Text(
                    'Creamos plataformas SaaS con inteligencia artificial para automatizar la gesti\u00f3n tributaria, contable y financiera de empresas salvadore\u00f1as.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: isSmall ? 16 : 18,
                      color: Palette.textSecondary,
                      height: 1.7,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Action buttons
              AnimatedSection(
                delay: const Duration(milliseconds: 300),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    _PrimaryButton(
                      label: 'Conocer Productos',
                      onTap: onProductsTap,
                      fullWidth: isSmall,
                    ),
                    _SecondaryButton(
                      label: 'Hablar con el equipo',
                      onTap: () =>
                          launchUrl(Uri.parse('https://wa.me/50379336960')),
                      fullWidth: isSmall,
                    ),
                  ],
                ),
              ),
              SizedBox(height: isSmall ? 60 : 80),
              // Metrics bar
              AnimatedSection(
                delay: const Duration(milliseconds: 400),
                child: _MetricsBar(isMobile: isSmall),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeroBadge extends StatefulWidget {
  @override
  State<_HeroBadge> createState() => _HeroBadgeState();
}

class _HeroBadgeState extends State<_HeroBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Palette.primary.withValues(alpha: 0.1),
        border: Border.all(color: Palette.primary.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Opacity(
                opacity: _pulseAnimation.value,
                child: Transform.scale(
                  scale: 0.8 + (_pulseAnimation.value * 0.2),
                  child: child,
                ),
              );
            },
            child: Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Palette.primary,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '2 Productos en Producci\u00f3n y m\u00e1s en desarrollo',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Palette.primary,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsBar extends StatelessWidget {
  final bool isMobile;

  const _MetricsBar({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final metrics = [
      ('2', 'Productos en Producci\u00f3n'),
      ('SaaS', 'Modelo de Negocio'),
      ('IA', 'Integrada en Productos'),
      ('24/7', 'Plataforma Cloud'),
    ];

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 40,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
        ),
        padding: EdgeInsets.symmetric(vertical: isMobile ? 32 : 40),
        child: isMobile
            ? Wrap(
                alignment: WrapAlignment.center,
                spacing: 0,
                runSpacing: 24,
                children: metrics
                    .map(
                      (m) => SizedBox(
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: _MetricItem(number: m.$1, label: m.$2),
                      ),
                    )
                    .toList(),
              )
            : IntrinsicHeight(
                child: Row(
                  children: [
                    for (int i = 0; i < metrics.length; i++) ...[
                      Expanded(
                        child: _MetricItem(
                          number: metrics[i].$1,
                          label: metrics[i].$2,
                        ),
                      ),
                      if (i < metrics.length - 1)
                        Container(
                          width: 1,
                          height: 40,
                          color: Colors.black.withValues(alpha: 0.08),
                        ),
                    ],
                  ],
                ),
              ),
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  final String number;
  final String label;

  const _MetricItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          number,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            color: Palette.dark,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            color: Palette.textMuted,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _PrimaryButton({
    required this.label,
    this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
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
            mainAxisSize: widget.fullWidth
                ? MainAxisSize.max
                : MainAxisSize.min,
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

class _SecondaryButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool fullWidth;

  const _SecondaryButton({
    required this.label,
    this.onTap,
    this.fullWidth = false,
  });

  @override
  State<_SecondaryButton> createState() => _SecondaryButtonState();
}

class _SecondaryButtonState extends State<_SecondaryButton> {
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
