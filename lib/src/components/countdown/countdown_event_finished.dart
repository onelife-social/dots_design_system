import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum CountdownEventFinishedVariant {
  small,
  big;

  bool get isSmall => this == CountdownEventFinishedVariant.small;
  bool get isBig => this == CountdownEventFinishedVariant.big;
}

/// A widget that displays a message indicating that a countdown event has finished.
/// It can be displayed in two variants: small and big.
/// The small variant is a compact version that shows the years, months, and days
/// along with an icon. The big variant is a more detailed version that includes a title
/// and larger text for the years, months, and days.
/// The widget is styled with a background color and rounded corners.
/// It uses the DotsDecoratedBox widget to apply the styles and decorations.

class CountdownEventFinished extends StatelessWidget {
  /// The variant of the countdown event finished widget.
  final CountdownEventFinishedVariant variant;

  /// The title to be displayed in the big variant.
  final String? title;

  /// The icon to be displayed in the small variant.
  final DotsIconData? icon;

  /// The number of years, months, and days to be displayed.
  final String years;

  /// The number of months to be displayed.
  final String months;

  /// The number of days to be displayed.
  final String days;

  /// The labels for years, months, and days.
  final String yearsLabel;

  /// The label for months.
  final String monthsLabel;

  /// The label for days.
  final String daysLabel;

  /// The conjunction text to be used between months and days.
  final String conjunctionText;

  const CountdownEventFinished({
    super.key,
    required this.variant,
    required this.years,
    required this.months,
    required this.days,
    required this.yearsLabel,
    required this.monthsLabel,
    required this.daysLabel,
    required this.conjunctionText,
    this.title,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final decoration = BoxDecoration(
      color: theme.colors.bgContainerSecondaryOnBackground,
      borderRadius: DotsBorderRadius.r24,
    );

    final Widget child = variant.isSmall
        ? _CountdownEventFinishedSmallBody(
            years: years,
            months: months,
            days: days,
            yearsLabel: yearsLabel,
            monthsLabel: monthsLabel,
            daysLabel: daysLabel,
            conjunctionText: conjunctionText,
            icon: icon ?? DotsIconData.weddingRings,
          )
        : _CountdownEventFinishedBigBody(
            title: title ?? '',
            years: years,
            months: months,
            days: days,
            yearsLabel: yearsLabel,
            monthsLabel: monthsLabel,
            daysLabel: daysLabel,
            conjunctionText: conjunctionText,
          );

    return DotsDecoratedBox(
      styleType: theme.styles.blur50,
      decoration: decoration,
      child: DotsDecoratedBox(
        styleType: theme.styles.toastShadow,
        decoration: decoration,
        child: DotsDecoratedBox(
          styleType: theme.styles.squircle24,
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}

class _CountdownEventFinishedSmallBody extends StatelessWidget {
  final String years;
  final String months;
  final String days;
  final String yearsLabel;
  final String monthsLabel;
  final String daysLabel;
  final String conjunctionText;
  final DotsIconData icon;

  const _CountdownEventFinishedSmallBody({
    required this.years,
    required this.months,
    required this.days,
    required this.yearsLabel,
    required this.monthsLabel,
    required this.daysLabel,
    required this.conjunctionText,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: SizedBox(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotsIcon(iconData: icon, size: 16, color: textColor),
            const SizedBox(width: 2),
            Text(
              '$years $yearsLabel $months $monthsLabel $conjunctionText $days $daysLabel'.trim(),
              style: theme.typo.main.labelDefaultBold.copyWith(color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

class _CountdownEventFinishedBigBody extends StatelessWidget {
  final String title;
  final String years;
  final String months;
  final String days;
  final String yearsLabel;
  final String monthsLabel;
  final String daysLabel;
  final String conjunctionText;

  const _CountdownEventFinishedBigBody({
    required this.title,
    required this.years,
    required this.months,
    required this.days,
    required this.yearsLabel,
    required this.monthsLabel,
    required this.daysLabel,
    required this.conjunctionText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;

    return Container(
      width: 169,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 22),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 2,
        children: [
          Center(
            child: Text(
              title,
              style: theme.typo.main.labelDefaultBold.copyWith(color: textColor),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 10,
            children: [
              _CountdownEventFinishedBigItem(item: years, itemLabel: yearsLabel),
              _CountdownEventFinishedBigItem(item: months, itemLabel: monthsLabel),
              _CountdownEventFinishedBigItem(item: days, itemLabel: daysLabel),
            ],
          )
        ],
      ),
    );
  }
}

class _CountdownEventFinishedBigItem extends StatelessWidget {
  final String item;
  final String itemLabel;
  const _CountdownEventFinishedBigItem({required this.item, required this.itemLabel});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;
    return Flexible(
      child: Column(
        children: [
          Text(
            item,
            style: theme.typo.main.titleH4.copyWith(
              color: textColor,
            ),
          ),
          Text(
            itemLabel,
            style: theme.typo.main.labelSmallMedium.copyWith(
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
