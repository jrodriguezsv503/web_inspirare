import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_events.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/core/constants/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

/// Lanza una URL de forma segura con manejo de errores y feedback al usuario.
///
/// Si [channel] se especifica (o puede inferirse desde la URL),
/// también registra un evento de Analytics antes de abrir el enlace.
/// Si la URL no puede abrirse, muestra un [SnackBar] informando al usuario.
Future<void> safeLaunchUrl(
  BuildContext context,
  String url, {
  String? channel,
  String? source,
}) async {
  final uri = Uri.parse(url);
  final resolvedChannel = channel ?? _inferChannel(url);
  if (resolvedChannel != null) {
    // Fire-and-forget: never block UX on the analytics event.
    AnalyticsService.instance.logExternalLink(
      channel: resolvedChannel,
      url: url,
      source: source,
    );
  }

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

String? _inferChannel(String url) {
  if (url.startsWith('mailto:') || url == AppUrls.email) return Channels.email;
  if (url.startsWith(AppUrls.whatsapp) || url.contains('wa.me/')) {
    return Channels.whatsapp;
  }
  if (url.contains('calendly.com')) return Channels.calendly;
  if (url.contains('linkedin.com')) return Channels.linkedin;
  if (url.startsWith('tel:')) return Channels.phone;
  return null;
}
