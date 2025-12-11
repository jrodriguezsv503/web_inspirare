import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Color labelColor;
  final Color titleColor;
  final bool showLines;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.labelColor = Palette.primary,
    this.titleColor = Palette.dark,
    this.showLines = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Label with decorative lines
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLines) ...[
              Container(
                width: 30,
                height: 1,
                color: labelColor,
              ),
              const SizedBox(width: 15),
            ],
            Text(
              label.toUpperCase(),
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                fontWeight: FontWeight.w600,
                letterSpacing: 2.5,
                color: labelColor,
              ),
            ),
            if (showLines) ...[
              const SizedBox(width: 15),
              Container(
                width: 30,
                height: 1,
                color: labelColor,
              ),
            ],
          ],
        ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.title,
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: titleColor,
            height: 1.2,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 18,
              color: Palette.darkLight,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}
