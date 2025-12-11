import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';

class HeroSection extends StatelessWidget {
  final bool isMobile;
  final VoidCallback? onMenuTap;
  final Function(String)? onNavTap;

  const HeroSection({
    super.key,
    this.isMobile = false,
    this.onMenuTap,
    this.onNavTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset('assets/images/1.webp', fit: BoxFit.cover),
          ),
          // Gradient overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Palette.dark.withValues(alpha: 0.3),
                    Palette.dark.withValues(alpha: 0.1),
                    Palette.dark.withValues(alpha: 0.5),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // Content
          Positioned.fill(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 20 : 80,
                vertical: isMobile ? 20 : 30,
              ),
              child: Column(
                children: [
                  // Navigation
                  _buildNavigation(context),
                  // Spacer
                  const Expanded(child: SizedBox()),
                  // Tagline
                  _buildTagline(),
                  SizedBox(height: isMobile ? 40 : 60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavigation(BuildContext context) {
    if (isMobile) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Inspirare',
            style: TextStyle(
              fontFamily: Fonts.brand,
              fontSize: 28,
              color: Palette.background,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white70, size: 32),
            onPressed: onMenuTap,
          ),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand
        Text(
          'Inspirare',
          style: TextStyle(
            fontFamily: Fonts.brand,
            fontSize: 48,
            color: Palette.background,
          ),
        ),
        // Nav links
        Row(
          children: [
            _NavLink(text: 'Nosotros', onTap: () => onNavTap?.call('nosotros')),
            const SizedBox(width: 40),
            _NavLink(
              text: 'Servicios',
              onTap: () => onNavTap?.call('servicios'),
            ),
            const SizedBox(width: 40),
            _NavLink(
              text: 'Historias',
              onTap: () => onNavTap?.call('historias'),
            ),
            const SizedBox(width: 40),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onNavTap?.call('contacto'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 28,
                    vertical: 14,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.primary,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.primary.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Contáctanos',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTagline() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.end,
        children: [
          Text(
            'Creamos experiencias digitales que ',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: isMobile ? 16 : 20,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Highlight background
              Positioned(
                bottom: 0,
                left: -4,
                right: -4,
                child: Transform(
                  transform: Matrix4.skewX(-0.1),
                  child: Container(
                    height: isMobile ? 12 : 16,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Palette.primary, Palette.primaryLight],
                      ),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              Text(
                'Inspiran',
                style: TextStyle(
                  fontFamily: Fonts.brand,
                  fontSize: isMobile ? 28 : 40,
                  fontWeight: FontWeight.w900,
                  color: Palette.background,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavLink extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _NavLink({required this.text, this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _isHovered ? Palette.background : Colors.white70,
              ),
            ),
            const SizedBox(height: 4),
            AnimatedContainer(
              duration: AppTransitions.normal,
              width: _isHovered ? 40 : 0,
              height: 2,
              decoration: BoxDecoration(
                color: Palette.primary,
                borderRadius: BorderRadius.circular(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
