import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Fixed navigation bar with glassmorphism effect (backdrop blur).
///
/// Changes appearance on scroll and shows a hamburger menu on mobile.
class GlassmorphismNav extends StatefulWidget {
  /// Callback invoked when a nav item is tapped.
  final void Function(NavSection) onNavTap;

  /// Main scroll controller to detect offset.
  final ScrollController scrollController;

  const GlassmorphismNav({
    super.key,
    required this.onNavTap,
    required this.scrollController,
  });

  @override
  State<GlassmorphismNav> createState() => _GlassmorphismNavState();
}

class _GlassmorphismNavState extends State<GlassmorphismNav> {
  bool _isScrolled = false;
  bool _isMobileMenuOpen = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _handleNavTap(NavSection section) {
    setState(() => _isMobileMenuOpen = false);
    widget.onNavTap(section);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < Breakpoints.mobile;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: AnimatedContainer(
              duration: AppTransitions.normal,
              height: 72,
              padding: EdgeInsets.symmetric(horizontal: isMobile ? 24 : 40),
              decoration: BoxDecoration(
                color: Palette.primary,
                border: const Border(
                  bottom: BorderSide(color: Palette.dark, width: 1),
                ),
                boxShadow: _isScrolled
                    ? [
                        const BoxShadow(
                          color: Colors.black,
                          blurRadius: 30,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Logo
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: () => _handleNavTap(NavSection.home),
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontFamily: Fonts.brand,
                            fontSize: 38,
                            color: Palette.background,
                            letterSpacing: -0.5,
                          ),
                          children: [TextSpan(text: 'inspirare.app')],
                        ),
                      ),
                    ),
                  ),
                  // Desktop nav links
                  if (!isMobile)
                    Row(
                      children: [
                        _NavLink(
                          text: NavSection.services.label,
                          onTap: () => _handleNavTap(NavSection.services),
                        ),
                        const SizedBox(width: 32),
                        _NavLink(
                          text: NavSection.portfolio.label,
                          onTap: () => _handleNavTap(NavSection.portfolio),
                        ),
                        const SizedBox(width: 32),
                        _NavLink(
                          text: NavSection.pricing.label,
                          onTap: () => _handleNavTap(NavSection.pricing),
                        ),
                        const SizedBox(width: 32),
                        _NavCTA(
                          onTap: () => _handleNavTap(NavSection.contact),
                        ),
                      ],
                    ),
                  // Mobile hamburger
                  if (isMobile)
                    IconButton(
                      icon: AnimatedSwitcher(
                        duration: AppTransitions.fast,
                        child: _isMobileMenuOpen
                            ? const Icon(Icons.close, key: ValueKey('close'))
                            : const Icon(Icons.menu, key: ValueKey('menu')),
                      ),
                      onPressed: () {
                        setState(() => _isMobileMenuOpen = !_isMobileMenuOpen);
                      },
                      color: Palette.dark,
                      iconSize: 28,
                    ),
                ],
              ),
            ),
          ),
        ),
        // Mobile dropdown menu
        if (isMobile && _isMobileMenuOpen)
          ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                decoration: BoxDecoration(
                  color: Palette.background.withValues(alpha: 0.95),
                  border: Border(
                    bottom: BorderSide(
                      color: Palette.dark.withValues(alpha: 0.06),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _MobileNavItem(
                      text: NavSection.services.label,
                      onTap: () => _handleNavTap(NavSection.services),
                    ),
                    const SizedBox(height: 16),
                    _MobileNavItem(
                      text: NavSection.whyUs.label,
                      onTap: () => _handleNavTap(NavSection.whyUs),
                    ),
                    const SizedBox(height: 16),
                    _MobileNavItem(
                      text: NavSection.portfolio.label,
                      onTap: () => _handleNavTap(NavSection.portfolio),
                    ),
                    const SizedBox(height: 16),
                    _MobileNavItem(
                      text: NavSection.pricing.label,
                      onTap: () => _handleNavTap(NavSection.pricing),
                    ),
                    const SizedBox(height: 16),
                    _MobileNavItem(
                      text: NavSection.faq.label,
                      onTap: () => _handleNavTap(NavSection.faq),
                    ),
                    const SizedBox(height: 24),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => _handleNavTap(NavSection.contact),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          decoration: BoxDecoration(
                            color: Palette.dark,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const Center(
                            child: Text(
                              'Get Free Estimate',
                              style: TextStyle(
                                fontFamily: Fonts.body,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _NavLink({required this.text, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: AppTransitions.fast,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: _isHovered ? Palette.dark : Palette.textSecondary,
            letterSpacing: 0.2,
          ),
          child: Text(widget.text),
        ),
      ),
    );
  }
}

class _NavCTA extends StatefulWidget {
  final VoidCallback onTap;

  const _NavCTA({required this.onTap});

  @override
  State<_NavCTA> createState() => _NavCTAState();
}

class _NavCTAState extends State<_NavCTA> {
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
          transform: _isHovered
              ? Matrix4.translationValues(0, -1, 0)
              : Matrix4.identity(),
          decoration: BoxDecoration(
            color: Palette.dark,
            borderRadius: BorderRadius.circular(100),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: Palette.dark.withValues(alpha: 0.2),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          child: const Text(
            'Get Free Estimate',
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: 0.3,
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _MobileNavItem({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: Fonts.body,
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Palette.textSecondary,
          ),
        ),
      ),
    );
  }
}
