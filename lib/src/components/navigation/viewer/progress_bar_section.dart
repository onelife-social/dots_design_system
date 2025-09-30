import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum ProgressBarSize {
  medium(
    padding: EdgeInsets.only(top: 8, left: 16, right: 16),
  ),
  small(
    padding: EdgeInsets.only(top: 6, left: 16, right: 16),
  );

  final EdgeInsetsGeometry padding;

  const ProgressBarSize({required this.padding});
}

enum ProgressBarVariant {
  /// No blur nor background.
  plain,

  /// Blurred container with no solid background fill.
  blur,

  /// Blurred container with a solid background fill color.
  blurWithBackground,
}

class ProgressBarSection extends StatelessWidget {
  /// Visual variant.
  final ProgressBarVariant variant;

  /// Size configuration for the progress bar.
  final ProgressBarSize size;

  /// Text displayed on the left side.
  final String leftText;

  /// Text displayed on the right side.
  final String rightText;

  /// Progress value between 0.0 and 1.0.
  final double progress;

  /// Callback when the section is tapped.
  final VoidCallback? onTap;

  const ProgressBarSection({
    super.key,
    this.variant = ProgressBarVariant.plain,
    this.size = ProgressBarSize.medium,
    required this.leftText,
    required this.rightText,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        _TextProgress(
          size: size,
          leftText: leftText,
          rightText: rightText,
          showChevron: onTap != null,
        ),
        _BarProgress(progress: progress),
      ],
    );

    Widget wrapped;
    switch (variant) {
      case ProgressBarVariant.plain:
        wrapped = content;
        break;

      case ProgressBarVariant.blur:
        wrapped = DotsDecoratedBox(
          styleType: theme.styles.blur50,
          decoration: BoxDecoration(color: theme.colors.bgContainerPrimary),
          child: content,
        );
        break;

      case ProgressBarVariant.blurWithBackground:
        wrapped = DotsDecoratedBox(
          styleType: theme.styles.blur50,
          decoration: BoxDecoration(color: theme.colors.bgContainerPrimary),
          child: Container(
            color: theme.colors.bgContainerPrimary,
            child: content,
          ),
        );
        break;
    }

    return GestureDetector(
      onTap: onTap,
      child: wrapped,
    );
  }
}

class _TextProgress extends StatelessWidget {
  final ProgressBarSize size;
  final String leftText;
  final String rightText;
  final bool showChevron;

  const _TextProgress({
    required this.size,
    required this.leftText,
    required this.rightText,
    required this.showChevron,
  });

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;

    return Padding(
      padding: size.padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: theme.typo.main.labelDefaultMedium.copyWith(
              color: theme.colors.textSecondary,
            ),
          ),
          Row(
            children: [
              Text(
                rightText,
                style: theme.typo.main.labelDefaultRegular.copyWith(
                  color: theme.colors.textSecondary,
                ),
              ),
              if (showChevron) ...[
                SizedBox(width: 6),
                DotsIcon(
                  iconData: DotsIconData.chevronRight,
                  size: 14,
                  color: theme.colors.textSecondary,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _BarProgress extends StatelessWidget {
  final double progress;

  const _BarProgress({required this.progress});

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxLength = constraints.maxWidth;
        final double currentProgress = maxLength * progress;

        return Stack(
          children: [
            Container(
              width: maxLength,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colors.labelSecondary,
                borderRadius: DotsBorderRadius.r12,
              ),
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 100),
              width: currentProgress,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colors.labelHighlight,
                borderRadius: progress == 1.0
                    ? BorderRadius.zero
                    : const BorderRadius.only(
                        topRight: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
              ),
            ),
          ],
        );
      },
    );
  }
}
