import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

import '../icons/icons_lib.dart';

enum CountdownEventFinishedVariant {
  small,
  big;

  bool get isSmall => this == CountdownEventFinishedVariant.small;
  bool get isBig => this == CountdownEventFinishedVariant.big;
}

class CountdownEventFinished extends StatelessWidget {
  final CountdownEventFinishedVariant variant;
  final String title;
  final DotsIconData icon;
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
    required this.title,
    required this.icon,
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
    final decoration = BoxDecoration(
      color: context.dotsTheme.colors.bgContainerSecondaryOnBackground,
      borderRadius: BorderRadius.circular(24),
    );

    return DotsDecoratedBox(
      styleType: context.dotsTheme.styles.toastShadow,
      decoration: decoration,
      child: SizedBox(
        child: DotsDecoratedBox(
          styleType: context.dotsTheme.styles.squircle24,
          decoration: decoration,
          child: Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, left: 12, right: 12),
            child: SizedBox(
              height: 80,
              width: 172,
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
        ),
      ),
    );
  }
}
