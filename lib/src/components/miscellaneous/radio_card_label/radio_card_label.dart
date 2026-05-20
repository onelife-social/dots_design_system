import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RadioCardLabelVariant {
  small,
  medium;

  bool get isSmall => this == RadioCardLabelVariant.small;
  bool get isMedium => this == RadioCardLabelVariant.medium;
}

class RadioCardLabel extends StatelessWidget {
  const RadioCardLabel({
    super.key,
    required this.title,
    this.details,
    required this.isSelected,
    required this.onTap,
    this.variant = RadioCardLabelVariant.small,
    this.value,
    this.greenTextValue = false,
    this.valueSuffix,
    this.valueSuffixStyle,
  });

  final String title;
  final String? details;
  final bool isSelected;
  final Function() onTap;
  final RadioCardLabelVariant variant;
  final String? value;
  final bool greenTextValue;
  final String? valueSuffix;
  final TextStyle? valueSuffixStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: isSelected
              ? BorderSide(
                  color: theme.colors.labelHighlight,
                  width: 1.5,
                )
              : BorderSide(
                  color: theme.colors.transparent,
                  width: 1.5,
                ),
          borderRadius: DotsBorderRadius.r26,
        ),
      ),
      padding: EdgeInsets.all(1.5),
      child: Material(
        shape: RoundedRectangleBorder(
          borderRadius: DotsBorderRadius.r24,
        ),
        color: theme.colors.bgContainerSecondaryOnBackground,
        child: InkWell(
          borderRadius: DotsBorderRadius.r24,
          onTap: onTap,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: DotsBorderRadius.r24,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 16,
                  children: [
                    DotsRadioButton(isSelected: isSelected),
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 4,
                        children: [
                          Text(
                            title,
                            style: variant.isSmall
                                ? theme.typo.main.bodyDefaultBold.copyWith(
                                    color: theme.colors.textPrimary,
                                  )
                                : theme.typo.main.bodyLargeMedium.copyWith(
                                    color: theme.colors.textPrimary,
                                  ),
                          ),
                          if (details?.isNotEmpty ?? false)
                            Text(
                              details ?? '',
                              style: theme.typo.main.bodyDefaultRegular.copyWith(
                                color: theme.colors.textTertiary,
                              ),
                            ),
                        ],
                      ),
                    ),
                    if (value != null) ...[
                      SizedBox(width: 16),
                      Text(
                        value!,
                        style: theme.typo.main.bodyLargeMedium.copyWith(
                          color: greenTextValue
                              ? theme.colors.labelActive
                              : theme.colors.textPrimary,
                        ),
                      ),
                    ],
                    if (valueSuffix != null && valueSuffix!.isNotEmpty)
                      Text(
                        valueSuffix!,
                        style:
                            valueSuffixStyle ??
                            theme.typo.main.bodyDefaultMedium.copyWith(
                              color: theme.colors.textSecondary,
                            ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
