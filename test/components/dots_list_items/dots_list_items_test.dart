import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

const String _label = 'Marta & Luis';
const String _subtitle = '20 de junio de 2027 · 90 invitados';
const String _longSubtitle =
    'Sábado, 20 de junio de 2027 · 90 invitados · Finca El Olivar, Toledo · Ceremonia civil';

Widget _host(Widget child) => MaterialApp(
  theme: dotsThemeDataLight,
  home: Scaffold(
    body: Center(child: SizedBox(width: 300, child: child)),
  ),
);

final Finder _chevron = find.byWidgetPredicate(
  (widget) => widget is DotsIcon && widget.iconData == DotsIconData.chevronRight,
);

void main() {
  testWidgets('a subtitle adds a second line without growing the row', (tester) async {
    await tester.pumpWidget(_host(const DotsListsItem(label: _label)));
    final double singleLineHeight = tester.getSize(find.byType(DotsListsItem)).height;

    await tester.pumpWidget(_host(const DotsListsItem(label: _label, subtitle: _subtitle)));

    expect(find.text(_label), findsOneWidget);
    expect(find.text(_subtitle), findsOneWidget);
    expect(tester.getSize(find.byType(DotsListsItem)).height, singleLineHeight);
    expect(
      tester.getTopLeft(find.text(_subtitle)).dy,
      greaterThan(tester.getBottomLeft(find.text(_label)).dy),
    );
  });

  testWidgets('a long subtitle stays on one line with an ellipsis', (tester) async {
    await tester.pumpWidget(_host(const DotsListsItem(label: _label, subtitle: _longSubtitle)));

    final Text text = tester.widget<Text>(find.text(_longSubtitle));
    expect(text.maxLines, 1);
    expect(text.overflow, TextOverflow.ellipsis);
    expect(
      tester.renderObject<RenderParagraph>(find.text(_longSubtitle)).didExceedMaxLines,
      isTrue,
    );
  });

  testWidgets('the chevron variant ends the row with a 16px tertiary chevron', (tester) async {
    await tester.pumpWidget(
      _host(
        const DotsListsItem(
          variant: DotsListsItemVariant.chevron,
          label: _label,
          subtitle: _subtitle,
        ),
      ),
    );

    final DotsIcon icon = tester.widget<DotsIcon>(_chevron);
    final DotsTheme theme = tester.element(_chevron).dotsTheme;
    expect(icon.size, 16);
    expect(icon.color, theme.colors.textTertiary);
    expect(
      tester.getTopLeft(_chevron).dx,
      greaterThan(tester.getTopRight(find.text(_label)).dx),
    );
  });

  testWidgets('other variants have no chevron', (tester) async {
    await tester.pumpWidget(_host(const DotsListsItem(label: _label, subtitle: _subtitle)));

    expect(_chevron, findsNothing);
  });

  testWidgets('the divider variant ignores the subtitle', (tester) async {
    await tester.pumpWidget(
      _host(
        const DotsListsItem(
          variant: DotsListsItemVariant.divider,
          label: _label,
          subtitle: _subtitle,
        ),
      ),
    );

    expect(find.text(_label), findsOneWidget);
    expect(find.text(_subtitle), findsNothing);
  });
}
