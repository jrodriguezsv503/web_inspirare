import 'package:flutter/material.dart';
import 'package:inspirare/core/l10n/locale_provider.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Compact EN|ES language toggle button.
class LanguageToggle extends StatelessWidget {
  const LanguageToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = LocaleProvider.of(context);
    final current = provider.locale;

    return Container(
      decoration: BoxDecoration(
        color: Palette.dark.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: Palette.dark.withValues(alpha: 0.08)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (final locale in AppLocale.values)
            _ToggleItem(
              label: locale.label,
              isActive: locale == current,
              onTap: () => provider.setLocale(locale),
            ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_ToggleItem> createState() => _ToggleItemState();
}

class _ToggleItemState extends State<_ToggleItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: AppTransitions.fast,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: widget.isActive ? Palette.dark : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: widget.isActive
                  ? Colors.white
                  : _isHovered
                      ? Palette.dark
                      : Palette.textMuted,
            ),
          ),
        ),
      ),
    );
  }
}
