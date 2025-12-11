import 'package:flutter/material.dart';
import 'package:inspirare/pages/landing/desktop_layout.dart';

import 'package:inspirare/pages/landing/mobile_layout.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder nos da las restricciones de tamaño del widget padre.
    // Lo usamos para decidir qué layout mostrar.
    return LayoutBuilder(
      builder: (context, constraints) {
        // Definimos un punto de quiebre (breakpoint).
        // Si el ancho es mayor a 600px, mostramos el layout de escritorio.
        // Si no, mostramos el de móvil.
        if (constraints.maxWidth > 700) {
          return const HeroSectionWeb();
        } else {
          return const MobileLayout();
        }
      },
    );
  }
}
