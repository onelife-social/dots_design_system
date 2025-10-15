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

    return Stack(
      fit: StackFit.loose,
      children: [
        _BackSegmented(
          leftOptionIcon: leftOptionIcon,
          rightOptionIcon: rightOptionIcon,
          backgroundColor: backgroundColor,
          onTapOption: (SegmentedControlOption optionTaped) => onTapOption(optionTaped),
        ),
        Positioned(
          left: selectedOption.isLeft ? 0 : null,
          right: selectedOption.isRight ? 0 : null,
          child: Padding(
            padding: _itemPadding,
            child: _SelectedSegment(
              optionIcon: selectedOptionIcon,
              selectedColor: selectedColor,
              onTap: () => onTapOption(selectedOption),
            ),
          ),
        ),
      ],
    );
  }

  DotsIconData get selectedOptionIcon {
    return switch (selectedOption) {
      SegmentedControlOption.left => leftOptionIcon,
      SegmentedControlOption.right => rightOptionIcon,
    };
  }
}

class _BackSegmented extends StatelessWidget {
  final DotsIconData leftOptionIcon;
  final DotsIconData rightOptionIcon;
  final Color? backgroundColor;
  final Function(SegmentedControlOption optionTaped) onTapOption;

  const _BackSegmented({
    required this.leftOptionIcon,
    required this.rightOptionIcon,
    required this.backgroundColor,
    required this.onTapOption,
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
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: double.infinity, minWidth: 48),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTapOption(SegmentedControlOption.left),
                child: Center(
                  child: DotsIcon(
                    iconData: leftOptionIcon,
                    size: 24,
                    color: theme.colors.textDisabled,
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: double.infinity, minWidth: 48),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTapOption(SegmentedControlOption.right),
                child: Center(
                  child: DotsIcon(
                    iconData: rightOptionIcon,
                    size: 24,
                    color: theme.colors.textDisabled,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedSegment extends StatelessWidget {
  final DotsIconData optionIcon;
  final Color? selectedColor;
  final Function() onTap;

  const _SelectedSegment({
    required this.optionIcon,
    required this.selectedColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 40,
        width: 48,
        decoration: ShapeDecoration(
          color: selectedColor,
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r1000,
          ),
        ),
        child: Center(
          child: DotsIcon(
            iconData: optionIcon,
            size: 24,
            color: theme.colors.textSecondary,
          ),
        ),
      ),
    );
  }
}
