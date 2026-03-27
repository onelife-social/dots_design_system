import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  /// Label shown on the left side of the row.
  final String feature;

  /// Value shown on the right side of the row.
  final String value;

  /// Icon used by the default constructor.
  final DotsIconData? icon;

  /// Custom leading widget used by the variant `FeatureItem.image`.
  final Widget? image;

  const FeatureItem({
    super.key,
    required this.feature,
    required this.value,
    required DotsIconData this.icon,
  }) : image = null;

  const FeatureItem.image({
    super.key,
    required this.feature,
    required this.value,
    required Widget this.image,
  }) : icon = null;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      spacing: 8,
      children: [
        _Leading(icon: icon, iconColor: theme.colors.textQuarternary, image: image),
        Expanded(
          flex: 6,
          child: Text(
            feature,
            style: theme.typo.main.bodyDefaultRegular.copyWith(
              color: theme.colors.textTertiary,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: theme.colors.textSecondary,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}

class _Leading extends StatelessWidget {
  final DotsIconData? icon;
  final Color iconColor;
  final Widget? image;

  const _Leading({required this.icon, required this.iconColor, required this.image});

  @override
  Widget build(BuildContext context) {
    if (image != null) {
      return SizedBox.square(
        dimension: 24,
        child: image!,
      );
    }

    return DotsIcon(iconData: icon!, size: 16, color: iconColor);
  }
}
