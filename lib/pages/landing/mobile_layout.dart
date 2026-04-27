import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_events.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/pages/landing/scroll_navigation_mixin.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/glassmorphism_nav.dart';
import 'package:inspirare/widgets/common/section_tracker.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:inspirare/widgets/sections/services_section.dart';
import 'package:inspirare/widgets/sections/why_section.dart';
import 'package:inspirare/widgets/sections/portfolio_section.dart';
import 'package:inspirare/widgets/sections/process_section.dart';
import 'package:inspirare/widgets/sections/pricing_section.dart';
import 'package:inspirare/widgets/sections/faq_section.dart';
import 'package:inspirare/widgets/sections/cta_section.dart';
import 'package:inspirare/widgets/sections/footer_section.dart';

/// Mobile layout for the landing page (screens <= 768px).
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
                SectionTracker(
                  scrollKey: heroKey,
                  sectionId: SectionIds.hero,
                  child: HeroSection(
                    isMobile: true,
                    onPortfolioTap: () =>
                        scrollToSection(NavSection.portfolio),
                    onContactTap: () =>
                        scrollToSection(NavSection.contact),
                  ),
                ),
                SectionTracker(
                  scrollKey: servicesKey,
                  sectionId: SectionIds.services,
                  child: const ServicesSection(isMobile: true),
                ),
                SectionTracker(
                  scrollKey: whyUsKey,
                  sectionId: SectionIds.why,
                  child: const WhySection(isMobile: true),
                ),
                SectionTracker(
                  scrollKey: portfolioKey,
                  sectionId: SectionIds.portfolio,
                  child: const PortfolioSection(isMobile: true),
                ),
                SectionTracker(
                  scrollKey: processKey,
                  sectionId: SectionIds.process,
                  child: const ProcessSection(isMobile: true),
                ),
                SectionTracker(
                  scrollKey: pricingKey,
                  sectionId: SectionIds.pricing,
                  child: PricingSection(
                    isMobile: true,
                    onContactTap: () =>
                        scrollToSection(NavSection.contact),
                  ),
                ),
                SectionTracker(
                  scrollKey: faqKey,
                  sectionId: SectionIds.faq,
                  child: const FAQSection(isMobile: true),
                ),
                SectionTracker(
                  scrollKey: contactKey,
                  sectionId: SectionIds.cta,
                  child: const CTASection(isMobile: true),
                ),
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
