import 'dart:typed_data';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// 1x1 transparent PNG so the thumbnails resolve without hitting the network.
final Uint8List _transparentPng = Uint8List.fromList(const [
  0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, 0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, //
  0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01, 0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, //
  0x89, 0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, 0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, //
  0x05, 0x00, 0x01, 0x0D, 0x0A, 0x2D, 0xB4, 0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, 0xAE, //
  0x42, 0x60, 0x82,
]);

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(
    body: Center(
      child: SizedBox(width: 360, child: child),
    ),
  ),
);

void main() {
  final frames = [for (var i = 0; i < 5; i++) MemoryImage(_transparentPng)];

  testWidgets('renders thumbnails from the given frames', (tester) async {
    await tester.pumpWidget(
      _host(
        DotsFrameCarousel(
          frames: frames,
          selectedIndex: 0,
          onSelectedIndexChanged: (_) {},
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(DotsFrameCarousel), findsOneWidget);
    expect(find.byType(Image), findsWidgets);
  });

  testWidgets('reports the tapped thumbnail once it snaps to center', (tester) async {
    final reported = <int>[];

    await tester.pumpWidget(
      _host(
        DotsFrameCarousel(
          frames: frames,
          selectedIndex: 0,
          onSelectedIndexChanged: reported.add,
        ),
      ),
    );
    await tester.pump();

    await tester.tap(find.byType(Image).at(3));
    await tester.pumpAndSettle();

    expect(reported.isNotEmpty, isTrue);
    expect(reported.last, 3);
  });

  testWidgets('does not fire the callback on initial build', (tester) async {
    final reported = <int>[];

    await tester.pumpWidget(
      _host(
        DotsFrameCarousel(
          frames: frames,
          selectedIndex: 2,
          onSelectedIndexChanged: reported.add,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(reported, isEmpty);
  });
}
