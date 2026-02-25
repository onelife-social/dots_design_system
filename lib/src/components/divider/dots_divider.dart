import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsDivider extends StatelessWidget {
  /// Optional custom width for the divider.
  ///
  /// Defaults to full available width.
  final double? width;

  const DotsDivider({
    super.key,
    this.width = double.infinity,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Opacity(
      opacity: 0.60,
      child: Container(
        width: width,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r1000,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                color: theme.colors.labelSecondary,
              ),
            ),
            Container(
              width: double.infinity,
              height: 1,
              decoration: BoxDecoration(
                color: theme.colors.bgStrong,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
