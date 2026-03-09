import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const _textPadding = EdgeInsets.symmetric(horizontal: 15);
const _itemPadding = EdgeInsets.all(4);

class SegmentedControl extends StatelessWidget {
  /// The label for the left option.
  final String leftOptionName;

  /// The optional tag for the right option.
  final String? rightOptionTag;

  /// The label for the right option.
  final String rightOptionName;

  /// The currently selected option.
  final SegmentedControlOption selectedOption;

  /// The color of the selected segment.
  final Color? selectedColor;

  /// The background color of the segmented control.
  final Color? backgroundColor;

  /// The variant of the segmented control.
  final SegmentedControlVariant variant;

  /// Callback when an option is tapped.
  final void Function(SegmentedControlOption optionTaped) onTapOption;

  const SegmentedControl({
    super.key,
    required this.leftOptionName,
    required this.rightOptionName,
    required this.selectedOption,
    this.selectedColor,
    this.backgroundColor,
    required this.onTapOption,
    this.rightOptionTag,
    this.variant = SegmentedControlVariant.main,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.loose,
      children: [
        _BackSegmented(
          variant: variant,
          leftOptionName: leftOptionName,
          rightOptionName: rightOptionName,
          backgroundColor: backgroundColor,
          onTapOption: (SegmentedControlOption optionTaped) => onTapOption(optionTaped),
        ),
        Positioned(
          left: selectedOption.isLeft ? 0 : null,
          right: selectedOption.isRight ? 0 : null,
          child: Padding(
            padding: _itemPadding,
            child: _SelectedSegment(
              variant: variant,
              optionName: selectedOptionName,
              selectedColor: selectedColor,
              onTap: () => onTapOption(selectedOption),
            ),
          ),
        ),
        if (rightOptionTag != null && rightOptionTag!.isNotEmpty)
          Positioned(
            right: -2,
            top: -2,
            child: IgnorePointer(
              child: BadgeTag(
                size: const Size(0, 0),
                tag: rightOptionTag!,
                child: const SizedBox.shrink(),
              ),
            ),
          ),
      ],
    );
  }

  String get selectedOptionName {
    switch (selectedOption) {
      case SegmentedControlOption.left:
        return leftOptionName;
      case SegmentedControlOption.right:
        return rightOptionName;
    }
  }
}

class _BackSegmented extends StatelessWidget {
  const _BackSegmented({
    required this.leftOptionName,
    required this.rightOptionName,
    required this.backgroundColor,
    required this.onTapOption,
    required this.variant,
  });

  final String leftOptionName;
  final String rightOptionName;
  final Color? backgroundColor;
  final Function(SegmentedControlOption optionTaped) onTapOption;
  final SegmentedControlVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final defaultBackgroundColor = variant.isCamera
        ? theme.colors.bgChip
        : theme.colors.bgContainerSecondaryOnBackground;

    return DotsDecoratedBox(
      styleType: theme.styles.bgBlur,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r1000),
      ),
      child: Container(
        height: 36,
        padding: _itemPadding,
        decoration: ShapeDecoration(
          color: backgroundColor ?? defaultBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r1000),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 4,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: double.infinity),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTapOption(SegmentedControlOption.left),
                child: Padding(
                  padding: _textPadding,
                  child: Center(
                    child: Text(
                      leftOptionName,
                      textAlign: TextAlign.center,
                      style: theme.typo.main.labelDefaultMedium.copyWith(
                        color: variant.isCamera
                            ? theme.colors.labelAlwaysWhite
                            : theme.colors.labelSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(minHeight: double.infinity),
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTapOption(SegmentedControlOption.right),
                child: Padding(
                  padding: _textPadding,
                  child: Center(
                    child: Text(
                      rightOptionName,
                      textAlign: TextAlign.center,
                      style: theme.typo.main.labelDefaultMedium.copyWith(
                        color: variant.isCamera
                            ? theme.colors.labelAlwaysWhite
                            : theme.colors.labelSecondary,
                      ),
                    ),
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
  const _SelectedSegment({
    required this.optionName,
    required this.selectedColor,
    required this.onTap,
    required this.variant,
  });

  final String optionName;
  final Color? selectedColor;
  final Function() onTap;
  final SegmentedControlVariant variant;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 28,
        padding: _textPadding,
        decoration: ShapeDecoration(
          color: selectedColor ?? theme.colors.bgSecondaryBtn,
          shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r1000),
        ),
        child: Center(
          child: Text(
            optionName,
            textAlign: TextAlign.center,
            style: theme.typo.main.labelDefaultMedium.copyWith(
              color: variant.isCamera ? theme.colors.class005 : theme.colors.labelPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
