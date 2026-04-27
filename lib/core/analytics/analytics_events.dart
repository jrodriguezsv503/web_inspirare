/// Centralized constants for GA4 event names, CTA identifiers, and channel
/// labels used across the landing. Keeping these as constants prevents typos
/// in dashboards (GA4 treats `cta_id=hero_primary` and `cta_id=heroPrimary`
/// as different values) and makes refactoring safe.
class EventNames {
  EventNames._();

  // GA4 standard recommended events (preferred when semantics fit)
  static const String generateLead = 'generate_lead';
  static const String selectContent = 'select_content';
  static const String selectItem = 'select_item';
  static const String pageView = 'page_view';

  // Custom events
  static const String contact = 'contact';
  static const String scheduleCall = 'schedule_call';
  static const String externalLinkClick = 'external_link_click';
  static const String languageChange = 'language_change';
  static const String faqExpand = 'faq_expand';
  static const String viewSection = 'view_section';
}

class CtaIds {
  CtaIds._();

  static const String heroPrimary = 'hero_primary';
  static const String heroSecondary = 'hero_secondary';
  static const String pricingFixed = 'pricing_fixed';
  static const String pricingTimeMaterials = 'pricing_time_materials';
  static const String pricingDedicated = 'pricing_dedicated';
  static const String contactForm = 'contact_form';
  static const String navGetEstimate = 'nav_get_estimate';
}

class Channels {
  Channels._();

  static const String email = 'email';
  static const String whatsapp = 'whatsapp';
  static const String calendly = 'calendly';
  static const String linkedin = 'linkedin';
  static const String phone = 'phone';
}

class SectionIds {
  SectionIds._();

  static const String hero = 'hero';
  static const String services = 'services';
  static const String why = 'why';
  static const String portfolio = 'portfolio';
  static const String process = 'process';
  static const String pricing = 'pricing';
  static const String faq = 'faq';
  static const String cta = 'cta';
  static const String footer = 'footer';
}
