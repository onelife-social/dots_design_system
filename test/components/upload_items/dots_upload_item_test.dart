import 'dart:typed_data';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

/// 1x1 transparent PNG so the thumbnail resolves without hitting the network.
final Uint8List _transparentPng = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, //
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, //
  0x42, 0x60, 0x82, //
]);

const String _longProcessText =
    'No encontramos el archivo IMG_20260824_183045_vacaciones_en_la_playa.HEIC '
    'en este dispositivo. Vuelve a seleccionarlo para continuar la subida.';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(
    body: Center(child: SizedBox(width: 360, child: child)),
  ),
);

/// The error variant also paints a cloudFail glyph over the thumbnail, so the
/// status icon has to be matched by its own glyph and size, not by position.
final Finder _statusIcon = find.byWidgetPredicate(
  (widget) =>
      widget is DotsIcon && widget.iconData == DotsIconData.crossCircle && widget.size == 14,
);

Text _processText(WidgetTester tester) => tester.widget<Text>(find.text(_longProcessText));

RenderParagraph _paragraph(WidgetTester tester) =>
    tester.renderObject<RenderParagraph>(find.text(_longProcessText));

void main() {
  Widget uploadItem({int? processTextMaxLines = 1}) => DotsUploadItem(
    image: MemoryImage(_transparentPng),
    variant: UploadItemVariant.error,
    textDate: '24 ago 2026',
    processText: _longProcessText,
    processTextMaxLines: processTextMaxLines,
    btnText: 'Reintentar',
    btnOnTap: () {},
  );

  testWidgets('clips the process text to one line by default', (tester) async {
    await tester.pumpWidget(_host(uploadItem()));
    await tester.pump();

    final Text text = _processText(tester);
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(_paragraph(tester).didExceedMaxLines, isTrue);
  });

  testWidgets('renders the whole process text across lines when unbounded', (tester) async {
    await tester.pumpWidget(_host(uploadItem(processTextMaxLines: null)));
    await tester.pump();

    final Text text = _processText(tester);
    expect(text.maxLines, isNull);
    expect(text.overflow, isNot(TextOverflow.ellipsis));

    final RenderParagraph paragraph = _paragraph(tester);
    expect(paragraph.didExceedMaxLines, isFalse);
    expect(
      paragraph.size.height,
      greaterThan(paragraph.getMinIntrinsicHeight(double.infinity)),
      reason: 'the message should occupy more than a single line',
    );
  });

  testWidgets('keeps the status icon on the first line when the text wraps', (tester) async {
    await tester.pumpWidget(_host(uploadItem(processTextMaxLines: null)));
    await tester.pump();

    expect(_statusIcon, findsOneWidget);

    final double iconCenter = tester.getCenter(_statusIcon).dy;
    final Rect textRect = tester.getRect(find.text(_longProcessText));

    expect(iconCenter, lessThan(textRect.center.dy));
  });

  testWidgets('rejects a non-positive max lines', (tester) async {
    expect(() => uploadItem(processTextMaxLines: 0), throwsAssertionError);
  });
}
