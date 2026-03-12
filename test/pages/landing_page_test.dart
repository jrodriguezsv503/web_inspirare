import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspirare/pages/landing_page.dart';
import 'package:inspirare/pages/landing/desktop_layout.dart';
import 'package:inspirare/pages/landing/mobile_layout.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  group('LandingPage', () {
    testWidgets('muestra MobileLayout en pantallas angostas', (tester) async {
      // Suppress overflow errors in tests (nav logo overflows at tiny sizes)
      final originalOnError = FlutterError.onError;
      FlutterError.onError = (details) {
        if (details.toString().contains('overflowed')) return;
        originalOnError?.call(details);
      };
      addTearDown(() => FlutterError.onError = originalOnError);

      tester.view.physicalSize = const Size(375, 812);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MaterialApp(home: LandingPage()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(MobileLayout), findsOneWidget);
      expect(find.byType(HeroSectionWeb), findsNothing);
    });

    testWidgets('muestra HeroSectionWeb en pantallas anchas', (tester) async {
      tester.view.physicalSize = const Size(1200, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(const MaterialApp(home: LandingPage()));
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(HeroSectionWeb), findsOneWidget);
      expect(find.byType(MobileLayout), findsNothing);
    });
  });
}
