import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// Lanza una URL de forma segura con manejo de errores y feedback al usuario.
///
/// Si la URL no puede abrirse, muestra un [SnackBar] informando al usuario.
Future<void> safeLaunchUrl(BuildContext context, String url) async {
  final uri = Uri.parse(url);
  try {
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No se pudo abrir el enlace')),
        );
      }
    }
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Error al abrir el enlace')));
    }
  }
}
