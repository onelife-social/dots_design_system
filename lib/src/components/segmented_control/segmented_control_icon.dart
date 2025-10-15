import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const _itemPadding = EdgeInsets.all(4);

class SegmentedControlIcon extends StatelessWidget {
  /// Icon for the left option.
  final DotsIconData leftOptionIcon;

  /// Icon for the right option.
  final DotsIconData rightOptionIcon;

  /// Currently selected option.
  final SegmentedControlOption selectedOption;

  /// Callback when an option is tapped.
  final void Function(SegmentedControlOption optionTaped) onTapOption;

  const SegmentedControlIcon({
    super.key,
    required this.leftOptionIcon,
    required this.rightOptionIcon,
    required this.selectedOption,
    required this.onTapOption,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final Color selectedColor = theme.colors.bgFloatingActive;
    final Color backgroundColor = theme.colors.bgContainerSecondary;

    const double segmentWidth = 48;
    const double spacing = 4;
    const double horizontalPaddingTotal = 8;
    final double totalWidth = (segmentWidth * 2) + spacing + horizontalPaddingTotal;

    final Color leftIconColor =
        selectedOption.isLeft ? theme.colors.textSecondary : theme.colors.textDisabled;
    final Color rightIconColor =
        selectedOption.isRight ? theme.colors.textSecondary : theme.colors.textDisabled;

    return SizedBox(
      width: totalWidth,
      height: 48,
      child: Stack(
        children: [
          _BackgroundShape(
            backgroundColor: backgroundColor,
          ),
          Padding(
            padding: _itemPadding,
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutCubic,
              alignment: selectedOption.isLeft ? Alignment.centerLeft : Alignment.centerRight,
              child: _SelectedPill(
                selectedColor: selectedColor,
              ),
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: _itemPadding,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                spacing: 4,
                children: [
                  _IconTapArea(
                    icon: leftOptionIcon,
                    color: leftIconColor,
                    onTap: () => onTapOption(SegmentedControlOption.left),
                  ),
                  _IconTapArea(
                    icon: rightOptionIcon,
                    color: rightIconColor,
                    onTap: () => onTapOption(SegmentedControlOption.right),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BackgroundShape extends StatelessWidget {
  final Color backgroundColor;

  const _BackgroundShape({
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return DotsDecoratedBox(
      styleType: theme.styles.bgBlur,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: DotsBorderRadius.r1000,
        ),
      ),
      child: Container(
        height: 48,
        padding: _itemPadding,
        decoration: ShapeDecoration(
          color: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r1000,
          ),
        ),
      ),
    );
  }
}

class _IconTapArea extends StatelessWidget {
  final DotsIconData icon;
  final Color color;
  final VoidCallback onTap;

  const _IconTapArea({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minHeight: double.infinity, minWidth: 48),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Center(
          child: DotsIcon(
            iconData: icon,
            size: 24,
            color: color,
          ),
        ),
      ),
    );
  }
}

class _SelectedPill extends StatelessWidget {
  final Color selectedColor;

  const _SelectedPill({
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOutCubic,
      height: 40,
      width: 48,
      decoration: ShapeDecoration(
        color: selectedColor,
        shape: RoundedRectangleBorder(
          borderRadius: DotsBorderRadius.r1000,
        ),
      ),
    );
  }
}
