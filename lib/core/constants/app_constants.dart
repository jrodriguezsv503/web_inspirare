import 'package:inspirare/core/l10n/app_strings.dart';

/// External URLs and application constants for INSPIRARE.
class AppUrls {
  AppUrls._();

  static const String whatsapp = 'https://wa.me/50379336960';
  static const String email = 'mailto:hello@inspirare.app';
  static const String calendly = 'https://calendly.com/inspirare';
  static const String linkedin = 'https://www.linkedin.com/in/joel-rodriguez-inspirare';
  static const String dteApp = 'https://dte.inspirare.app';
  static const String contasasApp = 'https://contasas.inspirare.app';
}

/// Navigation sections for the landing page.
enum NavSection {
  home,
  services,
  whyUs,
  portfolio,
  process,
  pricing,
  faq,
  contact;

  /// Returns the localized user-facing label.
  String localizedLabel(AppStrings s) {
    switch (this) {
      case NavSection.home:
        return s.navHome;
      case NavSection.services:
        return s.navServices;
      case NavSection.whyUs:
        return s.navWhyUs;
      case NavSection.portfolio:
        return s.navPortfolio;
      case NavSection.process:
        return s.navProcess;
      case NavSection.pricing:
        return s.navPricing;
      case NavSection.faq:
        return s.navFaq;
      case NavSection.contact:
        return s.navContact;
    }
  }
}
