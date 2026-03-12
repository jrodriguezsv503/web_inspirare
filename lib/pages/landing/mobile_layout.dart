import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/pages/landing/scroll_navigation_mixin.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/glassmorphism_nav.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/products_section.dart';
import 'package:inspirare/widgets/sections/why_section.dart';
import 'package:inspirare/widgets/sections/pricing_section.dart';
import 'package:inspirare/widgets/sections/cta_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

/// Layout móvil de la landing page (pantallas <= 768px).
class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout>
    with ScrollNavigationMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                Container(
                  key: heroKey,
                  child: HeroSection(
                    isMobile: true,
                    onProductsTap: () => scrollToSection(NavSection.productos),
                  ),
                ),
                Container(
                  key: productsKey,
                  child: const ProductsSection(isMobile: true),
                ),
                Container(key: whyKey, child: const WhySection(isMobile: true)),
                Container(
                  key: pricingKey,
                  child: const PricingSection(isMobile: true),
                ),
                const CTASection(isMobile: true),
                FooterSection(isMobile: true, onNavTap: scrollToSection),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: GlassmorphismNav(
              onNavTap: scrollToSection,
              scrollController: scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
