import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:inspirare/theme/web_theme.dart';

/// Widget que anima su hijo con fade-up al hacerse visible en el viewport.
///
/// Utiliza [VisibilityDetector] para detectar cuándo el widget entra en
/// pantalla y ejecuta una animación de opacidad + traslación. Si se
/// proporciona [sectionId], también registra un evento `view_section` en
/// Analytics la primera vez que la sección se vuelve visible (dedup
/// gestionado por [AnalyticsService]).
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset slideOffset;
  final String? sectionId;

  const AnimatedSection({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = AppDurations.ethereal,
    this.slideOffset = const Offset(0, 24),
    this.sectionId,
  });

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.cloud),
    );

    _slide = Tween<Offset>(begin: widget.slideOffset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: AppCurves.cloud),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (!_hasAnimated && info.visibleFraction > 0.2) {
      _hasAnimated = true;
      final reduceMotion = MediaQuery.of(context).disableAnimations;
      if (reduceMotion) {
        _controller.value = 1.0;
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller.forward();
          }
        });
      }
      if (widget.sectionId != null) {
        AnalyticsService.instance.logSectionView(widget.sectionId!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('animated_section_${widget.sectionId ?? widget.hashCode}'),
      onVisibilityChanged: _onVisibilityChanged,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: _slide.value,
            child: Opacity(opacity: _opacity.value, child: child),
          );
        },
        child: widget.child,
      ),
    );
  }
}
