import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/about_section.dart';
import 'package:inspirare/widgets/sections/services_section.dart';
import 'package:inspirare/widgets/sections/testimonials_section.dart';
import 'package:inspirare/widgets/sections/contact_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

class HeroSectionWeb extends StatefulWidget {
  const HeroSectionWeb({super.key});

  @override
  State<HeroSectionWeb> createState() => _HeroSectionWebState();
}

class _HeroSectionWebState extends State<HeroSectionWeb> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  // Section keys for scroll navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scrollController.offset > 100;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'inicio':
        key = _heroKey;
        break;
      case 'nosotros':
        key = _aboutKey;
        break;
      case 'servicios':
        key = _servicesKey;
        break;
      case 'historias':
        key = _testimonialsKey;
        break;
      case 'contacto':
        key = _contactKey;
        break;
    }

    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: AppTransitions.smooth,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          // Main scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onNavTap: _scrollToSection,
                  ),
                ),
                // About Section
                Container(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
                // Services Section
                Container(
                  key: _servicesKey,
                  child: const ServicesSection(),
                ),
                // Testimonials Section
                Container(
                  key: _testimonialsKey,
                  child: const TestimonialsSection(),
                ),
                // Contact Section
                Container(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
                // Footer Section
                const FooterSection(),
              ],
            ),
          ),
          // Sticky Navigation (appears on scroll)
          AnimatedPositioned(
            duration: AppTransitions.normal,
            curve: AppTransitions.smooth,
            top: _isScrolled ? 0 : -100,
            left: 0,
            right: 0,
            child: _StickyNavBar(
              onNavTap: _scrollToSection,
              isVisible: _isScrolled,
            ),
          ),
        ],
      ),
    );
  }
}

class _StickyNavBar extends StatelessWidget {
  final Function(String) onNavTap;
  final bool isVisible;

  const _StickyNavBar({
    required this.onNavTap,
    required this.isVisible,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: AppTransitions.normal,
      opacity: isVisible ? 1.0 : 0.0,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        decoration: BoxDecoration(
          color: Palette.dark.withValues(alpha: 0.95),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Brand
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () => onNavTap('inicio'),
                child: Text(
                  'Inspirare',
                  style: TextStyle(
                    fontFamily: Fonts.brand,
                    fontSize: 28,
                    color: Palette.background,
                  ),
                ),
              ),
            ),
            // Nav links
            Row(
              children: [
                _StickyNavLink(text: 'Nosotros', onTap: () => onNavTap('nosotros')),
                const SizedBox(width: 32),
                _StickyNavLink(text: 'Servicios', onTap: () => onNavTap('servicios')),
                const SizedBox(width: 32),
                _StickyNavLink(text: 'Historias', onTap: () => onNavTap('historias')),
                const SizedBox(width: 32),
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => onNavTap('contacto'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Palette.primary,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text(
                        'Contáctanos',
                        style: TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 14,
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
        ),
      ),
    );
  }
}

class _StickyNavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _StickyNavLink({required this.text, required this.onTap});

  @override
  State<_StickyNavLink> createState() => _StickyNavLinkState();
}

class _StickyNavLinkState extends State<_StickyNavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Text(
          widget.text,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isHovered ? Palette.primary : Palette.background.withValues(alpha: 0.8),
          ),
        ),
      ),
    );
  }
}
