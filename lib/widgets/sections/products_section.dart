import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Sección de productos mostrando Factura Fácil DTE y ContaSAS.ia.
class ProductsSection extends StatelessWidget {
  final bool isMobile;

  const ProductsSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;

    return Container(
      color: Palette.background,
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedSection(
                child: SectionHeader(
                  label: 'Nuestros Productos',
                  title: 'Dos plataformas.\nUn ecosistema.',
                  subtitle:
                      'Cada producto resuelve un problema real del mercado salvadoreño, con tecnología de clase mundial y precios accesibles.',
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              if (isTablet)
                Column(
                  children: [
                    AnimatedSection(
                      delay: const Duration(milliseconds: 100),
                      child: _DTEProductCard(),
                    ),
                    const SizedBox(height: 32),
                    AnimatedSection(
                      delay: const Duration(milliseconds: 200),
                      child: _ContaSASProductCard(),
                    ),
                  ],
                )
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AnimatedSection(
                        delay: const Duration(milliseconds: 100),
                        child: _DTEProductCard(),
                      ),
                    ),
                    const SizedBox(width: 32),
                    Expanded(
                      child: AnimatedSection(
                        delay: const Duration(milliseconds: 200),
                        child: _ContaSASProductCard(),
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProductTag extends StatefulWidget {
  @override
  State<_ProductTag> createState() => _ProductTagState();
}

class _ProductTagState extends State<_ProductTag>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulse = Tween<double>(
      begin: 1.0,
      end: 0.5,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Palette.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedBuilder(
            animation: _pulse,
            builder: (context, child) {
              return Opacity(opacity: _pulse.value, child: child);
            },
            child: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Palette.success,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(width: 6),
          const Text(
            'EN PRODUCCIÓN',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
              color: Palette.success,
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureTag extends StatelessWidget {
  final String label;

  const _FeatureTag(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Palette.dark.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: Fonts.body,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.textSecondary,
        ),
      ),
    );
  }
}

class _ProductLink extends StatefulWidget {
  final String text;
  final Color color;
  final String url;

  const _ProductLink({
    required this.text,
    required this.color,
    required this.url,
  });

  @override
  State<_ProductLink> createState() => _ProductLinkState();
}

class _ProductLinkState extends State<_ProductLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => safeLaunchUrl(context, widget.url),
        child: AnimatedContainer(
          duration: AppTransitions.fast,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
              AnimatedPadding(
                duration: AppTransitions.fast,
                padding: EdgeInsets.only(left: _isHovered ? 14 : 8),
                child: Icon(Icons.arrow_forward, size: 16, color: widget.color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DTEProductCard extends StatefulWidget {
  @override
  State<_DTEProductCard> createState() => _DTEProductCardState();
}

class _DTEProductCardState extends State<_DTEProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isSmall ? 32 : 48,
                  left: isSmall ? 24 : 40,
                  right: isSmall ? 24 : 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductTag(),
                    const SizedBox(height: 20),
                    Text(
                      'Factura Fácil DTE',
                      style: TextStyle(
                        fontFamily: Fonts.title,
                        fontSize: isSmall ? 26 : 32,
                        color: Palette.dark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Plataforma de facturación electrónica que te certifica como emisor DTE . Emite Facturas, Créditos Fiscales y Notas de Crédito y más en segundos.',
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 15,
                        color: Palette.textSecondary,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _FeatureTag('Factura Electrónica'),
                        _FeatureTag('Crédito Fiscal'),
                        _FeatureTag('Nota de Crédito'),
                        _FeatureTag('En la Nube'),
                        _FeatureTag('Disponible 24/7'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const _ProductLink(
                      text: 'Visitar dte.inspirare.app',
                      color: Palette.dtePrimary,
                      url: AppUrls.dteApp,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              _DTEMockup(isMobile: isSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _DTEMockup extends StatelessWidget {
  final bool isMobile;

  const _DTEMockup({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? 220 : 300,
      width: double.infinity,
      child: Image.asset(
        'assets/images/dte.png',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}

class _ContaSASProductCard extends StatefulWidget {
  @override
  State<_ContaSASProductCard> createState() => _ContaSASProductCardState();
}

class _ContaSASProductCardState extends State<_ContaSASProductCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? Matrix4.translationValues(0, -8, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 60,
                    offset: const Offset(0, 20),
                  ),
                ]
              : [],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: isSmall ? 32 : 48,
                  left: isSmall ? 24 : 40,
                  right: isSmall ? 24 : 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _ProductTag(),
                    const SizedBox(height: 20),
                    Text(
                      'ContaSAS.ia',
                      style: TextStyle(
                        fontFamily: Fonts.title,
                        fontSize: isSmall ? 26 : 32,
                        color: Palette.dark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Gestión contable y tributaria inteligente para contribuyente en El Salvador. Con asistente legal de IA basado en legislación salvadoreña.',
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 15,
                        color: Palette.textSecondary,
                        height: 1.7,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _FeatureTag('Declaración IVA F-07'),
                        _FeatureTag('Pago a Cuenta F-14'),
                        _FeatureTag('Libros Contables'),
                        _FeatureTag('Asistente IA'),
                        _FeatureTag('Alertas'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    const _ProductLink(
                      text: 'Visitar contasas.inspirare.app',
                      color: Palette.contasasPrimary,
                      url: AppUrls.contasasApp,
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
              _ContaSASMockup(isMobile: isSmall),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContaSASMockup extends StatelessWidget {
  final bool isMobile;

  const _ContaSASMockup({this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isMobile ? 220 : 300,
      width: double.infinity,
      child: Image.asset(
        'assets/images/contasas.png',
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
