import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/common/dots_shader_mask.dart';
import 'package:flutter/material.dart';

import 'badge_label_theme.dart';

class BadgeLabel extends StatelessWidget {
  const BadgeLabel({
    super.key,
    required this.content,
    this.badgeIcon,
    this.size = BadgeLabelSize.medium,
    this.variant = BadgeLabelVariant.main,
  });

  /// The text to display on the badge label.
  final String content;

  /// The size of the badge label.
  ///
  /// Defaults to [BadgeLabelSize.medium].
  final BadgeLabelSize size;

  /// The visual variant of the badge label.
  ///
  /// Defaults to [BadgeLabelVariant.main].
  final BadgeLabelVariant variant;

  /// Optional icon to display alongside the text in the badge label.
  ///
  /// If provided, the icon will be displayed to the left of the text.
  /// Defaults to null (no icon).
  final DotsIconData? badgeIcon;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final badgeLabelTheme = getBadgeLabelThemeByTagVariant(theme, variant);
    final borderRadius = BorderRadius.circular(size.height);

    final foregroundColor = badgeLabelTheme.foregroundGradient == null
        ? badgeLabelTheme.foregroundColor
        : Colors.white;
    Widget badgeLabel = Material(
      color: badgeLabelTheme.backgroundColor ?? Colors.transparent,
      borderRadius: borderRadius,
      child: Container(
        decoration: BoxDecoration(borderRadius: borderRadius),
        height: size.height,
        padding: size.padding,
        child: DotsShaderMask(
          styleType: badgeLabelTheme.foregroundGradient,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (badgeIcon != null) ...[
                DotsIcon(
                  iconData: badgeIcon!, 
                  size: 16
                ),
                const SizedBox(width: 5),
              ],
              Flexible(
                child: Text(
                  content,
                  overflow: TextOverflow.ellipsis,
                  style: size
                      .getTextStyle(theme)
                      .copyWith(
                        color: foregroundColor,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (badgeLabelTheme.backgroundGradient != null) {
      badgeLabel = DotsDecoratedBox(
        styleType: badgeLabelTheme.backgroundGradient,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: badgeLabel,
      );
    }
    if (badgeLabelTheme.blur) {
      badgeLabel = DotsDecoratedBox(
        styleType: theme.styles.bgBlur,
        decoration: BoxDecoration(
          borderRadius: borderRadius,
        ),
        child: badgeLabel,
      );
    }

    // Apply optional border only if a color is provided.
    if (badgeLabelTheme.borderColor != null) {
      badgeLabel = Container(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: Border.all(color: badgeLabelTheme.borderColor!, width: 1),
        ),
        child: badgeLabel,
      );
    }

    return badgeLabel;
  }
}
