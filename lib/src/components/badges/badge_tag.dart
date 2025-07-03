import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BadgeTag extends StatelessWidget {
  const BadgeTag({
    super.key,
    required this.child,
    required this.tag,
    this.size,
  });

  /// The main content
  final Widget child;

  /// Text to display on the tag .
  /// If null, nothing is displayed.
  final String tag;

  /// Optional distance from the top right corner
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          right: size?.width ?? -5.0,
          top: size?.height ?? -5.0,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 6,
              minHeight: 6,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: theme.colors.labelDestructive,
              shape: RoundedRectangleBorder(
                borderRadius: DotsBorderRadius.r22,
              ),
            ),
            alignment: Alignment.center,
            child: Center(
              child: Text(
                tag,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: theme.typo.main.labelSmallMedium.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
