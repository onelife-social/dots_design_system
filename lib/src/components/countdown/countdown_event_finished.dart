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
  final int years;
  final int months;
  final int days;
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

    return DotsDecoratedBox(
      styleType: theme.styles.squircle24,
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondary,
      ),
      child: SizedBox(
        height: 80,
        width: 172,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title,
                style: theme.typo.main.labelDefaultBold.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    Column(
                      children: [
                        Text(
                          years.toString(),
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
                    Column(
                      children: [
                        Text(
                          months.toString(),
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
