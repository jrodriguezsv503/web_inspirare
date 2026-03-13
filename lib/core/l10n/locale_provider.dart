import 'dart:js_interop';

import 'package:flutter/widgets.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/core/l10n/strings_en.dart';
import 'package:inspirare/core/l10n/strings_es.dart';
import 'package:web/web.dart' as web;

/// Supported locales.
enum AppLocale {
  en,
  es;

  /// Returns the [AppStrings] implementation for this locale.
  AppStrings get strings {
    switch (this) {
      case AppLocale.en:
        return StringsEn();
      case AppLocale.es:
        return StringsEs();
    }
  }

  /// Display label for the toggle.
  String get label {
    switch (this) {
      case AppLocale.en:
        return 'EN';
      case AppLocale.es:
        return 'ES';
    }
  }
}

/// InheritedWidget that provides the current locale down the widget tree.
class LocaleProvider extends InheritedWidget {
  final AppLocale locale;
  final AppStrings strings;
  final void Function(AppLocale) setLocale;

  const LocaleProvider({
    super.key,
    required this.locale,
    required this.strings,
    required this.setLocale,
    required super.child,
  });

  static LocaleProvider of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<LocaleProvider>();
    assert(provider != null, 'No LocaleProvider found in context');
    return provider!;
  }

  @override
  bool updateShouldNotify(LocaleProvider oldWidget) {
    return locale != oldWidget.locale;
  }
}

/// StatefulWidget wrapper that manages locale state and wraps child
/// with [LocaleProvider].
class LocaleScope extends StatefulWidget {
  final Widget child;

  const LocaleScope({super.key, required this.child});

  @override
  State<LocaleScope> createState() => _LocaleScopeState();
}

class _LocaleScopeState extends State<LocaleScope> {
  late AppLocale _locale;

  @override
  void initState() {
    super.initState();
    _locale = _detectInitialLocale();
    _updateHtmlLang(_locale);
  }

  /// Detects initial locale from URL query param, then browser language.
  AppLocale _detectInitialLocale() {
    final uri = Uri.parse(web.window.location.href);
    final langParam = uri.queryParameters['lang']?.toLowerCase();
    if (langParam == 'es') return AppLocale.es;
    if (langParam == 'en') return AppLocale.en;

    final browserLang = web.window.navigator.language.toLowerCase();
    if (browserLang.startsWith('es')) return AppLocale.es;

    return AppLocale.en;
  }

  void _setLocale(AppLocale newLocale) {
    if (newLocale == _locale) return;
    setState(() => _locale = newLocale);
    _updateHtmlLang(newLocale);
    _updateUrl(newLocale);
  }

  void _updateHtmlLang(AppLocale locale) {
    web.document.documentElement?.setAttribute('lang', locale.name);
  }

  void _updateUrl(AppLocale locale) {
    final uri = Uri.parse(web.window.location.href);
    final newParams = Map<String, String>.from(uri.queryParameters);

    if (locale == AppLocale.en) {
      newParams.remove('lang');
    } else {
      newParams['lang'] = locale.name;
    }

    final newUri =
        uri.replace(queryParameters: newParams.isEmpty ? null : newParams);
    web.window.history.replaceState(''.toJS, '', newUri.toString());
  }

  @override
  Widget build(BuildContext context) {
    return LocaleProvider(
      locale: _locale,
      strings: _locale.strings,
      setLocale: _setLocale,
      child: widget.child,
    );
  }
}
