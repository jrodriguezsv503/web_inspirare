import 'package:flutter/material.dart';

import 'package:inspirare/theme/web_theme.dart';
import 'package:inspirare/widgets/cards_movil.dart';

class MobileLayout extends StatefulWidget {
  const MobileLayout({super.key});

  @override
  State<MobileLayout> createState() => _MobileLayoutState();
}

class _MobileLayoutState extends State<MobileLayout> {
  @override
  Widget build(BuildContext context) {
    // Usamos un Scaffold como base de nuestra página
    return Scaffold(
      body: Stack(
        children: [
          // 1. IMAGEN DE FONDO
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/1.webp'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AppBar con logo y hamburguesa
                _MobileAppBar(),
                Expanded(
                  child: Align(alignment: Alignment.center, child: SizedBox()),
                ),
                _BottomText(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// AppBar para móvil con menú hamburguesa que despliega un dropdown transparente
class _MobileAppBar extends StatefulWidget {
  @override
  State<_MobileAppBar> createState() => _MobileAppBarState();
}

class _MobileAppBarState extends State<_MobileAppBar> {
  OverlayEntry? _dropdownEntry;

  void _showDropdownMenu() {
    final RenderBox appBarBox = context.findRenderObject() as RenderBox;
    final Offset offset = appBarBox.localToGlobal(Offset.zero);
    final Size size = appBarBox.size;

    _dropdownEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeDropdown,
        child: Stack(
          children: [
            Positioned.fill(child: Container(color: Colors.transparent)),
            Positioned(
              top: offset.dy + size.height + 8,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 220,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 12),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _DropdownMenuItem(
                        text: 'Nosotros',
                        onTap: () {
                          _removeDropdown();
                          _showNonModalPopup(context, NosotrosMovil());
                        },
                      ),
                      _DropdownMenuItem(
                        text: 'Historias',
                        onTap: () {
                          _removeDropdown();
                          _showNonModalPopup(context, HistoriesMovil());
                        },
                      ),
                      _DropdownMenuItem(
                        text: 'Productos',
                        onTap: () {
                          _removeDropdown();
                          _showNonModalPopup(context, ProductMovil());
                        },
                      ),
                      const Divider(color: Colors.white24),
                      // Botón CTA destacado
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            _removeDropdown();
                            _showNonModalPopup(context, ContactMovil());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: Palette.primary,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Text(
                                'Contáctanos',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: Fonts.body,
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
        ),
      ),
    );
    Overlay.of(context).insert(_dropdownEntry!);
  }

  void _removeDropdown() {
    _dropdownEntry?.remove();
    _dropdownEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Inspirare',
          style: TextStyle(
            color: Palette.background,
            fontFamily: Fonts.brand,
            fontSize: 28,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.white70, size: 32),
          onPressed: _showDropdownMenu,
          tooltip: 'Menú',
        ),
      ],
    );
  }
}

class _DropdownMenuItem extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  const _DropdownMenuItem({required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// (Drawer eliminado, ahora se usa dropdown overlay)

// Popup no modal usando Overlay (reutilizado)
void _showNonModalPopup(BuildContext context, Widget content) {
  final overlay = Overlay.of(context);
  late OverlayEntry entry;
  entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => entry.remove(),
            child: Container(color: Colors.transparent),
          ),
        ),
        Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 500),
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
                        size: 30,
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
