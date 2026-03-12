import 'package:flutter/material.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:inspirare/core/utils/url_launcher_helper.dart';
import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/common/animated_section.dart';
import 'package:inspirare/widgets/common/section_header.dart';

/// Sección de precios con tarjetas para Factura Fácil DTE y ContaSAS.ia.
class PricingSection extends StatelessWidget {
  final bool isMobile;

  const PricingSection({super.key, this.isMobile = false});

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
        bottom: isSmall ? 32 : 48,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1280),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AnimatedSection(
                child: SectionHeader(
                  label: 'Precios',
                  title: 'Simple. Transparente.\nSin sorpresas.',
                  subtitle:
                      'Un plan por producto. Todo incluido. Cancela cuando quieras.',
                  isLeftAligned: true,
                ),
              ),
              SizedBox(height: isSmall ? 40 : 64),
              AnimatedSection(
                delay: const Duration(milliseconds: 300),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 840),
                  child: isSmall
                      ? const Column(
                          children: [
                            _PriceCard(
                              productName: 'Factura Fácil DTE',
                              description:
                                  'Facturación electrónica certificada para empresas en El Salvador.',
                              price: '\$15',
                              priceSuffix: ' /mes',
                              trialText: 'Implementación en menos de 24 horas',
                              features: [
                                'Facturas electrónicas ilimitadas',
                                'Créditos Fiscales y Notas de Crédito',
                                'Certificado por Ministerio de Hacienda',
                                'Panel de control y reportes',
                                'Soporte vía WhatsApp',
                              ],
                              buttonLabel: 'Empezar Gratis',
                              buttonColor: Palette.dtePrimary,
                              buttonHoverColor: Palette.dteSecondary,
                              accentGradient: [
                                Palette.dtePrimary,
                                Color(0xFF1A237E),
                              ],
                              url: AppUrls.dteApp,
                            ),
                            SizedBox(height: 32),
                            _PriceCard(
                              productName: 'ContaSAS.ia',
                              description:
                                  'Contabilidad inteligente con asistente legal de IA para S.A.S.',
                              price: '\$19',
                              priceSuffix: '.99 /mes',
                              trialText: '3 días gratis para probar',
                              features: [
                                'Declaraciones IVA F-07 automáticas',
                                'Pago a Cuenta F-14',
                                'Libros contables con validez legal',
                                'Asistente legal con IA',
                                'Semáforo de cumplimiento tributario',
                              ],
                              buttonLabel: 'Empezar Gratis',
                              buttonColor: Palette.contasasPrimary,
                              buttonHoverColor: Color(0xFF0891B2),
                              accentGradient: [
                                Palette.contasasPrimary,
                                Color(0xFF06B6D4),
                              ],
                              url: AppUrls.contasasApp,
                            ),
                          ],
                        )
                      : const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: _PriceCard(
                                productName: 'Factura Fácil DTE',
                                description:
                                    'Facturación electrónica certificada para empresas en El Salvador.',
                                price: '\$15',
                                priceSuffix: ' /mes',
                                trialText:
                                    'Implementación en menos de 24 horas',
                                features: [
                                  'Facturas electrónicas ilimitadas',
                                  'Créditos Fiscales y Notas de Crédito',
                                  'Certificado por Ministerio de Hacienda',
                                  'Panel de control y reportes',
                                  'Soporte vía WhatsApp',
                                ],
                                buttonLabel: 'Empezar Gratis',
                                buttonColor: Palette.dtePrimary,
                                buttonHoverColor: Palette.dteSecondary,
                                accentGradient: [
                                  Palette.dtePrimary,
                                  Color(0xFF1A237E),
                                ],
                                url: AppUrls.dteApp,
                              ),
                            ),
                            SizedBox(width: 32),
                            Expanded(
                              child: _PriceCard(
                                productName: 'ContaSAS.ia',
                                description:
                                    'Contabilidad inteligente con asistente legal de IA para S.A.S.',
                                price: '\$19',
                                priceSuffix: '.99 /mes',
                                trialText: '3 días gratis para probar',
                                features: [
                                  'Declaraciones IVA F-07 automáticas',
                                  'Pago a Cuenta F-14',
                                  'Libros contables con validez legal',
                                  'Asistente legal con IA',
                                  'Semáforo de cumplimiento tributario',
                                ],
                                buttonLabel: 'Empezar Gratis',
                                buttonColor: Palette.contasasPrimary,
                                buttonHoverColor: Color(0xFF0891B2),
                                accentGradient: [
                                  Palette.contasasPrimary,
                                  Color(0xFF06B6D4),
                                ],
                                url: AppUrls.contasasApp,
                              ),
                            ),
                          ],
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

