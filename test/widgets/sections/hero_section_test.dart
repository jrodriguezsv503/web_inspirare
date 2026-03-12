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
    testWidgets('renderiza botones de acción', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Conocer Productos'), findsOneWidget);
      expect(find.text('Hablar con el equipo'), findsOneWidget);
    });

    testWidgets('muestra las 4 métricas', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('SaaS'), findsOneWidget);
      expect(find.text('IA'), findsOneWidget);
      expect(find.text('24/7'), findsOneWidget);
    });

    testWidgets('se construye correctamente', (tester) async {
      tester.view.physicalSize = const Size(1200, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildHero());
      await tester.pump(const Duration(seconds: 1));

      expect(find.byType(HeroSection), findsOneWidget);
    });
  });
}
