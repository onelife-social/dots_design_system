import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const String _hint = 'Cuántos seréis aprox.';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(
    body: Center(child: SizedBox(width: 300, child: child)),
  ),
);

DotsTextField _field({
  DotsTextFieldContainer container = DotsTextFieldContainer.defaultContainer,
  DotsTextFieldTextSize textSize = DotsTextFieldTextSize.bodyDefault,
  TextStyle? textStyle,
}) {
  final controller = TextEditingController();
  final focusNode = FocusNode();
  addTearDown(controller.dispose);
  addTearDown(focusNode.dispose);
  return DotsTextField(
    controller: controller,
    focusNode: focusNode,
    hintText: _hint,
    container: container,
    textSize: textSize,
    textStyle: textStyle,
  );
}

TextStyle _inputStyle(WidgetTester tester) =>
    tester.widget<TextField>(find.byType(TextField)).style!;

void main() {
  testWidgets('a field without container or textSize stays 44 px with 14/500 text', (tester) async {
    final controller = TextEditingController();
    final focusNode = FocusNode();
    addTearDown(controller.dispose);
    addTearDown(focusNode.dispose);
    await tester.pumpWidget(
      _host(DotsTextField(controller: controller, focusNode: focusNode, hintText: _hint)),
    );

    expect(tester.getSize(find.byType(DotsTextField)).height, 44);
    expect(_inputStyle(tester).fontSize, 14);
    expect(_inputStyle(tester).fontWeight, FontWeight.w500);
  });

  testWidgets('the big container makes the field 52 px high', (tester) async {
    await tester.pumpWidget(_host(_field(container: DotsTextFieldContainer.big)));

    expect(tester.getSize(find.byType(DotsTextField)).height, 52);
  });

  testWidgets('textSize sets the size and weight of the input text', (tester) async {
    const expected = {
      DotsTextFieldTextSize.bodyDefault: (14.0, FontWeight.w500),
      DotsTextFieldTextSize.bodyLarge: (16.0, FontWeight.w500),
      DotsTextFieldTextSize.titleH6: (18.0, FontWeight.w600),
      DotsTextFieldTextSize.titleH5: (20.0, FontWeight.w700),
    };

    for (final MapEntry(key: textSize, value: (fontSize, fontWeight)) in expected.entries) {
      await tester.pumpWidget(_host(_field(textSize: textSize)));

      expect(_inputStyle(tester).fontSize, fontSize, reason: textSize.name);
      expect(_inputStyle(tester).fontWeight, fontWeight, reason: textSize.name);
    }
  });

  testWidgets('the hint takes the size of textSize', (tester) async {
    await tester.pumpWidget(
      _host(
        _field(container: DotsTextFieldContainer.big, textSize: DotsTextFieldTextSize.titleH6),
      ),
    );

    expect(tester.widget<Text>(find.text(_hint)).style?.fontSize, 18);
  });

  testWidgets('textStyle replaces the style of textSize', (tester) async {
    await tester.pumpWidget(
      _host(
        _field(
          textSize: DotsTextFieldTextSize.titleH5,
          textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
        ),
      ),
    );

    expect(_inputStyle(tester).fontSize, 12);
    expect(_inputStyle(tester).fontWeight, FontWeight.w400);
  });
}
