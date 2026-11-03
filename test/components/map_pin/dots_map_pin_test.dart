import 'dart:ui' show SemanticsFlag;

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

  testWidgets('semanticsLabel names the marker as an image', (tester) async {
    final semantics = tester.ensureSemantics();

    await tester.pumpWidget(_host(const DotsMapPin(semanticsLabel: 'Finca El Olivar')));

    expect(tester.getSemantics(find.byType(DotsMapPin)), matchesSemantics(label: 'Finca El Olivar', isImage: true));
    semantics.dispose();
  });

  testWidgets('without a semanticsLabel, or with an empty one, the marker is decorative', (tester) async {
    final semantics = tester.ensureSemantics();

    for (final label in [null, '']) {
      await tester.pumpWidget(_host(DotsMapPin(semanticsLabel: label)));

      expect(find.semantics.byFlag(SemanticsFlag.isImage), findsNothing, reason: 'semanticsLabel: $label');
    }
    semantics.dispose();
  });
}
