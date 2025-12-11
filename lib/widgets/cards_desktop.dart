import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:inspirare/theme/web_theme.dart';

class NosotrosContent extends StatelessWidget {
  const NosotrosContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // Título con color primary
        Text(
          'Sobre Nosotros',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.title,
            fontSize: 32,
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        // Línea decorativa
        Container(
          width: 60,
          height: 3,
          decoration: BoxDecoration(
            color: Palette.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 24),
        // Contenido mejorado
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 18,
              color: Palette.background,
              height: 1.6,
            ),
            children: <TextSpan>[
              TextSpan(text: 'En '),
              TextSpan(
                text: 'Inspirare',
                style: TextStyle(
                  fontFamily: Fonts.brand,
                  fontSize: 20,
                  color: Palette.primary,
                ),
              ),
              TextSpan(
                text: ', transformamos tus ideas en realidades digitales.',
              ),
              TextSpan(text: ' Somos un equipo de '),
              TextSpan(
                text: 'desarrolladores y diseñadores apasionados',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Palette.primary,
                ),
              ),
              TextSpan(
                text:
                    ' por la tecnología y la creación de productos digitales que marcan la diferencia.',
              ),

              TextSpan(
                text:
                    ' Combinamos creatividad y experiencia técnica para transformar tus ideas en realidad digital.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        // Misión destacada
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Palette.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Palette.primary.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.stars_rounded, color: Palette.primary, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  'Nuestra misión: ayudarte a crecer en el mundo digital con herramientas confiables, seguras e innovadoras.',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 17,
                    color: Palette.background,
                    height: 1.5,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

class HistoriesContent extends StatelessWidget {
  const HistoriesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Título con color primary
          Text(
            'Nuestros Clientes',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.title,
              fontSize: 32,
              color: Palette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Línea decorativa
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Lo que dicen de nosotros',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 16,
              color: Palette.background.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 32),
          // Testimonio 1
          _TestimonioCard(
            logoPath: 'assets/images/semyp.webp',
            testimonio:
                'El equipo de Inspirare.app ha sido fundamental para el éxito de nuestro proyecto. Su dedicación, creatividad y profesionalismo han superado nuestras expectativas. Gracias a ellos, hemos podido implementar el sistema de facturación electronica en tiempo récord.',
            autor: 'Gerente General',
            empresa: 'SEMYP',
          ),
          const SizedBox(height: 24),
          // Testimonio 2
          _TestimonioCard(
            logoPath: 'assets/images/aucom.webp',
            testimonio:
                'Trabajar con Inspirare.app ha sido una experiencia excepcional. La dedicación y profesionalismo de su equipo nos permitieron implementar nuestro sistema de facturación electrónica en tiempo récord. Sin duda, son el socio tecnológico ideal.',
            autor: 'Gerente General',
            empresa: 'AUCOM',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Widget para testimonios
class _TestimonioCard extends StatelessWidget {
  final String logoPath;
  final String testimonio;
  final String autor;
  final String empresa;

  const _TestimonioCard({
    required this.logoPath,
    required this.testimonio,
    required this.autor,
    required this.empresa,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Palette.background.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Palette.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          // Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(logoPath, width: 120, fit: BoxFit.cover),
          ),
          const SizedBox(height: 20),
          // Ícono de comillas
          Icon(Icons.format_quote, color: Palette.primary, size: 40),
          const SizedBox(height: 12),
          // Testimonio
          Text(
            testimonio,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 17,
              color: Palette.background,
              height: 1.6,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 20),
          // Autor
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Text(
                  autor,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 15,
                    color: Palette.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  empresa,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 14,
                    color: Palette.background.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProductContent extends StatelessWidget {
  const ProductContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          // Título con color primary
          Text(
            'Nuestros Servicios',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.title,
              fontSize: 32,
              color: Palette.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          // Línea decorativa
          Container(
            width: 60,
            height: 3,
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Soluciones digitales a tu medida',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Fonts.body,
              fontSize: 16,
              color: Palette.background.withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 32),
          // Servicio 1
          _ServicioCard(
            icon: Icons.phone_iphone_outlined,
            titulo: 'Aplicaciones Móviles',
            descripcion:
                'Creamos aplicaciones móviles intuitivas y atractivas para iOS y Android, diseñadas para ofrecer una experiencia de usuario excepcional y adaptarse a las necesidades específicas de tu negocio.',
          ),
          const SizedBox(height: 20),
          // Servicio 2
          _ServicioCard(
            icon: Icons.web_outlined,
            titulo: 'Desarrollo Web',
            descripcion:
                'Diseñamos y desarrollamos sitios web modernos, rápidos y adaptables, enfocados en potenciar tu presencia digital y atraer más clientes.',
          ),
          const SizedBox(height: 20),
          // Servicio 3
          _ServicioCard(
            icon: Icons.desktop_windows_outlined,
            titulo: 'Mantenimiento y Soporte',
            descripcion:
                'Tu tecnología siempre funcionando. Te acompañamos con asistencia técnica confiable, actualizaciones constantes y soporte continuo para garantizar el éxito de tus proyectos digitales.',
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

// Widget para servicios
class _ServicioCard extends StatelessWidget {
  final IconData icon;
  final String titulo;
  final String descripcion;

  const _ServicioCard({
    required this.icon,
    required this.titulo,
    required this.descripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Palette.background.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Palette.primary.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Ícono destacado
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Palette.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Palette.primary, size: 40),
          ),
          const SizedBox(width: 20),
          // Contenido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 22,
                    color: Palette.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  descripcion,
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 16,
                    color: Palette.background,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContactContent extends StatelessWidget {
  const ContactContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        // Título llamativo
        Text(
          '¡Hablemos de tu proyecto!',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.title,
            fontSize: 32,
            color: Palette.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Estamos listos para hacer realidad tus ideas',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: Fonts.body,
            fontSize: 18,
            color: Palette.background.withValues(alpha: 0.9),
          ),
        ),
        const SizedBox(height: 40),
        // Botón WhatsApp destacado con primary
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse('https://wa.me/50379336960')),
            icon: const Icon(FontAwesomeIcons.whatsapp, size: 28),
            label: const Text('Chatea por WhatsApp'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.primary,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              textStyle: const TextStyle(
                fontFamily: Fonts.body,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 4,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Botón Email secundario
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () => launchUrl(Uri.parse('mailto:info@inspirare.app')),
            icon: const Icon(Icons.email, size: 28),
            label: const Text('Escríbenos un email'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Palette.primary,
              side: BorderSide(color: Palette.primary, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              textStyle: const TextStyle(
                fontFamily: Fonts.body,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 30),
        // Info de contacto como texto
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phone,
                  color: Palette.background.withValues(alpha: 0.7),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  '+503 7933-6960',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 16,
                    color: Palette.background.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email_outlined,
                  color: Palette.background.withValues(alpha: 0.7),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Text(
                  'info@inspirare.app',
                  style: TextStyle(
                    fontFamily: Fonts.body,
                    fontSize: 16,
                    color: Palette.background.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
