import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(body: Align(alignment: Alignment.topCenter, child: child)),
);

final _gradient = find.byWidgetPredicate(
  (widget) =>
      widget is DecoratedBox && widget.decoration is BoxDecoration && (widget.decoration as BoxDecoration).gradient != null,
);

void main() {
  testWidgets('showGradient with hideBackground paints the gradient 18 px taller than the bar', (tester) async {
    const bar = DotsTopBar.title(title: 'Elige qué crear', hideBackground: true, showGradient: true);
    await tester.pumpWidget(_host(bar));

    expect(_gradient, findsOneWidget);
    expect(tester.getSize(_gradient).height, bar.preferredSize.height + DotsTopBar.gradientOverflow);
    expect(tester.getSize(find.byType(DotsTopBar)).height, bar.preferredSize.height);
    expect(find.ancestor(of: _gradient, matching: find.byType(IgnorePointer)), findsWidgets);

    final gradient = (tester.widget<DecoratedBox>(_gradient).decoration as BoxDecoration).gradient as LinearGradient;
    final colors = dotsThemeDataLight.extension<DotsTheme>()!.colors;
    expect(gradient.stops, [0.22, 1]);
    expect(gradient.colors.last, colors.bgBaseGradientStart);
  });

  testWidgets('no gradient without showGradient, with a background or with an explicit color', (tester) async {
    for (final bar in const [
      DotsTopBar.title(title: 'Elige qué crear', hideBackground: true),
      DotsTopBar.title(title: 'Elige qué crear', showGradient: true),
      DotsTopBar.title(title: 'Elige qué crear', hideBackground: true, showGradient: true, color: Colors.white),
    ]) {
      await tester.pumpWidget(_host(bar));
      expect(_gradient, findsNothing);
    }
  });
}
