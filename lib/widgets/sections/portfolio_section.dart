import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inspirare/core/l10n/app_strings.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Portfolio section — each project card is a mini brand experience.
///
/// The hero zone of every card is hand-designed to reflect that product's
/// real visual identity (colors, typography, signature element), while the
/// body retains the INSPIRARE editorial system (Playfair + Roboto + cream).
class PortfolioSection extends StatelessWidget {
  final bool isMobile;

  const PortfolioSection({super.key, this.isMobile = false});

  static const _liveUrls = <String?>[
    'https://contasas.inspirare.app',
    'https://dte.inspirare.app',
    'https://elbichoia.com',
    'https://trama.store',
    'https://exve.app',
  ];

  static const _projectTags = <List<String>>[
    ['Flutter Web', 'Firebase', 'Vertex AI', 'RAG'],
    ['Flutter Web', 'Firebase', 'Government API', 'SaaS'],
    ['Vertex AI', 'Gemma 3', 'QLoRA', 'RAG', 'Flutter'],
    ['Flutter Web', 'Firebase', 'E-Commerce'],
    ['Flutter PWA', 'Firebase', 'Material 3'],
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmall = screenWidth < Breakpoints.mobile;
    final s = AppStrings.of(context);

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
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedSection(
                child: SectionHeader(
                  label: s.portfolioLabel,
                  title: s.portfolioTitle,
                  subtitle: s.portfolioSubtitle,
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 72),
              _buildProjects(context, isSmall),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjects(BuildContext context, bool isSmall) {
    final s = AppStrings.of(context);
    final ps = s.projects;
    const brands = _ProjectBrand.all;

    final projects = List.generate(
      ps.length,
      (i) => _ProjectData(
        name: ps[i].name,
        subtitle: ps[i].subtitle,
        challenge: ps[i].challenge,
        solution: ps[i].solution,
        results: ps[i].results,
        tags: i < _projectTags.length ? _projectTags[i] : const <String>[],
        status: ps[i].status,
        liveUrl: i < _liveUrls.length ? _liveUrls[i] : null,
        brand: i < brands.length ? brands[i] : brands.last,
      ),
    );

    return Column(
      children: [
        for (int i = 0; i < projects.length; i++) ...[
          AnimatedSection(
            delay: Duration(milliseconds: 80 * (i + 1)),
            child: _ProjectCard(data: projects[i], isSmall: isSmall),
          ),
          if (i < projects.length - 1) SizedBox(height: isSmall ? 32 : 40),
        ],
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Data
// ────────────────────────────────────────────────────────────────────────────

class _ProjectData {
  final String name;
  final String subtitle;
  final String challenge;
  final String solution;
  final List<String> results;
  final List<String> tags;
  final String status;
  final String? liveUrl;
  final _ProjectBrand brand;

  const _ProjectData({
    required this.name,
    required this.subtitle,
    required this.challenge,
    required this.solution,
    required this.results,
    required this.tags,
    required this.status,
    required this.liveUrl,
    required this.brand,
  });
}

/// Identity tokens per project — drives the hero zone rendering.
class _ProjectBrand {
  final Color heroBg;
  final Color heroOnBg;
  final Color brandPrimary;
  final _BrandSignature signature;

  const _ProjectBrand({
    required this.heroBg,
    required this.heroOnBg,
    required this.brandPrimary,
    required this.signature,
  });

  static const all = <_ProjectBrand>[
    // ContaSAS.ia — fintech AI, warm white + cyan
    _ProjectBrand(
      heroBg: Color(0xFFFFF9F5),
      heroOnBg: Color(0xFF212630),
      brandPrimary: Color(0xFF08C4D4),
      signature: _BrandSignature.contasas,
    ),
    // Factura Fácil DTE — government, ink + cream + gold
    _ProjectBrand(
      heroBg: Color(0xFF0A1F3D),
      heroOnBg: Color(0xFFF7F5F0),
      brandPrimary: Color(0xFFB08A3E),
      signature: _BrandSignature.dte,
    ),
    // El Bicho IA — terminal hacker dark + neon
    _ProjectBrand(
      heroBg: Color(0xFF0B1426),
      heroOnBg: Colors.white,
      brandPrimary: Color(0xFF3BA55D),
      signature: _BrandSignature.bicho,
    ),
    // TRAMA Store — editorial fashion cream + rosé
    _ProjectBrand(
      heroBg: Color(0xFFFAF9F6),
      heroOnBg: Color(0xFF000000),
      brandPrimary: Color(0xFFB76E79),
      signature: _BrandSignature.trama,
    ),
    // EXVE — automotive audit, off-white + navy + amber
    _ProjectBrand(
      heroBg: Color(0xFFFAF9FD),
      heroOnBg: Color(0xFF002045),
      brandPrimary: Color(0xFF875200),
      signature: _BrandSignature.exve,
    ),
  ];
}

enum _BrandSignature { contasas, dte, bicho, trama, exve }

// ────────────────────────────────────────────────────────────────────────────
// Card
// ────────────────────────────────────────────────────────────────────────────

class _ProjectCard extends StatefulWidget {
  final _ProjectData data;
  final bool isSmall;

  const _ProjectCard({required this.data, required this.isSmall});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        curve: AppCurves.easeOutStrong,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Palette.hairline),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Palette.dark.withValues(alpha: 0.07),
                    blurRadius: 40,
                    offset: const Offset(0, 14),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Palette.dark.withValues(alpha: 0.03),
                    blurRadius: 18,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        clipBehavior: Clip.antiAlias,
        child: widget.isSmall
            ? _buildVertical(context)
            : _buildHorizontal(context),
      ),
    );
  }

  Widget _buildHorizontal(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero zone — brand expression
          Expanded(
            flex: 4,
            child: _ProjectHero(brand: widget.data.brand, isSmall: false),
          ),
          // Body zone — structured info
          Expanded(
            flex: 6,
            child: _ProjectBody(data: widget.data, isSmall: false),
          ),
        ],
      ),
    );
  }

  Widget _buildVertical(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: 240,
          child: _ProjectHero(brand: widget.data.brand, isSmall: true),
        ),
        _ProjectBody(data: widget.data, isSmall: true),
      ],
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Hero zone dispatcher
// ────────────────────────────────────────────────────────────────────────────

