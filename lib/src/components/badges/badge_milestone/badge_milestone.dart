import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'badge_milestone_theme.dart';

class BadgeMilestone extends StatelessWidget {
  const BadgeMilestone({
    super.key,
    required this.content,
    this.variant = BadgeMilestoneVariant.main,
  });

  /// The text to display on the badge milestone.
  final String content;

  /// The visual variant of the badge milestone.
  ///
  /// Defaults to [BadgeMilestoneVariant.main].
  final BadgeMilestoneVariant variant;

  static const double _height = 36;
  static const double _borderRadius = 22;
  static const EdgeInsets _padding = EdgeInsets.symmetric(horizontal: 12);

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final badgeMilestoneTheme = getBadgeMilestoneThemeByVariant(theme, variant);
    final borderRadius = BorderRadius.circular(_borderRadius);

    Widget badge = Container(
      decoration: BoxDecoration(
        color: badgeMilestoneTheme.backgroundColor,
        borderRadius: borderRadius,
        border: badgeMilestoneTheme.borderColor != null
            ? Border.all(
                color: badgeMilestoneTheme.borderColor!,
                width: 1,
              )
            : null,
      ),
      height: _height,
      padding: _padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              content,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: badgeMilestoneTheme.foregroundColor,
              ),
            ),
          ),
        ],
      ),
    );

    if (badgeMilestoneTheme.blur) {
      badge = ClipRRect(
        borderRadius: borderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
          child: badge,
        ),
      );
    }

    return badge;
  }
}
