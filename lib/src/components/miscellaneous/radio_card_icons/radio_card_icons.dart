import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RadioCardIconsVariant {
  /// Selector variant using a radio button
  selector,

  /// Toggle variant using a toggle switch
  toggle;

  bool get isSelector => this == RadioCardIconsVariant.selector;
  bool get isToggle => this == RadioCardIconsVariant.toggle;
}

/// A card widget with title/details lines and a selectable control (radio or toggle)
class RadioCardIcons extends StatelessWidget {
  /// Optional leading icon for the title line
  final DotsIconData? titleIcon;

  /// Main title text
  final String title;

  /// Optional icon for the first details line
  final DotsIconData? detailsIcon1;

  /// First details line text
  final String details1;

  /// Optional icon for the second details line
  final DotsIconData? detailsIcon2;

  /// Optional second details line text
  final String? details2;

  /// Tap callback when the card is pressed
  final Function() onTap;

  /// Variant defining which control to show (radio or toggle)
  final RadioCardIconsVariant variant;

  /// Selection state of the control
  final bool isSelected;

  const RadioCardIcons({
    super.key,
    this.titleIcon,
    required this.title,
    this.detailsIcon1,
    required this.details1,
    this.detailsIcon2,
    this.details2,
    required this.onTap,
    required this.variant,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;
    final bool showBorder = isSelected && variant.isSelector;

    final Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 16,
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              _Line(
                icon: titleIcon,
                text: title,
                style: theme.typo.main.bodyDefaultBold,
                iconColor: theme.colors.textTertiary,
              ),
              _Line(
                icon: detailsIcon1,
                text: details1,
                style: theme.typo.main.labelDefaultRegular.copyWith(
                  color: theme.colors.textTertiary,
                ),
                iconColor: theme.colors.textTertiary,
              ),
              if (details2 != null && details2!.isNotEmpty) ...[
                _Line(
                  icon: detailsIcon2,
                  text: details2!,
                  style: theme.typo.main.labelDefaultRegular.copyWith(
                    color: theme.colors.textTertiary,
                  ),
                  iconColor: theme.colors.textTertiary,
                ),
              ],
            ],
          ),
        ),
        variant.isSelector
            ? DotsRadioButton(isSelected: isSelected)
            : DotsToggle(isSelected: isSelected, onChanged: (_) => onTap()),
      ],
    );

    return InkWell(
      borderRadius: DotsBorderRadius.r24,
      onTap: onTap,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: showBorder
                ? BorderSide(
                    color: theme.colors.labelHighlight,
                    width: 1.5,
                  )
                : BorderSide.none,
            borderRadius: DotsBorderRadius.r26,
          ),
        ),
        padding: EdgeInsets.all(1.5),
        child: DotsMainContainer(
          forceHeight: false,
          backgroundColor: theme.colors.bgContainerSecondaryOnBackground,
          radius: 24,
          padding: 16,
          child: content,
        ),
      ),
    );
  }
}

class _Line extends StatelessWidget {
  final DotsIconData? icon;
  final String text;
  final TextStyle style;
  final Color iconColor;

  const _Line({
    required this.icon,
    required this.text,
    required this.style,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        if (icon != null) ...[
          DotsIcon(iconData: icon!, size: 16, color: iconColor),
        ],
        Flexible(
          child: Text(
            text,
            style: style,
            softWrap: true,
          ),
        ),
      ],
    );
  }
}
