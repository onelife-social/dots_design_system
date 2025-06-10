import 'package:flutter/material.dart';
import 'package:dots_design_system/src/theme/dots_theme.dart';

class DotsIconTag extends StatelessWidget {
  const DotsIconTag({
    super.key,
    required this.child,
    required this.tag,
  });

  /// The main content
  final Widget child;

  /// Text to display on the tag .
  /// If null, nothing is displayed.
  final String tag;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          bottom: 9,
          left: 9,
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 10,
              minHeight: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: theme.colors.labelDestructive,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            alignment: Alignment.center,
            child: Center(
              child: Text(
                tag,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: theme.colors.labelAlwaysWhite,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
