import 'package:flutter/widgets.dart';
import 'package:inspirare/core/l10n/locale_provider.dart';

/// Abstract class defining all translatable strings for the landing page.
///
/// Access via `AppStrings.of(context)` which returns the current locale's
/// implementation ([StringsEn] or [StringsEs]).
abstract class AppStrings {
  /// Retrieves the current [AppStrings] from the widget tree.
  static AppStrings of(BuildContext context) {
    return LocaleProvider.of(context).strings;
  }

  // ── Navigation ──────────────────────────────────────────────────────
  String get navHome;
  String get navServices;
  String get navWhyUs;
  String get navPortfolio;
  String get navProcess;
  String get navPricing;
  String get navFaq;
  String get navContact;
  String get navGetFreeEstimate;

  // ── Hero ────────────────────────────────────────────────────────────
  String get heroBadge;
  String get heroHeadlinePart1;
  String get heroHeadlineAccent;
  String get heroHeadlinePart2;
  String get heroSubtitle;
  String get heroCtaPrimary;
  String get heroCtaSecondary;
  String get heroBadgeDuns;
  String get heroBadgeIp;
  String get heroMetric1Value;
  String get heroMetric1Label;
  String get heroMetric2Value;
  String get heroMetric2Label;
  String get heroMetric3Value;
  String get heroMetric3Label;
  String get heroMetric4Value;
  String get heroMetric4Label;

  // ── Services ────────────────────────────────────────────────────────
  String get servicesLabel;
  String get servicesTitle;
  String get servicesSubtitle;
  List<ServiceCardStrings> get serviceCards;

  // ── Why INSPIRARE ──────────────────────────────────────────────────
  String get whyLabel;
  String get whyTitle;
  String get whySubtitle;
  List<WhyCardStrings> get whyCards;

  // ── Portfolio ──────────────────────────────────────────────────────
  String get portfolioLabel;
  String get portfolioTitle;
  String get portfolioSubtitle;
  String get portfolioChallenge;
  String get portfolioSolution;
  String get portfolioResults;
  String get portfolioViewLive;
  List<ProjectStrings> get projects;

  // ── Process ────────────────────────────────────────────────────────
  String get processLabel;
  String get processTitle;
  String get processSubtitle;
  List<StepStrings> get processSteps;

  // ── Pricing ────────────────────────────────────────────────────────
  String get pricingLabel;
  String get pricingTitle;
  String get pricingSubtitle;
  String get pricingMostPopular;
  String get pricingIdealFor;
  String get pricingCta;
  List<PricingCardStrings> get pricingCards;

  // ── FAQ ─────────────────────────────────────────────────────────────
  String get faqLabel;
  String get faqTitle;
  String get faqSubtitle;
  List<FaqStrings> get faqs;

  // ── CTA / Contact ──────────────────────────────────────────────────
  String get ctaReadyLabel;
  String get ctaHeadline;
  String get ctaSubtitle;
  String get ctaTrustSignal;
  String get ctaEmail;
  String get ctaWhatsapp;
  String get ctaTimezone;
  String get ctaLocation;
  String get ctaFormTitle;
  String get ctaFormSubtitle;
  String get ctaFormName;
  String get ctaFormNameHint;
  String get ctaFormEmail;
  String get ctaFormEmailHint;
  String get ctaFormCompany;
  String get ctaFormCompanyHint;
  String get ctaFormBudget;
  String get ctaFormBudgetHint;
  List<String> get ctaFormBudgetOptions;
  String get ctaFormMessage;
  String get ctaFormMessageHint;
  String get ctaFormSubmit;
  String get ctaSuccessTitle;
  String get ctaSuccessMessage;
  String get ctaSuccessSendAnother;

  // ── Footer ─────────────────────────────────────────────────────────
  String get footerDescription;
  String get footerDuns;
  String get footerServicesTitle;
  List<String> get footerServicesLinks;
  String get footerCompanyTitle;
  List<String> get footerCompanyLinks;
  String get footerContactTitle;
  String get footerCopyright;
  String get footerCopyrightMobile;
  String get footerTerms;
  String get footerPrivacy;
}

/// Data holder for a service card's translatable strings.
class ServiceCardStrings {
  final String title;
  final String description;

  const ServiceCardStrings({
    required this.title,
    required this.description,
  });
}

/// Data holder for a "Why" card's translatable strings.
class WhyCardStrings {
  final String title;
  final String description;

  const WhyCardStrings({
    required this.title,
    required this.description,
  });
}

/// Data holder for a portfolio project's translatable strings.
class ProjectStrings {
  final String name;
  final String subtitle;
  final String challenge;
  final String solution;
  final List<String> results;
  final String status;

  const ProjectStrings({
    required this.name,
    required this.subtitle,
    required this.challenge,
    required this.solution,
    required this.results,
    required this.status,
  });
}

/// Data holder for a process step's translatable strings.
class StepStrings {
  final String title;
  final String description;

  const StepStrings({
    required this.title,
    required this.description,
  });
}

/// Data holder for a pricing card's translatable strings.
class PricingCardStrings {
  final String title;
  final String description;
  final String idealFor;
  final List<String> features;

  const PricingCardStrings({
    required this.title,
    required this.description,
    required this.idealFor,
    required this.features,
  });
}

/// Data holder for a FAQ item's translatable strings.
class FaqStrings {
  final String question;
  final String answer;

  const FaqStrings({
    required this.question,
    required this.answer,
  });
}
