import 'package:flutter/material.dart';
import 'package:inspirare/theme/web_theme.dart';

class SectionHeader extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final Color labelColor;
  final Color titleColor;
  final bool showLines;
  final bool isLeftAligned;

  const SectionHeader({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
    this.labelColor = Palette.primary,
    this.titleColor = Palette.dark,
    this.showLines = true,
    this.isLeftAligned = false,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final titleFontSize = (screenWidth * 0.04).clamp(32.0, 48.0);

    return Column(
      crossAxisAlignment: isLeftAligned
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        // Label with optional decorative lines
        if (isLeftAligned)
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              color: labelColor,
            ),
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (showLines) ...[
                Container(width: 30, height: 1, color: labelColor),
                const SizedBox(width: 15),
              ],
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 3,
                  color: labelColor,
                ),
              ),
              if (showLines) ...[
                const SizedBox(width: 15),
                Container(width: 30, height: 1, color: labelColor),
              ],
            ],
          ),
        const SizedBox(height: 16),
        // Title
        Text(
          title,
          textAlign: isLeftAligned ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.title,
            fontSize: titleFontSize,
            fontWeight: FontWeight.w800,
            color: titleColor,
            height: 1.15,
            letterSpacing: -1,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              subtitle!,
              textAlign: isLeftAligned ? TextAlign.left : TextAlign.center,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 17,
                color: Palette.textSecondary,
                height: 1.7,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
