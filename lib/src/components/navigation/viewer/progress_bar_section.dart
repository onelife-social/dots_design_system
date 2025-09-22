import 'package:dots_design_system/dots_design_system.dart';
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

class ProgressBarSection extends StatelessWidget {
  /// Callback when the section is tapped.
  final VoidCallback onTap;

  /// Size configuration for the progress bar.
  final ProgressBarSize size;

  /// Text displayed on the left side.
  final String leftText;

  /// Text displayed on the right side.
  final String rightText;

  /// Progress value between 0.0 and 1.0.
  final double progress;

  const ProgressBarSection({
    super.key,
    required this.onTap,
    required this.size,
    required this.leftText,
    required this.rightText,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final DotsTheme theme = context.dotsTheme;

    return ClipRRect(
      child: GestureDetector(
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(color: theme.colors.bgContainerPrimary),
          child: Padding(
            padding: EdgeInsets.zero,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [
                _TextProgress(size: size, leftText: leftText, rightText: rightText),
                _BarProgress(progress: progress),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextProgress extends StatelessWidget {
  final ProgressBarSize size;
  final String leftText;
  final String rightText;

  const _TextProgress({required this.size, required this.leftText, required this.rightText});

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
            spacing: 6,
            children: [
              Text(
                rightText,
                style: theme.typo.main.labelDefaultRegular.copyWith(
                  color: theme.colors.textSecondary,
                ),
              ),
              DotsIcon(
                iconData: DotsIconData.chevronRight,
                size: 14,
                color: theme.colors.textSecondary,
              ),
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
