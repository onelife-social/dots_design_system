import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BadgeTag extends StatelessWidget {
  const BadgeTag({
    super.key,
    this.child,
    required this.tag,
    this.size,
  });

  /// The main content
  final Widget? child;

  /// Text to display on the tag .
  /// If null, nothing is displayed.
  final String tag;

  /// Optional distance from the top right corner
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (child == null) {
      return _BadgeBody(theme: theme, tag: tag);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child!,
        Positioned(
          right: size?.width ?? -5.0,
          top: size?.height ?? -5.0,
          child: _BadgeBody(theme: theme, tag: tag),
        ),
      ],
    );
  }
}

class _BadgeBody extends StatelessWidget {
  const _BadgeBody({
    required this.theme,
    required this.tag,
  });

  final DotsTheme theme;
  final String tag;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 18,
        minHeight: 18,
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
        child: tag.isEmpty
            ? SizedBox.shrink()
            : Text(
                tag,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: theme.typo.main.labelSmallMedium.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
              ),
      ),
    );
  }
}
