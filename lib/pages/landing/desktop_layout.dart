import 'package:flutter/material.dart';

import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/cards_desktop.dart';

class HeroSectionWeb extends StatefulWidget {
  const HeroSectionWeb({super.key});

  @override
  State<HeroSectionWeb> createState() => _HeroSectionWebState();
}

class _HeroSectionWebState extends State<HeroSectionWeb> {
  @override
  Widget build(BuildContext context) {
    // Usamos un Scaffold como base de nuestra página
    return Scaffold(
      body: Stack(
        children: [
          // 1. IMAGEN DE FONDO
          // La colocamos como el primer elemento para que quede detrás de todo.
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                // Asegúrate de que la ruta a tu imagen sea correcta
                image: AssetImage('assets/images/1.webp'),
                // BoxFit.cover hace que la imagen cubra todo el espacio sin deformarse
                fit: BoxFit.cover,
              ),
            ),
          ),

          // (Opcional) Una capa semitransparente para mejorar la legibilidad del texto
          Container(
            color: const Color.fromARGB(15, 0, 0, 0).withValues(alpha: 0.15),
          ),
          // 2. CONTENIDO SUPERPUESTO
          // Usamos un Padding para que el contenido no quede pegado a los bordes
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 30.0,
              horizontal: 80.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2.1 BARRA DE NAVEGACIÓN SUPERIOR (CUSTOM APPBAR)
                _CustomAppBar(),

                // 2.2 CONTENIDO CENTRAL alineado a la izquierda
                Expanded(
                  child: Align(alignment: Alignment.center, child: SizedBox()),
                ),

                // 2.3 TEXTO INFERIOR
                _BottomText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Widget para la barra de navegación
class _CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Lado izquierdo
        Row(
          children: [
            const Text(
              'Inspirare',
              style: TextStyle(
                color: Palette.background,
                fontFamily: Fonts.brand,
                fontSize: 48,
              ),
            ),
            const SizedBox(width: 50),
            _navLink(context, 'Nosotros'),
            const SizedBox(width: 20),
            _navLink(context, 'Historias'),
            const SizedBox(width: 20),
            _navLink(context, 'Productos'),
          ],
        ),
        // Lado derecho
        Row(
          children: [
            const SizedBox(width: 30),
            // Botón CTA destacado
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  showNonModalPopup(context, ContactContent());
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Palette.primary,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Palette.primary.withValues(alpha: 0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Contáctanos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none,
                      fontFamily: Fonts.body,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _navLink(BuildContext context, String text) {
    return GestureDetector(
      onTap: () {
        Widget? dialogContent;
        if (text == 'Nosotros') {
          dialogContent = NosotrosContent();
        } else if (text == 'Historias') {
          dialogContent = HistoriesContent();
        } else if (text == 'Productos') {
          dialogContent = ProductContent();
        } else if (text == 'Contactanos') {
          dialogContent = ContactContent();
        }
        if (dialogContent != null) {
          showNonModalPopup(context, dialogContent);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 18,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  // Popup no modal usando Overlay
  void showNonModalPopup(BuildContext context, Widget content) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;
    entry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Fondo transparente que cierra el popup al hacer click
          Positioned.fill(
            child: GestureDetector(
              onTap: () => entry.remove(),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Popup centrado
          Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 700),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.close,
                          color: Palette.background,
                          size: 28,
                        ),
                        onPressed: () => entry.remove(),
                        tooltip: 'Cerrar',
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(20), child: content),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
    overlay.insert(entry);
  }
}

// Widget para el contenido central

// Widget para el texto de la parte inferior
class _BottomText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: EdgeInsets.only(bottom: 20.0),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(fontSize: 18, color: Colors.white70),
            children: <TextSpan>[
              TextSpan(
                text: 'Creamos experiencias digitales que ',
                style: TextStyle(fontFamily: Fonts.body),
              ),
              TextSpan(
                text: 'Inspiran',
                style: TextStyle(
                  fontSize: 28,
                  color: Palette.background,
                  fontFamily: Fonts.brand,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
