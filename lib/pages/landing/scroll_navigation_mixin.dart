import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Mixin that provides shared scroll-to-section logic for layouts.
///
/// Contains the [ScrollController], [GlobalKey] per section, and
/// the [scrollToSection] method used by both desktop and mobile layouts.
mixin ScrollNavigationMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey servicesKey = GlobalKey();
  final GlobalKey whyUsKey = GlobalKey();
  final GlobalKey portfolioKey = GlobalKey();
  final GlobalKey processKey = GlobalKey();
  final GlobalKey pricingKey = GlobalKey();
  final GlobalKey faqKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  /// Scrolls to the section indicated by [section].
  void scrollToSection(NavSection section) {
    final GlobalKey key = switch (section) {
      NavSection.home => heroKey,
      NavSection.services => servicesKey,
      NavSection.whyUs => whyUsKey,
      NavSection.portfolio => portfolioKey,
      NavSection.process => processKey,
      NavSection.pricing => pricingKey,
      NavSection.faq => faqKey,
      NavSection.contact => contactKey,
    };

    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: AppTransitions.smooth,
      );
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
