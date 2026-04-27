import 'package:flutter/material.dart';
import 'package:inspirare/core/analytics/analytics_service.dart';
import 'package:visibility_detector/visibility_detector.dart';

/// Wraps a top-level landing section so its visibility fires a one-time
/// `view_section` analytics event. The provided [scrollKey] (used by
/// scroll-to-section navigation) is kept on this widget so behavior is
/// unchanged from the previous `Container(key: ...)` usage.
class SectionTracker extends StatelessWidget {
  final Key scrollKey;
  final String sectionId;
  final Widget child;

  const SectionTracker({
    super.key,
    required this.scrollKey,
    required this.sectionId,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: scrollKey,
      child: VisibilityDetector(
        key: Key('section_tracker_$sectionId'),
        onVisibilityChanged: (info) {
          if (info.visibleFraction > 0.25) {
            AnalyticsService.instance.logSectionView(sectionId);
          }
        },
        child: child,
      ),
    );
  }
}
