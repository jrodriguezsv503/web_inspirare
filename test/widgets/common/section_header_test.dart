import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:inspirare/widgets/common/section_header.dart';

void main() {
  group('SectionHeader', () {
    testWidgets('renderiza label, título y subtítulo', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              label: 'Test Label',
              title: 'Test Title',
              subtitle: 'Test Subtitle',
            ),
          ),
        ),
      );

      expect(find.text('TEST LABEL'), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Subtitle'), findsOneWidget);
    });

    testWidgets('no muestra subtítulo cuando es null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(label: 'Label', title: 'Title'),
          ),
        ),
      );

      expect(find.text('LABEL'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
    });

    testWidgets('alinea a la izquierda cuando isLeftAligned es true', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SectionHeader(
              label: 'Left',
              title: 'Left Title',
              isLeftAligned: true,
            ),
          ),
        ),
      );

      final column = tester.widget<Column>(find.byType(Column).first);
      expect(column.crossAxisAlignment, CrossAxisAlignment.start);
    });
  });
}
