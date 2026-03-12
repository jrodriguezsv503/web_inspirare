import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/pages/landing/scroll_navigation_mixin.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/glassmorphism_nav.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/services_section.dart';
import 'package:inspirare/widgets/sections/why_section.dart';
import 'package:inspirare/widgets/sections/portfolio_section.dart';
import 'package:inspirare/widgets/sections/process_section.dart';
import 'package:inspirare/widgets/sections/pricing_section.dart';
import 'package:inspirare/widgets/sections/faq_section.dart';
import 'package:inspirare/widgets/sections/cta_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

/// Desktop layout for the landing page (screens > 768px).
class DesktopLayout extends StatefulWidget {
  const DesktopLayout({super.key});

  @override
  State<DesktopLayout> createState() => _DesktopLayoutState();
}

class _DesktopLayoutState extends State<DesktopLayout>
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
                    onPortfolioTap: () =>
                        scrollToSection(NavSection.portfolio),
                    onContactTap: () =>
                        scrollToSection(NavSection.contact),
                  ),
                ),
                Container(
                  key: servicesKey,
                  child: const ServicesSection(),
                ),
                Container(key: whyUsKey, child: const WhySection()),
                Container(
                  key: portfolioKey,
                  child: const PortfolioSection(),
                ),
                Container(key: processKey, child: const ProcessSection()),
                Container(
                  key: pricingKey,
                  child: PricingSection(
                    onContactTap: () =>
                        scrollToSection(NavSection.contact),
                  ),
                ),
                Container(key: faqKey, child: const FAQSection()),
                Container(key: contactKey, child: const CTASection()),
                FooterSection(onNavTap: scrollToSection),
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