class _ProjectHero extends StatelessWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _ProjectHero({required this.brand, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    final child = switch (brand.signature) {
      _BrandSignature.contasas => _ContaSasHero(brand: brand, isSmall: isSmall),
      _BrandSignature.dte => _DteHero(brand: brand, isSmall: isSmall),
      _BrandSignature.bicho => _BichoHero(brand: brand, isSmall: isSmall),
      _BrandSignature.trama => _TramaHero(brand: brand, isSmall: isSmall),
      _BrandSignature.exve => _ExveHero(brand: brand, isSmall: isSmall),
    };

    return Container(color: brand.heroBg, child: child);
  }
}

// ────────────────────────────────────────────────────────────────────────────
// HERO 1 — ContaSAS.ia
// ────────────────────────────────────────────────────────────────────────────

class _ContaSasHero extends StatelessWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _ContaSasHero({required this.brand, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSmall ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top: wordmark with IA badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Conta',
                      style: TextStyle(
                        fontFamily: Fonts.brand,
                        fontSize: 20,
                        color: brand.brandPrimary,
                        height: 1,
                      ),
                    ),
                    const TextSpan(
                      text: 'SAS',
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Palette.dark,
                        letterSpacing: -0.3,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: brand.brandPrimary,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'IA',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 9,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 0.3,
                      height: 1,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Middle: BIG balance
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'BALANCE · MAYO 2026',
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.6,
                  color: Palette.textMuted.withValues(alpha: 0.75),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '\$ 12,847.50',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: isSmall ? 30 : 36,
                  fontWeight: FontWeight.w700,
                  color: brand.heroOnBg,
                  letterSpacing: -1,
                  height: 1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                '+ IVA \$ 1,668.18',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Palette.textSecondary,
                  letterSpacing: 0,
                ),
              ),
            ],
          ),
          // Bottom: chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _Chip(
                label: 'Al día',
                fg: const Color(0xFF10B981),
                bg: const Color(0xFF10B981).withValues(alpha: 0.10),
                leading: Container(
                  width: 6,
                  height: 6,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              _Chip(
                label: 'Asistente IA',
                fg: brand.brandPrimary,
                bg: brand.brandPrimary.withValues(alpha: 0.10),
                leading: Icon(
                  Icons.psychology_outlined,
                  size: 12,
                  color: brand.brandPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// HERO 2 — Factura Fácil DTE
// ────────────────────────────────────────────────────────────────────────────

class _DteHero extends StatelessWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _DteHero({required this.brand, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSmall ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Monograma Ff in ink squircle
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: const Color(0xFF0F2A4D),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: brand.brandPrimary.withValues(alpha: 0.4),
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  left: 14,
                  top: 8,
                  child: Text(
                    'F',
                    style: TextStyle(
                      fontFamily: Fonts.title,
                      fontSize: 36,
                      color: brand.heroOnBg,
                      height: 1,
                    ),
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 10,
                  child: Text(
                    'f',
                    style: TextStyle(
                      fontFamily: Fonts.brand,
                      fontSize: 28,
                      color: brand.brandPrimary,
                      height: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Wordmark + DTE label
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'factura fácil',
                style: TextStyle(
                  fontFamily: Fonts.title,
                  fontSize: isSmall ? 22 : 26,
                  color: brand.heroOnBg,
                  height: 1.05,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'DTE',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: brand.heroOnBg.withValues(alpha: 0.6),
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
          // MH seal
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '✱',
                style: TextStyle(
                  fontSize: 14,
                  color: brand.brandPrimary,
                  height: 1,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'EL SALVADOR · MH · HOMOLOGADO',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        fontWeight: FontWeight.w600,
                        color: brand.brandPrimary,
                        letterSpacing: 1.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      'Edición 2026',
                      style: GoogleFonts.jetBrainsMono(
                        fontSize: 9,
                        fontWeight: FontWeight.w500,
                        color: brand.heroOnBg.withValues(alpha: 0.5),
                        letterSpacing: 0.8,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// HERO 3 — El Bicho IA
// ────────────────────────────────────────────────────────────────────────────

class _BichoHero extends StatefulWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _BichoHero({required this.brand, required this.isSmall});

  @override
  State<_BichoHero> createState() => _BichoHeroState();
}

class _BichoHeroState extends State<_BichoHero>
    with SingleTickerProviderStateMixin {
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _cursorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final brand = widget.brand;
    final isSmall = widget.isSmall;

    return Padding(
      padding: EdgeInsets.all(isSmall ? 22 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Pixel heading
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'EL BICHO IA',
                style: GoogleFonts.pressStart2p(
                  fontSize: 11,
                  color: brand.brandPrimary,
                  letterSpacing: 1.5,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: 36,
                height: 2,
                color: brand.brandPrimary,
              ),
            ],
          ),
          // Chat exchange
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: _BichoBubble(
                  text: 'ruta a Soyapango?',
                  bg: Color(0xFF2D8B4E),
                  textColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: _BichoBubble(
                  text: 'Ruta 41B · 38 min',
                  bg: const Color(0xFF141E33),
                  textColor: brand.brandPrimary,
                  trailing: AnimatedBuilder(
                    animation: _cursorController,
                    builder: (_, __) {
                      final v = _cursorController.value;
                      final visible = v < 0.5;
                      return Opacity(
                        opacity: visible ? 1 : 0,
                        child: Container(
                          width: 6,
                          height: 12,
                          color: brand.brandPrimary,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          // Tiny footer
          Text(
            '770+ rutas · gemma-3 fine-tuned',
            style: GoogleFonts.jetBrainsMono(
              fontSize: 9,
              color: Colors.white.withValues(alpha: 0.4),
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _BichoBubble extends StatelessWidget {
  final String text;
  final Color bg;
  final Color textColor;
  final Widget? trailing;

  const _BichoBubble({
    required this.text,
    required this.bg,
    required this.textColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFF2A3A52), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x80000000),
            offset: Offset(3, 3),
            blurRadius: 0,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              text,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: textColor,
                height: 1.3,
              ),
            ),
          ),
          if (trailing != null) ...[
            const SizedBox(width: 4),
            trailing!,
          ],
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// HERO 4 — TRAMA Store
// ────────────────────────────────────────────────────────────────────────────

class _TramaHero extends StatelessWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _TramaHero({required this.brand, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(isSmall ? 24 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top label
          Row(
            children: [
              Container(
                width: 24,
                height: 1,
                color: brand.brandPrimary,
              ),
              const SizedBox(width: 8),
              Text(
                'El Salvador',
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                  color: brand.brandPrimary,
                ),
              ),
            ],
          ),
          // Wordmark
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TRAMA',
                style: TextStyle(
                  fontFamily: Fonts.title,
                  fontSize: isSmall ? 52 : 64,
                  color: brand.heroOnBg,
                  letterSpacing: 4,
                  height: 0.95,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Container(width: 36, height: 1, color: brand.heroOnBg),
                  const SizedBox(width: 10),
                  Text(
                    'CAMISAS PARA HOMBRE',
                    style: TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                      color: brand.heroOnBg,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // Bottom: interlace mark (TRAMA's signature X)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'EST. 2024',
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 9,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.8,
                  color: brand.heroOnBg.withValues(alpha: 0.5),
                ),
              ),
              CustomPaint(
                size: const Size(28, 28),
                painter: _TramaInterlacePainter(color: brand.heroOnBg),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TramaInterlacePainter extends CustomPainter {
  final Color color;

  _TramaInterlacePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.6
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Two diagonal strokes forming an X / weave
    canvas.drawLine(
      Offset(0, size.height * 0.2),
      Offset(size.width, size.height * 0.8),
      paint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.2),
      paint,
    );
  }

  @override
  bool shouldRepaint(_TramaInterlacePainter old) => old.color != color;
}

// ────────────────────────────────────────────────────────────────────────────
// HERO 5 — EXVE
// ────────────────────────────────────────────────────────────────────────────

class _ExveHero extends StatelessWidget {
  final _ProjectBrand brand;
  final bool isSmall;

  const _ExveHero({required this.brand, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    const navy = Color(0xFF002045);
    const midNavy = Color(0xFF1A365D);
    const surfaceOutline = Color(0xFFE3E2E6);
    const amberSurface = Color(0xFFFAF3DF);

    return Padding(
      padding: EdgeInsets.all(isSmall ? 22 : 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top wordmark row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'EXVE',
                style: TextStyle(
                  fontFamily: Fonts.body,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: navy,
                  letterSpacing: 2.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: amberSurface,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  'PWA',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: brand.brandPrimary,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ],
          ),
          // Vehicle card mock
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: surfaceOutline),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: midNavy,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.directions_car_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Toyota Corolla 2018',
                        style: TextStyle(
                          fontFamily: Fonts.body,
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: navy,
                          letterSpacing: -0.1,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'P  4 8 7  ·  2 3 1',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: navy.withValues(alpha: 0.7),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Bottom: chip "En taller" + button "Autorizar"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Chip(
                label: 'En taller',
                fg: brand.brandPrimary,
                bg: amberSurface,
                leading: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: brand.brandPrimary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: brand.brandPrimary,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Autorizar',
                      style: TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      size: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Shared chip
// ────────────────────────────────────────────────────────────────────────────

class _Chip extends StatelessWidget {
  final String label;
  final Color fg;
  final Color bg;
  final Widget? leading;

  const _Chip({
    required this.label,
    required this.fg,
    required this.bg,
    this.leading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leading != null) ...[
            leading!,
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: fg,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}

// ────────────────────────────────────────────────────────────────────────────
// Body zone — structured info (challenge, solution, results, tags, link)
// ────────────────────────────────────────────────────────────────────────────

class _ProjectBody extends StatelessWidget {
  final _ProjectData data;
  final bool isSmall;

  const _ProjectBody({required this.data, required this.isSmall});

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final pad = isSmall ? 28.0 : 40.0;

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Status pill
          _Chip(
            label: data.status,
            fg: Palette.success,
            bg: Palette.success.withValues(alpha: 0.10),
            leading: Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Palette.success,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 18),
          // Project name
          Text(
            data.name,
            style: const TextStyle(
              fontFamily: Fonts.title,
              fontSize: 26,
              color: Palette.dark,
              letterSpacing: -0.5,
              height: 1.1,
            ),
          ),
          if (data.subtitle.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(
              data.subtitle,
              style: TextStyle(
                fontFamily: Fonts.body,
                fontSize: 13,
                fontStyle: FontStyle.italic,
                color: Palette.textMuted.withValues(alpha: 0.85),
                height: 1.5,
              ),
            ),
          ],
          const SizedBox(height: 22),
          _Block(label: s.portfolioChallenge, text: data.challenge),
          const SizedBox(height: 16),
          _Block(label: s.portfolioSolution, text: data.solution),
          const SizedBox(height: 16),
          _ResultsBlock(label: s.portfolioResults, results: data.results),
          const SizedBox(height: 22),
          // Tags
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: data.tags
                .map(
                  (tag) => Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Palette.dark.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        fontFamily: Fonts.body,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Palette.textSecondary,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          if (data.liveUrl != null) ...[
            const SizedBox(height: 20),
            _ViewLiveButton(url: data.liveUrl!, label: s.portfolioViewLive),
          ],
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  final String label;
  final String text;

  const _Block({required this.label, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: label),
        const SizedBox(height: 6),
        Text(
          text,
          style: const TextStyle(
            fontFamily: Fonts.body,
            fontSize: 14,
            color: Palette.textSecondary,
            height: 1.65,
          ),
        ),
      ],
    );
  }
}

class _ResultsBlock extends StatelessWidget {
  final String label;
  final List<String> results;

  const _ResultsBlock({required this.label, required this.results});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(label: label),
        const SizedBox(height: 8),
        ...results.map(
          (result) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 1),
                  child: Icon(
                    Icons.check,
                    color: Palette.success,
                    size: 14,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    result,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 13.5,
                      color: Palette.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;

  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontFamily: Fonts.body,
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.6,
        color: Palette.textMuted.withValues(alpha: 0.7),
      ),
    );
  }
}

class _ViewLiveButton extends StatefulWidget {
  final String url;
  final String label;

  const _ViewLiveButton({required this.url, required this.label});

  @override
  State<_ViewLiveButton> createState() => _ViewLiveButtonState();
}

class _ViewLiveButtonState extends State<_ViewLiveButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => safeLaunchUrl(context, widget.url),
        child: AnimatedDefaultTextStyle(
          duration: AppTransitions.fast,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 13,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
            color: _isHovered ? Palette.primaryDark : Palette.dark,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.label),
              const SizedBox(width: 6),
              Icon(
                Icons.arrow_outward,
                size: 14,
                color: _isHovered ? Palette.primaryDark : Palette.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
