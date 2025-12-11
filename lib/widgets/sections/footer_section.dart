import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';

class FooterSection extends StatelessWidget {
  final bool isMobile;

  const FooterSection({super.key, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.footerDark,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 80,
        vertical: isMobile ? 32 : 48,
      ),
      child: isMobile ? _buildMobileLayout() : _buildDesktopLayout(),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Brand
        Text(
          'Inspirare.app',
          style: TextStyle(
            fontFamily: Fonts.brand,
            fontSize: 28,
            fontWeight: FontWeight.w900,
            color: Palette.background,
          ),
        ),
        // Legal info
        Column(
          children: [
            Text(
              'INSPIRARE, S.A.S.',
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.background.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Creamos experiencias digitales que inspiran.',
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.background.withValues(alpha: 0.6),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '© 2025 Todos los derechos reservados',
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 14,
                color: Palette.background.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
        // Social links
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      children: [
        // Brand
        Text(
          'Inspirare.app',
          style: TextStyle(
            fontFamily: Fonts.brand,
            fontSize: 24,
            fontWeight: FontWeight.w900,
            color: Palette.background,
          ),
        ),
        const SizedBox(height: 24),
        // Legal info
        Text(
          'INSPIRARE, S.A.S.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            color: Palette.background.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Creamos experiencias digitales que inspiran.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            color: Palette.background.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '© 2025 Todos los derechos reservados',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            color: Palette.background.withValues(alpha: 0.6),
          ),
        ),
        const SizedBox(height: 24),
        // Social links
        _buildSocialLinks(),
      ],
    );
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialButton(
          icon: FontAwesomeIcons.whatsapp,
          onTap: () => launchUrl(Uri.parse('https://wa.me/50379336960')),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.email_outlined,
          onTap: () => launchUrl(Uri.parse('mailto:info@inspirare.app')),
        ),
        const SizedBox(width: 12),
        _SocialButton(
          icon: Icons.language_outlined,
          onTap: () => launchUrl(Uri.parse('https://inspirare.app')),
        ),
      ],
    );
  }
}

class _SocialButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SocialButton({required this.icon, required this.onTap});

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
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
          duration: AppTransitions.normal,
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: _isHovered
                ? Palette.primary
                : Palette.background.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -3.0, 0.0)
              : Matrix4.identity(),
          child: Icon(widget.icon, size: 20, color: Palette.background),
        ),
      ),
    );
  }
}
