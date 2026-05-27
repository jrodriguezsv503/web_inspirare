import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/core/l10n/locale_provider.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// FAQ section with expandable question/answer items.
class FAQSection extends StatelessWidget {
  final bool isMobile;

  const FAQSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final s = AppStrings.of(context);
    final faqs = s.faqs;

    return Container(
      color: Palette.background,
      padding: EdgeInsets.only(
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
        top: isSmall ? 80 : 120,
        bottom: isSmall ? 80 : 120,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: s.faqLabel,
                  title: s.faqTitle,
                  subtitle: s.faqSubtitle,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              ...List.generate(
                faqs.length,
                (index) => AnimatedSection(
                  delay: Duration(milliseconds: 80 * (index + 1)),
                  child: _FAQItem(
                    index: index,
                    question: faqs[index].question,
                    answer: faqs[index].answer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQItem extends StatefulWidget {
  final int index;
  final String question;
  final String answer;

  const _FAQItem({
    required this.index,
    required this.question,
    required this.answer,
  });

  @override
  State<_FAQItem> createState() => _FAQItemState();
}

class _FAQItemState extends State<_FAQItem>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppTransitions.normal,
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: AppTransitions.smooth,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
        final locale = LocaleProvider.of(context).locale;
        AnalyticsService.instance.logFaqExpand(
          index: widget.index,
          questionId: 'faq_${widget.index + 1}',
          locale: locale,
        );
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppTransitions.fast,
      curve: AppCurves.easeOutStrong,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded
              ? Palette.primaryDark.withValues(alpha: 0.45)
              : Palette.hairline,
          width: _isExpanded ? 1.5 : 1,
        ),
      ),
      child: Column(
        children: [
          // Question (always visible)
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _toggle,
              child: Container(
                padding: const EdgeInsets.all(24),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.question,
                        style: const TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Palette.dark,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    AnimatedRotation(
                      turns: _isExpanded ? 0.5 : 0,
                      duration: AppTransitions.normal,
                      curve: AppCurves.easeOutStrong,
                      child: Icon(
                        Icons.expand_more_rounded,
                        size: 24,
                        color: _isExpanded
                            ? Palette.primaryDark
                            : Palette.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Answer (expandable)
          ClipRect(
            child: AnimatedBuilder(
              animation: _heightFactor,
              builder: (context, child) {
                return Align(
                  heightFactor: _heightFactor.value,
                  alignment: Alignment.topCenter,
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: 24,
                ),
                child: Text(
                  widget.answer,
                  style: const TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 14.5,
                    color: Palette.textSecondary,
                    height: 1.7,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
