import 'package:flutter/material.dart';
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
              const AnimatedSection(
                child: SectionHeader(
                  label: 'FAQ',
                  title: 'Common Questions',
                  subtitle:
                      'Everything you need to know about working with INSPIRARE.',
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              ...List.generate(
                _faqs.length,
                (index) => AnimatedSection(
                  delay: Duration(milliseconds: 80 * (index + 1)),
                  child: _FAQItem(faq: _faqs[index]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FAQData {
  final String question;
  final String answer;

  const _FAQData({required this.question, required this.answer});
}

const _faqs = [
  _FAQData(
    question: 'Where is your team located?',
    answer:
        'We are based in El Salvador, Central America. Our timezone is CST '
        '(Central Standard Time) \u2014 the same as Chicago, Dallas, and Houston. '
        'This means real-time collaboration during US business hours with zero delays.',
  ),
  _FAQData(
    question: 'What technologies do you specialize in?',
    answer:
        'Our core stack is Flutter (for cross-platform mobile & web apps), '
        'Dart, Firebase, and Google Cloud Platform. We also integrate AI/ML '
        'solutions using Gemini and OpenAI APIs. This modern stack allows us to '
        'deliver faster and at lower cost than traditional native development.',
  ),
  _FAQData(
    question: 'How do we communicate during a project?',
    answer:
        'We use Slack for daily communication, Zoom for meetings, and Linear '
        'or Jira for project management. You\'ll have direct access to the '
        'engineers building your product \u2014 no project managers or intermediaries. '
        'Daily standups are available if your team prefers them.',
  ),
  _FAQData(
    question: 'Do you sign NDAs?',
    answer:
        'Yes, absolutely. We sign NDAs as standard practice before every '
        'engagement. We take intellectual property protection seriously and '
        'can work with your legal team on any specific requirements.',
  ),
  _FAQData(
    question: 'What is a typical project timeline?',
    answer:
        'An MVP typically takes 4\u20138 weeks. Larger, more complex projects are '
        'delivered in phases, with the first release usually in 6\u201312 weeks. '
        'We provide detailed timelines during the discovery phase so there are '
        'no surprises.',
  ),
  _FAQData(
    question: 'How does pricing work?',
    answer:
        'We offer three engagement models: Fixed-Price (for well-scoped projects), '
        'Time & Materials (for evolving requirements), and Dedicated Team '
        '(for ongoing work). We provide detailed estimates during discovery and '
        'our rates are 40\u201360% lower than comparable US agencies.',
  ),
];

class _FAQItem extends StatefulWidget {
  final _FAQData faq;

  const _FAQItem({required this.faq});

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
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _isExpanded
              ? Palette.primary.withValues(alpha: 0.2)
              : Colors.black.withValues(alpha: 0.06),
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
                        widget.faq.question,
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
                      turns: _isExpanded ? 0.125 : 0,
                      duration: AppTransitions.normal,
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: _isExpanded ? Palette.primary : Palette.textMuted,
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
                  widget.faq.answer,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 14,
                    color: Palette.textSecondary.withValues(alpha: 0.8),
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
