/// URLs externas y constantes de la aplicación INSPIRARE.
class AppUrls {
  AppUrls._();

  static const String whatsapp = 'https://wa.me/50379336960';
  static const String email = 'mailto:info@inspirare.app';
  static const String dteApp = 'https://dte.inspirare.app';
  static const String contasasApp = 'https://contasas.inspirare.app';
}

/// Secciones de navegación de la landing page.
enum NavSection {
  inicio,
  productos,
  nosotros,
  precios;

  /// Retorna la etiqueta visible para el usuario.
  String get label {
    switch (this) {
      case NavSection.inicio:
        return 'Inicio';
      case NavSection.productos:
        return 'Productos';
      case NavSection.nosotros:
        return 'Nosotros';
      case NavSection.precios:
        return 'Precios';
    }
  }
}
