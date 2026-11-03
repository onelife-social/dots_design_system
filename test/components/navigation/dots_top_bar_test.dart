import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(
    body: Align(alignment: Alignment.topCenter, child: child),
  ),
);

final _gradient = find.byWidgetPredicate(
  (widget) =>
      widget is DecoratedBox &&
      widget.decoration is BoxDecoration &&
      (widget.decoration as BoxDecoration).gradient != null,
);

void main() {
  testWidgets('showGradient with hideBackground paints the gradient 18 px taller than the bar', (tester) async {
    const bar = DotsTopBar.title(title: 'Elige qué crear', hideBackground: true, showGradient: true);
    await tester.pumpWidget(_host(bar));

    expect(_gradient, findsOneWidget);
    expect(tester.getSize(_gradient).height, bar.preferredSize.height + DotsTopBar.gradientOverflow);
    expect(tester.getSize(find.byType(DotsTopBar)).height, bar.preferredSize.height);
    expect(tester.getTopLeft(_gradient), tester.getTopLeft(find.byType(DotsTopBar)));
    final ignorePointer = find.ancestor(
      of: _gradient,
      matching: find.descendant(of: find.byType(DotsTopBar), matching: find.byType(IgnorePointer)),
    );
    expect(tester.widget<IgnorePointer>(ignorePointer).ignoring, isTrue);
    final stack = tester.widget<Stack>(
      find.descendant(of: find.byType(DotsTopBar), matching: find.byType(Stack)).first,
    );
    expect(stack.clipBehavior, Clip.none);
    expect(stack.fit, StackFit.passthrough);
    expect(stack.children.first, isA<Positioned>(), reason: 'the gradient paints behind the bar');

    final gradient = (tester.widget<DecoratedBox>(_gradient).decoration as BoxDecoration).gradient as LinearGradient;
    final colors = dotsThemeDataLight.extension<DotsTheme>()!.colors;
    expect(gradient.begin, Alignment.topCenter);
    expect(gradient.end, Alignment.bottomCenter);
    expect(gradient.stops, [0.22, 1]);
    expect(gradient.colors, [colors.bgBase.dotsWithOpacity(0.95), colors.bgBaseGradientStart]);
  });

  testWidgets('toggling showGradient, hideBackground or color keeps the state of the bar content', (tester) async {
    DotsTopBar bar({bool hideBackground = true, bool showGradient = false, Color? color}) => DotsTopBar.widget(
      hideBackground: hideBackground,
      showGradient: showGradient,
      color: color,
      child: const _Content(),
    );

    await tester.pumpWidget(_host(bar()));
    final state = tester.state(find.byType(_Content));
    for (final (description, next) in [
      ('showGradient on', bar(showGradient: true)),
      ('showGradient off', bar()),
      ('background on', bar(hideBackground: false)),
      ('background off', bar()),
      ('color on', bar(color: Colors.white)),
      ('color off', bar()),
    ]) {
      await tester.pumpWidget(_host(next));
      expect(tester.state(find.byType(_Content)), same(state), reason: description);
    }
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

class _Content extends StatefulWidget {
  const _Content();

  @override
  State<_Content> createState() => _ContentState();
}

class _ContentState extends State<_Content> {
  @override
  Widget build(BuildContext context) => const SizedBox(width: 10, height: 10);
}
