import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/about_section.dart';
import 'package:inspirare/widgets/sections/services_section.dart';
import 'package:inspirare/widgets/sections/testimonials_section.dart';
import 'package:inspirare/widgets/sections/contact_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();

  // Section keys for scroll navigation
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _testimonialsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _openDrawer() {
    _scaffoldKey.currentState?.openEndDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  void _scrollToSection(String section) {
    _closeDrawer();

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
      Future.delayed(const Duration(milliseconds: 300), () {
        Scrollable.ensureVisible(
          key!.currentContext!,
          duration: const Duration(milliseconds: 800),
          curve: AppTransitions.smooth,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Palette.background,
      endDrawer: _buildDrawer(),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Hero Section
            Container(
              key: _heroKey,
              child: HeroSection(
                isMobile: true,
                onMenuTap: _openDrawer,
                onNavTap: _scrollToSection,
              ),
            ),
            // About Section
            Container(
              key: _aboutKey,
              child: const AboutSection(isMobile: true),
            ),
            // Services Section
            Container(
              key: _servicesKey,
              child: const ServicesSection(isMobile: true),
            ),
            // Testimonials Section
            Container(
              key: _testimonialsKey,
              child: const TestimonialsSection(isMobile: true),
            ),
            // Contact Section
            Container(
              key: _contactKey,
              child: const ContactSection(isMobile: true),
            ),
            // Footer Section
            const FooterSection(isMobile: true),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: Palette.dark,
      width: 280,
      child: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Inspirare',
                    style: TextStyle(
                      fontFamily: Fonts.brand,
                      fontSize: 24,
                      color: Palette.background,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: Palette.background),
                    onPressed: _closeDrawer,
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white12),
            // Navigation items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 20),
                children: [
                  _DrawerItem(
                    icon: Icons.home_outlined,
                    text: 'Inicio',
                    onTap: () => _scrollToSection('inicio'),
                  ),
                  _DrawerItem(
                    icon: Icons.info_outline,
                    text: 'Nosotros',
                    onTap: () => _scrollToSection('nosotros'),
                  ),
                  _DrawerItem(
                    icon: Icons.design_services_outlined,
                    text: 'Servicios',
                    onTap: () => _scrollToSection('servicios'),
                  ),
                  _DrawerItem(
                    icon: Icons.star_outline,
                    text: 'Historias',
                    onTap: () => _scrollToSection('historias'),
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white12),
                  const SizedBox(height: 20),
                  // CTA Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () => _scrollToSection('contacto'),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: Palette.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
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
                  ),
                ],
              ),
            ),
            // Footer info
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'info@inspirare.app',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.background.withValues(alpha: 0.6),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+503 7933-6960',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.background.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Palette.primary, size: 24),
      title: Text(
        text,
        style: TextStyle(
          fontFamily: Fonts.body,
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Palette.background,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}
