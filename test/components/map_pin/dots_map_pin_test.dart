import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(body: Center(child: child)),
);

void main() {
  testWidgets('the marker keeps the box of the Figma component', (tester) async {
    await tester.pumpWidget(_host(const DotsMapPin()));

    expect(tester.getSize(find.byType(DotsMapPin)), DotsMapPin.size);
    expect(tester.takeException(), isNull);
  });

  testWidgets('semanticsLabel names the marker; without it the marker is decorative', (tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(_host(const DotsMapPin(semanticsLabel: 'Finca El Olivar')));
    expect(find.bySemanticsLabel('Finca El Olivar'), findsOneWidget);

    await tester.pumpWidget(_host(const DotsMapPin()));
    expect(find.bySemanticsLabel('Finca El Olivar'), findsNothing);

    semantics.dispose();
  });
}
