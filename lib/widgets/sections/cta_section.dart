import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';

/// Contact/CTA section with form and contact info.
class CTASection extends StatelessWidget {
  final bool isMobile;

  const CTASection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;

    return Container(
      color: Palette.background,
      child: Stack(
        children: [
          // Decorative radial gradient
          Positioned.fill(
            child: Center(
              child: Container(
                width: 600,
                height: 600,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      Palette.primary.withValues(alpha: 0.06),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),
          ),
          // Content
          Padding(
            padding: EdgeInsets.only(
              left: isSmall ? 24 : 40,
              right: isSmall ? 24 : 40,
              top: isSmall ? 80 : 120,
              bottom: isSmall ? 80 : 120,
            ),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1280),
                child: isSmall
                    ? Column(
                        children: [
                          _buildInfoSide(context, isSmall),
                          const SizedBox(height: 48),
                          const _ContactForm(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: _buildInfoSide(context, isSmall),
                          ),
                          const SizedBox(width: 64),
                          const Expanded(child: _ContactForm()),
                        ],
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSide(BuildContext context, bool isSmall) {
    return AnimatedSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'READY TO START?',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
              color: Palette.primary.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Let\'s Build\nSomething Great',
            style: TextStyle(
              fontFamily: Fonts.title,
              fontSize: isSmall ? 36 : 44,
              fontWeight: FontWeight.w800,
              color: Palette.dark,
              height: 1.15,
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tell us about your project and we\'ll get back to you within '
            '24 hours with a free estimate and timeline.',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: isSmall ? 15 : 17,
              color: Palette.textSecondary,
              height: 1.7,
            ),
          ),
          const SizedBox(height: 32),
          // Trust signal
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Palette.primary.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.verified_outlined,
                  size: 18,
                  color: Palette.primary.withValues(alpha: 0.8),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    'D-U-N-S\u00ae verified, legally incorporated business. '
                    'You own 100% of your code and IP.',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 13,
                      color: Palette.primary.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Contact methods
          _ContactMethod(
            icon: Icons.email_outlined,
            label: 'hello@inspirare.app',
            onTap: () => safeLaunchUrl(context, AppUrls.email),
          ),
          const SizedBox(height: 16),
          _ContactMethod(
            icon: Icons.chat_outlined,
            label: 'WhatsApp: +503 7933-6960',
            onTap: () => safeLaunchUrl(context, AppUrls.whatsapp),
          ),
          const SizedBox(height: 16),
          const _ContactMethod(
            icon: Icons.schedule,
            label: 'CST (UTC-6) \u2022 Same as Chicago',
          ),
          const SizedBox(height: 16),
          const _ContactMethod(
            icon: Icons.location_on_outlined,
            label: 'El Salvador, Central America',
          ),
        ],
      ),
    );
  }
}

class _ContactMethod extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ContactMethod({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  State<_ContactMethod> createState() => _ContactMethodState();
}

class _ContactMethodState extends State<_ContactMethod> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          children: [
            Icon(
              widget.icon,
              size: 20,
              color: _isHovered ? Palette.primary : Palette.textMuted,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 15,
                color: _isHovered ? Palette.primary : Palette.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContactForm extends StatefulWidget {
  const _ContactForm();

  @override
  State<_ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<_ContactForm> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _companyController = TextEditingController();
  final _messageController = TextEditingController();
  String _budget = '';
  bool _isButtonHovered = false;
  bool _submitted = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _companyController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty) return;

    final subject = Uri.encodeComponent(
      'Project Inquiry from ${_nameController.text}',
    );
    final body = Uri.encodeComponent(
      'Name: ${_nameController.text}\n'
      'Email: ${_emailController.text}\n'
      'Company: ${_companyController.text}\n'
      'Budget: $_budget\n\n'
      'Message:\n${_messageController.text}',
    );
    final mailtoUrl = 'mailto:hello@inspirare.app?subject=$subject&body=$body';
    safeLaunchUrl(context, mailtoUrl);
    setState(() => _submitted = true);
  }

  @override
  Widget build(BuildContext context) {
    if (_submitted) {
      return AnimatedSection(
        child: Container(
          padding: const EdgeInsets.all(48),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: Palette.success.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: Palette.success.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 32,
                  color: Palette.success,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Thank You!',
                style: TextStyle(
                  fontFamily: Fonts.title,
                  fontSize: 28,
                  color: Palette.dark,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Your email client should open with the pre-filled message. '
                'We\'ll get back to you within 24 hours.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 15,
                  color: Palette.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 24),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => setState(() => _submitted = false),
                  child: const Text(
                    'Send another message',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return AnimatedSection(
      delay: const Duration(milliseconds: 200),
      child: Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 40,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get Your Free Estimate',
              style: TextStyle(
                fontFamily: Fonts.title,
                fontSize: 24,
                color: Palette.dark,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Fill out the form and we\'ll respond within 24 hours.',
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.textMuted,
              ),
            ),
            const SizedBox(height: 32),
            _FormField(
              label: 'Full Name *',
              controller: _nameController,
              hintText: 'John Smith',
            ),
            const SizedBox(height: 20),
            _FormField(
              label: 'Work Email *',
              controller: _emailController,
              hintText: 'john@company.com',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            _FormField(
              label: 'Company',
              controller: _companyController,
              hintText: 'Company Inc.',
            ),
            const SizedBox(height: 20),
            // Budget dropdown
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Budget Range',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Palette.dark,
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black.withValues(alpha: 0.1),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _budget.isEmpty ? null : _budget,
                      hint: Text(
                        'Select a range',
                        style: TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 14,
                          color: Palette.textMuted.withValues(alpha: 0.6),
                        ),
                      ),
                      isExpanded: true,
                      style: const TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 14,
                        color: Palette.dark,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Under \$10K',
                          child: Text('Under \$10K'),
                        ),
                        DropdownMenuItem(
                          value: '\$10K - \$25K',
                          child: Text('\$10K - \$25K'),
                        ),
                        DropdownMenuItem(
                          value: '\$25K - \$50K',
                          child: Text('\$25K - \$50K'),
                        ),
                        DropdownMenuItem(
                          value: '\$50K+',
                          child: Text('\$50K+'),
                        ),
                        DropdownMenuItem(
                          value: 'Not sure yet',
                          child: Text('Not sure yet'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) setState(() => _budget = value);
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _FormField(
              label: 'Project Description *',
              controller: _messageController,
              hintText: 'Tell us about your project, goals, and timeline...',
              maxLines: 4,
            ),
            const SizedBox(height: 32),
            // Submit button
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isButtonHovered = true),
              onExit: (_) => setState(() => _isButtonHovered = false),
              child: GestureDetector(
                onTap: _submitForm,
                child: AnimatedContainer(
                  duration: AppTransitions.fast,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  transform: _isButtonHovered
                      ? Matrix4.translationValues(0, -2, 0)
                      : Matrix4.identity(),
                  decoration: BoxDecoration(
                    color: Palette.dark,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: _isButtonHovered
                        ? [
                            BoxShadow(
                              color: Palette.dark.withValues(alpha: 0.25),
                              blurRadius: 30,
                              offset: const Offset(0, 8),
                            ),
                          ]
                        : [],
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Send Message',
                        style: TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 16, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final int maxLines;

  const _FormField({
    required this.label,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Palette.dark,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          style: const TextStyle(
            fontFamily: Fonts.body,
            fontSize: 14,
            color: Palette.dark,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 14,
              color: Palette.textMuted.withValues(alpha: 0.6),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: Colors.black.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: Palette.primary,
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
