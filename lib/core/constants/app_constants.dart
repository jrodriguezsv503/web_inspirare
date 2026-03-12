/// External URLs and application constants for INSPIRARE.
class AppUrls {
  AppUrls._();

  static const String whatsapp = 'https://wa.me/50379336960';
  static const String email = 'mailto:hello@inspirare.app';
  static const String calendly = 'https://calendly.com/inspirare';
  static const String linkedin = 'https://linkedin.com/company/inspirare-sas';
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

  /// Returns the user-facing label.
  String get label {
    switch (this) {
      case NavSection.home:
        return 'Home';
      case NavSection.services:
        return 'Services';
      case NavSection.whyUs:
        return 'Why Us';
      case NavSection.portfolio:
        return 'Portfolio';
      case NavSection.process:
        return 'Process';
      case NavSection.pricing:
        return 'Pricing';
      case NavSection.faq:
        return 'FAQ';
      case NavSection.contact:
        return 'Contact';
    }
  }
}
