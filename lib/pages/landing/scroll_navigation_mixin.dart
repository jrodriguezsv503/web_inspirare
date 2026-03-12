import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Mixin que provee la lógica compartida de scroll-to-section para los layouts.
///
/// Contiene el [ScrollController], los [GlobalKey] de cada sección y
/// el método [scrollToSection] que ambos layouts (desktop y mobile) necesitan.
mixin ScrollNavigationMixin<T extends StatefulWidget> on State<T> {
  final ScrollController scrollController = ScrollController();

  final GlobalKey heroKey = GlobalKey();
  final GlobalKey productsKey = GlobalKey();
  final GlobalKey whyKey = GlobalKey();
  final GlobalKey pricingKey = GlobalKey();

  /// Hace scroll animado a la sección indicada por [section].
  void scrollToSection(NavSection section) {
    final GlobalKey key = switch (section) {
      NavSection.inicio => heroKey,
      NavSection.productos => productsKey,
      NavSection.nosotros => whyKey,
      NavSection.precios => pricingKey,
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
