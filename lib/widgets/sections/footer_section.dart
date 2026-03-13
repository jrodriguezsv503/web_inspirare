import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Footer with brand, services, company, and contact columns.
class FooterSection extends StatelessWidget {
  final bool isMobile;

  /// Internal navigation callback using [NavSection].
  final void Function(NavSection)? onNavTap;

  const FooterSection({super.key, this.isMobile = false, this.onNavTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final isTablet = screenWidth < Breakpoints.tablet;

    return Container(
      color: Palette.dark,
      padding: EdgeInsets.only(
        top: isSmall ? 48 : 64,
        bottom: isSmall ? 24 : 32,
        left: isSmall ? 24 : 40,
        right: isSmall ? 24 : 40,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            children: [
              _buildColumns(context, isSmall, isTablet),
              SizedBox(height: isSmall ? 32 : 48),
              _buildBottomBar(context, isSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumns(BuildContext context, bool isSmall, bool isTablet) {
    if (isSmall) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBrandColumn(context),
          const SizedBox(height: 32),
          _buildServicesColumn(context),
          const SizedBox(height: 32),
          _buildCompanyColumn(context),
          const SizedBox(height: 32),
          _buildContactColumn(context),
        ],
      );
    }

    if (isTablet) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 2, child: _buildBrandColumn(context)),
              const SizedBox(width: 48),
              Expanded(child: _buildServicesColumn(context)),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: _buildCompanyColumn(context)),
              const SizedBox(width: 48),
              Expanded(child: _buildContactColumn(context)),
            ],
          ),
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: _buildBrandColumn(context)),
        const SizedBox(width: 48),
        Expanded(child: _buildServicesColumn(context)),
        const SizedBox(width: 48),
        Expanded(child: _buildCompanyColumn(context)),
        const SizedBox(width: 48),
        Expanded(child: _buildContactColumn(context)),
      ],
    );
  }

  Widget _buildBrandColumn(BuildContext context) {
    final s = AppStrings.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontFamily: Fonts.brand,
              fontSize: 30,
              color: Colors.white,
            ),
            children: [
              TextSpan(
                text: 'inspirare.app',
                style: TextStyle(color: Palette.background),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 300),
          child: Text(
            s.footerDescription,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.4),
              height: 1.7,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          s.footerDuns,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.25),
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildServicesColumn(BuildContext context) {
    final s = AppStrings.of(context);
    final links = s.footerServicesLinks;

    return _FooterColumn(
      title: s.footerServicesTitle,
      links: [
        for (final link in links)
          _FooterLink(
            text: link,
            onTap: () => onNavTap?.call(NavSection.services),
          ),
      ],
    );
  }

  Widget _buildCompanyColumn(BuildContext context) {
    final s = AppStrings.of(context);
    final links = s.footerCompanyLinks;
    final sections = [
      NavSection.whyUs,
      NavSection.portfolio,
      NavSection.pricing,
      NavSection.contact,
    ];

    return _FooterColumn(
      title: s.footerCompanyTitle,
      links: [
        for (int i = 0; i < links.length; i++)
          _FooterLink(
            text: links[i],
            onTap: () => onNavTap?.call(sections[i]),
          ),
      ],
    );
  }

  Widget _buildContactColumn(BuildContext context) {
    final s = AppStrings.of(context);

    return _FooterColumn(
      title: s.footerContactTitle,
      links: [
        _FooterLink(
          text: 'hello@inspirare.app',
          onTap: () => safeLaunchUrl(context, AppUrls.email),
        ),
        _FooterLink(
          text: '+503 7933-6960',
          onTap: () => safeLaunchUrl(context, AppUrls.whatsapp),
        ),
        _FooterLink(text: s.ctaLocation),
        _FooterLink(
          text: 'LinkedIn',
          onTap: () => safeLaunchUrl(context, AppUrls.linkedin),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, bool isSmall) {
    final s = AppStrings.of(context);

    return Container(
      padding: const EdgeInsets.only(top: 32),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      child: isSmall
          ? Column(
              children: [
                Text(
                  s.footerCopyrightMobile,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _FooterLegalLink(text: s.footerTerms),
                    const SizedBox(width: 24),
                    _FooterLegalLink(text: s.footerPrivacy),
                  ],
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  s.footerCopyright,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 13,
                    color: Colors.white.withValues(alpha: 0.25),
                  ),
                ),
                Row(
                  children: [
                    _FooterLegalLink(text: s.footerTerms),
                    const SizedBox(width: 24),
                    _FooterLegalLink(text: s.footerPrivacy),
                  ],
                ),
              ],
            ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<_FooterLink> links;

  const _FooterColumn({required this.title, required this.links});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 20),
        ...links,
      ],
    );
  }
}

class _FooterLink extends StatefulWidget {
  final String text;
  final VoidCallback? onTap;

  const _FooterLink({required this.text, this.onTap});

  @override
  State<_FooterLink> createState() => _FooterLinkState();
}

class _FooterLinkState extends State<_FooterLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: MouseRegion(
        cursor: widget.onTap != null
            ? SystemMouseCursors.click
            : SystemMouseCursors.basic,
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: GestureDetector(
          onTap: widget.onTap,
          child: AnimatedDefaultTextStyle(
            duration: AppTransitions.fast,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 14,
              color: _isHovered
                  ? Palette.primary
                  : Colors.white.withValues(alpha: 0.4),
            ),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}

class _FooterLegalLink extends StatefulWidget {
  final String text;

  const _FooterLegalLink({required this.text});

  @override
  State<_FooterLegalLink> createState() => _FooterLegalLinkState();
}

class _FooterLegalLinkState extends State<_FooterLegalLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedDefaultTextStyle(
        duration: AppTransitions.fast,
        style: TextStyle(
          fontFamily: Fonts.body,
          fontSize: 13,
          color: _isHovered
              ? Colors.white.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.25),
        ),
        child: Text(widget.text),
      ),
    );
  }
}