class _PriceCard extends StatefulWidget {
  final String productName;
  final String description;
  final String price;
  final String priceSuffix;
  final String trialText;
  final List<String> features;
  final String buttonLabel;
  final Color buttonColor;
  final Color buttonHoverColor;
  final List<Color> accentGradient;
  final String url;

  const _PriceCard({
    required this.productName,
    required this.description,
    required this.price,
    required this.priceSuffix,
    required this.trialText,
    required this.features,
    required this.buttonLabel,
    required this.buttonColor,
    required this.buttonHoverColor,
    required this.accentGradient,
    required this.url,
  });

  @override
  State<_PriceCard> createState() => _PriceCardState();
}

class _PriceCardState extends State<_PriceCard> {
  bool _isHovered = false;
  bool _isButtonHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: AppTransitions.normal,
        transform: _isHovered
            ? Matrix4.translationValues(0, -4, 0)
            : Matrix4.identity(),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 40,
                    offset: const Offset(0, 12),
                  ),
                ]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent bar
            Container(
              height: 4,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: widget.accentGradient),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productName,
                    style: const TextStyle(
                      fontFamily: Fonts.title,
                      fontSize: 24,
                      color: Palette.dark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.description,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 14,
                      color: Palette.textMuted,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Price
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: widget.price,
                          style: const TextStyle(
                            fontFamily: Fonts.body,
                            fontSize: 42,
                            fontWeight: FontWeight.w700,
                            color: Palette.dark,
                            letterSpacing: -1,
                          ),
                        ),
                        TextSpan(
                          text: widget.priceSuffix,
                          style: const TextStyle(
                            fontFamily: Fonts.body,
                            fontSize: 16,
                            color: Palette.textMuted,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.trialText,
                    style: const TextStyle(
                      fontFamily: Fonts.body,
                      fontSize: 13,
                      color: Palette.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Features
                  ...widget.features.map(
                    (feature) => Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black.withValues(alpha: 0.04),
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            '✓',
                            style: TextStyle(
                              color: Palette.primary,
                              fontWeight: FontWeight.w700,
                              fontSize: 13,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              feature,
                              style: const TextStyle(
                                fontFamily: Fonts.body,
                                fontSize: 14,
                                color: Palette.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  // CTA Button
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => setState(() => _isButtonHovered = true),
                    onExit: (_) => setState(() => _isButtonHovered = false),
                    child: GestureDetector(
                      onTap: () => safeLaunchUrl(context, widget.url),
                      child: AnimatedContainer(
                        duration: AppTransitions.fast,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        transform: _isButtonHovered
                            ? Matrix4.translationValues(0, -2, 0)
                            : Matrix4.identity(),
                        decoration: BoxDecoration(
                          color: _isButtonHovered
                              ? widget.buttonHoverColor
                              : widget.buttonColor,
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: _isButtonHovered
                              ? [
                                  BoxShadow(
                                    color: widget.buttonColor.withValues(
                                      alpha: 0.3,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ]
                              : [],
                        ),
                        child: Center(
                          child: Text(
                            widget.buttonLabel,
                            style: const TextStyle(
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
          ],
        ),
      ),
    );
  }
}
