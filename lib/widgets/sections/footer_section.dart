import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;
  final Function(String)? onNavTap;

  const FooterSection({super.key, this.isMobile = false, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;

    return Container(
      color: Palette.dark,
      padding: EdgeInsets.only(
        top: isSmall ? 48 : 64,
        bottom: isSmall ? 24 : 32,
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              _buildColumns(isSmall, isTablet),
              SizedBox(height: isSmall ? 32 : 48),
              _buildBottomBar(isSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumns(bool isSmall, bool isTablet) {
    if (isSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandColumn(),
          const SizedBox(height: 32),
          _buildProductsColumn(),
          const SizedBox(height: 32),
          _buildCompanyColumn(),
          const SizedBox(height: 32),
          _buildContactColumn(),
        ],
      );
    }

    if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildBrandColumn()),
              const SizedBox(width: 48),
              Expanded(child: _buildProductsColumn()),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildCompanyColumn()),
              const SizedBox(width: 48),
              Expanded(child: _buildContactColumn()),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildBrandColumn()),
        const SizedBox(width: 48),
        Expanded(child: _buildProductsColumn()),
        const SizedBox(width: 48),
        Expanded(child: _buildCompanyColumn()),
        const SizedBox(width: 48),
        Expanded(child: _buildContactColumn()),
      ],
    );
  }

  Widget _buildBrandColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontFamily: Fonts.brand,
              fontSize: 30,
              color: Colors.white,
            ),
            children: const [
              TextSpan(
                text: 'inspirare.pp',
                style: TextStyle(color: Palette.background),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            'Creamos experiencias digitales que inspiran. Somos una empresa de software salvadore\u00f1a construyendo el futuro de la gesti\u00f3n empresarial con IA.',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.4),
              height: 1.7,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductsColumn() {
    return _FooterColumn(
      title: 'PRODUCTOS',
      links: [
        _FooterLink(
          text: 'Factura F\u00e1cil DTE',
          onTap: () => launchUrl(Uri.parse('https://dte.inspirare.app')),
        ),
        _FooterLink(
          text: 'ContaSAS.ia',
          onTap: () => launchUrl(Uri.parse('https://contasas.inspirare.app')),
        ),
      ],
    );
  }

  Widget _buildCompanyColumn() {
    return _FooterColumn(
      title: 'EMPRESA',
      links: [
        _FooterLink(text: 'Nosotros', onTap: () => onNavTap?.call('nosotros')),
        _FooterLink(text: 'Precios', onTap: () => onNavTap?.call('precios')),
        _FooterLink(
          text: 'Contacto',
          onTap: () => launchUrl(Uri.parse('https://wa.me/50379336960')),
        ),
      ],
    );
  }

  Widget _buildContactColumn() {
    return _FooterColumn(
      title: 'CONTACTO',
      links: [
        _FooterLink(
          text: 'info@inspirare.app',
          onTap: () => launchUrl(Uri.parse('mailto:info@inspirare.app')),
        ),
        _FooterLink(
          text: '+503 7933-6960',
          onTap: () => launchUrl(Uri.parse('https://wa.me/50379336960')),
        ),
        _FooterLink(text: 'Soyapango, El Salvador'),
      ],
    );
  }

  Widget _buildBottomBar(bool isSmall) {
    return Container(
      padding: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: isSmall
          ? Column(
              children: [
                Text(
                  '\u00a9 2026 INSPIRARE, S.A.S. \u2014 NIT: 0622-151025-101-4',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterLegalLink(text: 'T\u00e9rminos'),
                    const SizedBox(width: 24),
                    _FooterLegalLink(text: 'Privacidad'),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\u00a9 2026 INSPIRARE, S.A.S. \u2014 NIT: 0622-151025-101-4',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                Row(
                  children: [
                    _FooterLegalLink(text: 'T\u00e9rminos'),
                    const SizedBox(width: 24),
                    _FooterLegalLink(text: 'Privacidad'),
                  ],
                ),
              ],
            ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<_FooterLink> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        ...links,
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _FooterLink({required this.text, this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: AppTransitions.fast,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 14,
              color: _isHovered
                  ? Palette.primary
                  : Colors.white.withValues(alpha: 0.4),
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}

class _FooterLegalLink extends StatefulWidget {
  final String text;

  const _FooterLegalLink({required this.text});

  @override
  State<_FooterLegalLink> createState() => _FooterLegalLinkState();
}

class _FooterLegalLinkState extends State<_FooterLegalLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedDefaultTextStyle(
        duration: AppTransitions.fast,
        style: TextStyle(
          fontFamily: Fonts.body,
          fontSize: 13,
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.25),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
