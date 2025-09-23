import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum CountdownEventFinishedVariant {
  small,
  big;

  bool get isSmall => this == CountdownEventFinishedVariant.small;
  bool get isBig => this == CountdownEventFinishedVariant.big;
}

class CountdownEventFinished extends StatelessWidget {
  final CountdownEventFinishedVariant variant;
  final String? title;
  final DotsIconData? icon;
  final String years;
  final String months;
  final String days;
  final String yearsLabel;
  final String monthsLabel;
  final String daysLabel;

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
      styleType: theme.styles.toastShadow,
      decoration: decoration,
      child: SizedBox(
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

    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12),
      child: SizedBox(
        height: 36,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            DotsIcon(iconData: icon, size: 16, color: theme.colors.labelAlwaysWhite),
            const SizedBox(width: 2),
            Text(
              '$years $yearsLabel $months $monthsLabel $conjunctionText $days $daysLabel',
              style: theme.typo.main.labelDefaultBold.copyWith(
                color: theme.colors.labelAlwaysWhite,
              ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 25, right: 25),
      child: SizedBox(
        height: 80,
        child: IntrinsicWidth(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 2,
            children: [
              Text(
                title,
                style: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        years,
                        style: theme.typo.main.titleH4.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                      Text(
                        yearsLabel,
                        style: theme.typo.main.labelSmallMedium.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        months,
                        style: theme.typo.main.titleH4.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                      Text(
                        monthsLabel,
                        style: theme.typo.main.labelSmallMedium.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 10),
                  Column(
                    children: [
                      Text(
                        days.toString(),
                        style: theme.typo.main.titleH4.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                      Text(
                        daysLabel,
                        style: theme.typo.main.labelSmallMedium.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
