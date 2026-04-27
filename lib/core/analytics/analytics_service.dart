import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:inspirare/core/analytics/analytics_events.dart';
import 'package:inspirare/core/l10n/locale_provider.dart';
import 'package:inspirare/firebase_options.dart';

/// Singleton wrapper around [FirebaseAnalytics] with safe no-op behavior
/// when Firebase config is still using placeholder values.
///
/// All log methods catch exceptions so a misconfigured analytics setup
/// never crashes the UI.
class AnalyticsService {
  AnalyticsService._();
  static final AnalyticsService instance = AnalyticsService._();

  FirebaseAnalytics? _ga;
  bool _ready = false;

  // Dedup set for `view_section` events: emit once per section per session.
  final Set<String> _seenSections = <String>{};

  /// Initializes Firebase + Analytics. Safe to call multiple times.
  ///
  /// If [DefaultFirebaseOptions] still has placeholder values, this stays
  /// silent (no Firebase init, no events). The app will run normally;
  /// once real values are pasted, analytics activates on next reload.
  Future<void> init() async {
    if (_ready) return;

    if (DefaultFirebaseOptions.isPlaceholder) {
      if (kDebugMode) {
        debugPrint(
          '[Analytics] Skipped init: firebase_options.dart still has '
          'REPLACE_ME placeholders. Paste real Firebase Web App config to '
          'enable Analytics.',
        );
      }
      return;
    }

    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ).timeout(const Duration(seconds: 8));
      _ga = FirebaseAnalytics.instance;
      await _ga!.setAnalyticsCollectionEnabled(true);
      _ready = true;
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint('[Analytics] init failed: $e\n$st');
      }
    }
  }

  bool get isReady => _ready;

  // ── User properties ────────────────────────────────────────────────

  /// Sets the `app_locale` user property and logs a manual `page_view`
  /// (Flutter Web SPA does not auto-fire on history.replaceState).
  Future<void> setLocale(AppLocale locale, {String? pageLocation}) async {
    if (!_ready) return;
    try {
      await _ga!.setUserProperty(
        name: 'app_locale',
        value: locale.name,
      );
      await _ga!.logEvent(
        name: EventNames.pageView,
        parameters: {
          if (pageLocation != null) 'page_location': pageLocation,
          'page_title': locale == AppLocale.es
              ? 'INSPIRARE — Desarrollo de Software Nearshore'
              : 'INSPIRARE — Nearshore Software Development',
          'language': locale.name,
        },
      );
    } catch (e) {
      _logError('setLocale', e);
    }
  }

  // ── Event logging ──────────────────────────────────────────────────

  /// Generic CTA click. Use [logLeadGenerated] or [logSelectContent] when a
  /// standard GA4 event fits — those rank better in GA4 reports.
  Future<void> logCtaClick({
    required String ctaId,
    required String location,
    Map<String, Object>? extra,
  }) {
    return _log(EventNames.selectContent, {
      'content_type': 'cta',
      'cta_id': ctaId,
      'item_id': ctaId,
      'location': location,
      ...?extra,
    });
  }

  /// "Get Free Estimate" / form submit. GA4 standard event.
  Future<void> logLeadGenerated({
    required String source,
    Map<String, Object>? extra,
  }) {
    return _log(EventNames.generateLead, {
      'source': source,
      'currency': 'USD',
      ...?extra,
    });
  }

  /// "See Our Work" hero CTA. GA4 standard event.
  Future<void> logSelectContent({
    required String contentType,
    required String itemId,
  }) {
    return _log(EventNames.selectContent, {
      'content_type': contentType,
      'item_id': itemId,
    });
  }

  /// Pricing tier card CTA tap.
  Future<void> logPricingSelect({required String tierId}) {
    return _log(EventNames.selectItem, {
      'item_id': tierId,
      'item_category': 'pricing',
      'item_list_name': 'engagement_models',
    });
  }

  /// Email / WhatsApp / Calendly / LinkedIn / phone clicks.
  Future<void> logExternalLink({
    required String channel,
    required String url,
    String? source,
  }) {
    // Email and WhatsApp map to the GA4-friendly `contact` event for clarity
    // in the conversions dashboard. Other channels use external_link_click.
    if (channel == Channels.email || channel == Channels.whatsapp) {
      return _log(EventNames.contact, {
        'channel': channel,
        if (source != null) 'source': source,
      });
    }
    if (channel == Channels.calendly) {
      return _log(EventNames.scheduleCall, {
        if (source != null) 'source': source,
        'url': url,
      });
    }
    return _log(EventNames.externalLinkClick, {
      'channel': channel,
      'url': url,
      if (source != null) 'source': source,
    });
  }

  Future<void> logLanguageChange({
    required AppLocale from,
    required AppLocale to,
  }) {
    return _log(EventNames.languageChange, {
      'from': from.name,
      'to': to.name,
    });
  }

  Future<void> logFaqExpand({
    required int index,
    required String questionId,
    required AppLocale locale,
  }) {
    return _log(EventNames.faqExpand, {
      'faq_index': index,
      'question_id': questionId,
      'locale': locale.name,
    });
  }

  /// Logs `view_section` once per [sectionId] for the current session.
  Future<void> logSectionView(String sectionId) {
    if (_seenSections.contains(sectionId)) return Future.value();
    _seenSections.add(sectionId);
    return _log(EventNames.viewSection, {'section_id': sectionId});
  }

  // ── Internals ──────────────────────────────────────────────────────

  Future<void> _log(String name, Map<String, Object> params) async {
    if (!_ready) return;
    try {
      await _ga!.logEvent(name: name, parameters: params);
    } catch (e) {
      _logError(name, e);
    }
  }

  void _logError(String op, Object error) {
    if (kDebugMode) {
      debugPrint('[Analytics] $op failed: $error');
    }
  }
}
