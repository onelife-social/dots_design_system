import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsDivider extends StatelessWidget {
  /// Optional custom width for the divider.
  ///
  /// Defaults to whole width.
  final double? width;

  const DotsDivider({
    super.key,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Center(
      child: Opacity(
        opacity: 0.60,
        child: Container(
          width: width ?? double.infinity,
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
      ),
    );
  }
}
