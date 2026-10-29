import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/gestures.dart';
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

TextEditingController _controller([String text = '']) {
  final controller = TextEditingController(text: text);
  addTearDown(controller.dispose);
  return controller;
}

FocusNode _focusNode() {
  final focusNode = FocusNode();
  addTearDown(focusNode.dispose);
  return focusNode;
}

Future<void> _focus(WidgetTester tester, FocusNode focusNode) async {
  focusNode.requestFocus();
  await tester.pump();
}

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

  testWidgets('autocorrect, suggestions, autofill and the action key reach the TextField', (
    tester,
  ) async {
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: _controller(),
          focusNode: _focusNode(),
          hintText: _hint,
          autocorrect: false,
          enableSuggestions: false,
          autofillHints: null,
          textInputAction: TextInputAction.search,
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.autocorrect, isFalse);
    expect(textField.enableSuggestions, isFalse);
    expect(textField.autofillHints, isNull);
    expect(textField.textInputAction, TextInputAction.search);
  });

  testWidgets('a field that sets none of them keeps the TextField defaults', (tester) async {
    await tester.pumpWidget(_host(_field()));

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.autocorrect, isTrue);
    expect(textField.enableSuggestions, isTrue);
    expect(textField.autofillHints, isEmpty);
    expect(textField.textInputAction, isNull);
  });

  testWidgets('semanticsLabel names the input, before the hint', (tester) async {
    final semantics = tester.ensureSemantics();
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: _controller(),
          focusNode: _focusNode(),
          hintText: _hint,
          semanticsLabel: 'Los novios',
        ),
      ),
    );

    expect(tester.getSemantics(find.byType(EditableText)).label, startsWith('Los novios'));
    semantics.dispose();
  });

  testWidgets('the clear button keeps its 16 px circle and takes taps over 44 × 44', (
    tester,
  ) async {
    final controller = _controller('Mark & Anna');
    final focusNode = _focusNode();
    await tester.pumpWidget(
      _host(DotsTextField(controller: controller, focusNode: focusNode, hintText: _hint)),
    );
    await _focus(tester, focusNode);

    final circle = tester.getRect(find.byType(DotsCloseButton));
    expect(circle.size, const Size(16, 16));
    expect(circle.right, tester.getRect(find.byType(DotsTextField)).right - 16);

    await tester.tapAt(circle.center - const Offset(30, 0));
    await tester.pump();
    expect(controller.text, 'Mark & Anna', reason: 'a tap 30 px away lands on the input');

    for (final corner in const [
      Offset(-21, -21),
      Offset(21, -21),
      Offset(-21, 21),
      Offset(21, 21),
    ]) {
      controller.text = 'Mark & Anna';
      await tester.pump();
      await tester.tapAt(circle.center + corner);
      await tester.pump();
      expect(controller.text, isEmpty, reason: 'corner $corner');
    }
  });

  testWidgets(
    'a mouse click on the clear area clears and keeps the focus',
    (tester) async {
      final controller = _controller('Mark & Anna');
      final focusNode = _focusNode();
      await tester.pumpWidget(
        _host(DotsTextField(controller: controller, focusNode: focusNode, hintText: _hint)),
      );
      await _focus(tester, focusNode);

      final circle = tester.getRect(find.byType(DotsCloseButton));
      await tester.tapAt(circle.center - const Offset(20, 0), kind: PointerDeviceKind.mouse);
      await tester.pump();

      expect(controller.text, isEmpty);
      expect(focusNode.hasFocus, isTrue);
    },
    variant: TargetPlatformVariant.desktop(),
  );

  testWidgets('without background the 44 px area grows leftwards from the edge of the field', (
    tester,
  ) async {
    final controller = _controller('Mark & Anna');
    final focusNode = _focusNode();
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: controller,
          focusNode: focusNode,
          hintText: _hint,
          background: false,
        ),
      ),
    );
    await _focus(tester, focusNode);

    final field = tester.getRect(find.byType(DotsTextField));
    final circle = tester.getRect(find.byType(DotsCloseButton));
    expect(circle.right, field.right);

    await tester.tapAt(Offset(field.right - 46, circle.center.dy));
    await tester.pump();
    expect(controller.text, 'Mark & Anna', reason: 'a tap 46 px from the edge lands on the input');

    await tester.tapAt(Offset(field.right - 43, circle.center.dy));
    await tester.pump();
    expect(controller.text, isEmpty);
  });

  testWidgets('clearSemanticsLabel names the clear button, and a screen-reader tap clears', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final controller = _controller('Mark & Anna');
    final focusNode = _focusNode();
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: controller,
          focusNode: focusNode,
          hintText: _hint,
          clearSemanticsLabel: 'Borrar el texto',
        ),
      ),
    );
    await _focus(tester, focusNode);

    expect(
      tester.getSemantics(find.byType(DotsCloseButton)),
      matchesSemantics(label: 'Borrar el texto', isButton: true, hasTapAction: true),
    );

    tester.semantics.tap(find.semantics.byLabel('Borrar el texto'));
    await tester.pump();
    expect(controller.text, isEmpty);
    semantics.dispose();
  });

  testWidgets('without clearSemanticsLabel the clear button has no name to fall back on', (
    tester,
  ) async {
    final semantics = tester.ensureSemantics();
    final focusNode = _focusNode();
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: _controller('Mark & Anna'),
          focusNode: focusNode,
          hintText: _hint,
        ),
      ),
    );
    await _focus(tester, focusNode);

    expect(
      tester.getSemantics(find.byType(DotsCloseButton)),
      matchesSemantics(label: '', isButton: true, hasTapAction: true),
    );
    semantics.dispose();
  });

  testWidgets('with alignCenter the text stays centred when the clear button appears', (
    tester,
  ) async {
    final focusNode = _focusNode();
    await tester.pumpWidget(
      _host(
        DotsTextField(
          controller: _controller('Mark & Anna'),
          focusNode: focusNode,
          hintText: _hint,
          alignCenter: true,
        ),
      ),
    );
    final unfocused = tester.getRect(find.byType(EditableText));

    await _focus(tester, focusNode);

    expect(find.byType(DotsCloseButton), findsOneWidget);
    expect(tester.getRect(find.byType(EditableText)), unfocused);
    expect(unfocused.center.dx, tester.getRect(find.byType(DotsTextField)).center.dx);
  });
}
