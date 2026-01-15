import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const _textPadding = EdgeInsets.symmetric(horizontal: 15);
const _itemPadding = EdgeInsets.all(4);

class SegmentedControlSingle extends StatelessWidget {
  /// The label for the button.
  final String buttonName;

  /// The optional tag for the button.
  final String? buttonTag;

  /// The color of the button.
  final Color? selectedColor;

  /// The background color of the segmented control.
  final Color? backgroundColor;

  const SegmentedControlSingle({
    super.key,
    required this.buttonName,
    this.selectedColor,
    this.backgroundColor,
    this.buttonTag,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Stack(
        clipBehavior: Clip.none,
        fit: StackFit.loose,
        children: [
          _BackSegmentedSingle(
            buttonName: buttonName,
            backgroundColor: backgroundColor,
          ),
          Positioned(
            left: 0,
            right: 0,
            child: Padding(
              padding: _itemPadding,
              child: _SelectedSegment(
                buttonName: buttonName,
                selectedColor: selectedColor,
              ),
            ),
          ),
          if (buttonTag != null && buttonTag!.isNotEmpty)
            Positioned(
              right: -2,
              top: -2,
              child: IgnorePointer(
                child: BadgeTag(
                  size: const Size(0, 0),
                  tag: buttonTag!,
                  child: const SizedBox.shrink(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BackSegmentedSingle extends StatelessWidget {
  const _BackSegmentedSingle({
    required this.buttonName,
    required this.backgroundColor,
  });

  final String buttonName;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    var boxConstraints = BoxConstraints();
    return DotsDecoratedBox(
      styleType: theme.styles.bgBlur,
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: DotsBorderRadius.r1000,
        ),
      ),
      child: Container(
        height: 36,
        padding: _itemPadding,
        decoration: ShapeDecoration(
          color: backgroundColor ?? theme.colors.bgContainerSecondaryOnBackground,
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r1000,
          ),
        ),
        child: Padding(
          padding: _textPadding,
          child: Center(
            child: Text(
              buttonName,
              textAlign: TextAlign.center,
              style: theme.typo.main.labelDefaultMedium.copyWith(
                color: theme.colors.labelSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SelectedSegment extends StatelessWidget {
  const _SelectedSegment({
    required this.buttonName,
    required this.selectedColor,
  });

  final String buttonName;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      height: 28,
      padding: _textPadding,
      decoration: ShapeDecoration(
        color: selectedColor ?? theme.colors.bgSecondaryBtn,
        shape: RoundedRectangleBorder(
          borderRadius: DotsBorderRadius.r1000,
        ),
      ),
      child: Center(
        child: Text(
          buttonName,
          textAlign: TextAlign.center,
          style: theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.labelPrimary),
        ),
      ),
    );
  }
}
