import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/glassmorphism_nav.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/products_section.dart';
import 'package:inspirare/widgets/sections/why_section.dart';
import 'package:inspirare/widgets/sections/pricing_section.dart';
import 'package:inspirare/widgets/sections/cta_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

class HeroSectionWeb extends StatefulWidget {
  const HeroSectionWeb({super.key});

  @override
  State<HeroSectionWeb> createState() => _HeroSectionWebState();
}

class _HeroSectionWebState extends State<HeroSectionWeb> {
  final ScrollController _scrollController = ScrollController();

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _productsKey = GlobalKey();
  final GlobalKey _whyKey = GlobalKey();
  final GlobalKey _pricingKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(String section) {
    GlobalKey? key;
    switch (section) {
      case 'inicio':
        key = _heroKey;
      case 'productos':
        key = _productsKey;
      case 'nosotros':
        key = _whyKey;
      case 'precios':
        key = _pricingKey;
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
                Container(
                  key: _heroKey,
                  child: HeroSection(
                    onProductsTap: () => _scrollToSection('productos'),
                  ),
                ),
                Container(key: _productsKey, child: const ProductsSection()),
                Container(key: _whyKey, child: const WhySection()),
                Container(key: _pricingKey, child: const PricingSection()),
                const CTASection(),
                FooterSection(onNavTap: _scrollToSection),
              ],
            ),
          ),
          // Fixed glassmorphism navigation
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassmorphismNav(
              onNavTap: _scrollToSection,
              scrollController: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
