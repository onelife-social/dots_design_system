import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(body: Center(child: child)),
);

BoxDecoration _circle(WidgetTester tester) {
  final box = tester.widget<DotsDecoratedBox>(
    find.descendant(of: find.byType(DotsIconButton), matching: find.byType(DotsDecoratedBox)).first,
  );
  return box.decoration as BoxDecoration;
}

void main() {
  testWidgets('the floating variant paints what the floating style paints', (tester) async {
    await tester.pumpWidget(
      _host(
        // ignore: deprecated_member_use_from_same_package
        const DotsIconButton(icon: DotsIconData.pencil, variant: DotsIconButtonVariant.floating),
      ),
    );
    final viaVariant = _circle(tester);

    await tester.pumpWidget(
      _host(const DotsIconButton(icon: DotsIconData.pencil, style: DotsIconButtonStyle.floating)),
    );
    final viaStyle = _circle(tester);

    expect(viaVariant.border, isNotNull);
    expect(viaVariant.border, viaStyle.border);
    expect(viaVariant.color, viaStyle.color);
  });
}
