import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(body: Center(child: child)),
);

BoxDecoration _decoration(WidgetTester tester) {
  final container = tester.widget<Container>(
    find.descendant(of: find.byType(DotsCheckCircle), matching: find.byType(Container)).first,
  );
  return container.decoration! as BoxDecoration;
}

void main() {
  testWidgets('unselected is an empty labelSecondary ring', (tester) async {
    await tester.pumpWidget(_host(const DotsCheckCircle(isSelected: false)));
    final colors = tester.element(find.byType(DotsCheckCircle)).dotsTheme.colors;

    expect(tester.getSize(find.byType(DotsCheckCircle)), const Size(24, 24));
    final decoration = _decoration(tester);
    expect(decoration.shape, BoxShape.circle);
    expect(decoration.color, Colors.transparent);
    expect(decoration.border, Border.all(color: colors.labelSecondary, width: 2));
    expect(find.byType(DotsIcon), findsNothing);
  });

  testWidgets('selected is a labelHighlight disc with a white check', (tester) async {
    await tester.pumpWidget(_host(const DotsCheckCircle(isSelected: true)));
    final colors = tester.element(find.byType(DotsCheckCircle)).dotsTheme.colors;

    final decoration = _decoration(tester);
    expect(decoration.color, colors.labelHighlight);
    expect(decoration.border, isNull);
    final icon = tester.widget<DotsIcon>(find.byType(DotsIcon));
    expect(icon.iconData, DotsIconData.check);
    expect(icon.size, 14);
    expect(icon.color, colors.labelAlwaysWhite);
  });

  testWidgets('size sets the diameter', (tester) async {
    await tester.pumpWidget(_host(const DotsCheckCircle(isSelected: false, size: 22)));

    expect(tester.getSize(find.byType(DotsCheckCircle)), const Size(22, 22));
  });
}
