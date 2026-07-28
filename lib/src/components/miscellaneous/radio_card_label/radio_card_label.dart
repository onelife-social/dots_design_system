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
    this.valueStyle,
    this.greenTextValue = false,
    this.badgeText,
    this.badgeVariant = BadgeLabelVariant.green,
    this.valueDescription,
    this.valueDescriptionStyle,
    this.minHeight,
  });

  final String title;
  final String? details;
  final bool isSelected;
  final Function() onTap;
  final RadioCardLabelVariant variant;
  final String? value;
  final TextStyle? valueStyle;
  final bool greenTextValue;

  /// Optional badge rendered next to the title.
  ///
  /// When null or empty no badge is shown.
  final String? badgeText;

  /// Visual variant of the badge rendered next to the title.
  ///
  /// Defaults to [BadgeLabelVariant.green].
  final BadgeLabelVariant badgeVariant;

  /// Optional secondary text rendered under [value], struck through by default
  /// so it can convey the price before a discount.
  ///
  /// When null or empty nothing is shown. Ignored when [value] is null.
  final String? valueDescription;

  /// Overrides the default style of [valueDescription].
  final TextStyle? valueDescriptionStyle;

  /// Pins the card to a shared height so a list of cards keeps one size no
  /// matter how many of them carry [details] or [valueDescription].
  ///
  /// Setting it also switches the card to the tighter spacing and smaller
  /// [details] scale the design uses for fixed-height cards, so a title plus
  /// details lands on the height instead of overshooting it. The card still
  /// grows past it rather than overflowing when the content needs more room.
  final double? minHeight;

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
                constraints: BoxConstraints(minHeight: minHeight ?? 0),
                padding: minHeight == null
                    ? const EdgeInsets.all(16)
                    : const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                        spacing: minHeight == null ? 4 : 2,
                        children: [
                          _Title(
                            title: title,
                            variant: variant,
                            badgeText: badgeText,
                            badgeVariant: badgeVariant,
                          ),
                          if (details?.isNotEmpty ?? false)
                            Text(
                              details ?? '',
                              style:
                                  (minHeight == null
                                          ? theme.typo.main.bodyDefaultRegular
                                          : theme.typo.main.labelDefaultRegular)
                                      .copyWith(
                                        color: theme.colors.textTertiary,
                                      ),
                            ),
                        ],
                      ),
                    ),
                    if (value != null) ...[
                      SizedBox(width: 16),
                      _Value(
                        value: value!,
                        valueStyle: valueStyle,
                        greenTextValue: greenTextValue,
                        valueDescription: valueDescription,
                        valueDescriptionStyle: valueDescriptionStyle,
                      ),
                    ],
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

class _Title extends StatelessWidget {
  const _Title({
    required this.title,
    required this.variant,
    required this.badgeText,
    required this.badgeVariant,
  });

  final String title;
  final RadioCardLabelVariant variant;
  final String? badgeText;
  final BadgeLabelVariant badgeVariant;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final titleText = Text(
      title,
      style: variant.isSmall
          ? theme.typo.main.bodyDefaultBold.copyWith(
              color: theme.colors.textPrimary,
            )
          : theme.typo.main.bodyLargeMedium.copyWith(
              color: theme.colors.textPrimary,
            ),
    );

    if (badgeText?.isNotEmpty != true) {
      return titleText;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 8,
      children: [
        Flexible(child: titleText),
        BadgeLabel(
          content: badgeText!,
          size: BadgeLabelSize.small,
          variant: badgeVariant,
        ),
      ],
    );
  }
}

class _Value extends StatelessWidget {
  const _Value({
    required this.value,
    required this.valueStyle,
    required this.greenTextValue,
    required this.valueDescription,
    required this.valueDescriptionStyle,
  });

  final String value;
  final TextStyle? valueStyle;
  final bool greenTextValue;
  final String? valueDescription;
  final TextStyle? valueDescriptionStyle;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final valueText = Text(
      value,
      style:
          valueStyle ??
          theme.typo.main.bodyLargeMedium.copyWith(
            color: greenTextValue ? theme.colors.labelActive : theme.colors.textPrimary,
          ),
    );

    if (valueDescription?.isNotEmpty != true) {
      return valueText;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      spacing: 4,
      children: [
        valueText,
        Text(
          valueDescription!,
          style:
              valueDescriptionStyle ??
              theme.typo.main.labelSmallRegular.copyWith(
                color: theme.colors.textTertiary,
                decoration: TextDecoration.lineThrough,
                decorationColor: theme.colors.textTertiary,
              ),
        ),
      ],
    );
  }
}
