import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspirare/widgets/sections/hero_section.dart';
import 'package:visibility_detector/visibility_detector.dart';

void main() {
  setUp(() {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  Widget buildHero() {
    return const MaterialApp(
      home: Scaffold(body: SingleChildScrollView(child: HeroSection())),
    );
  }

  group('HeroSection', () {
    testWidgets('renders action buttons', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Get Your Free Estimate'), findsOneWidget);
      expect(find.text('See Our Work'), findsOneWidget);
    });

    testWidgets('shows 4 metrics', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('20+'), findsOneWidget);
      expect(find.text('CST'), findsOneWidget);
      expect(find.text('40-60%'), findsOneWidget);
    });

    testWidgets('builds correctly', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(HeroSection), findsOneWidget);
    });
  });
}
