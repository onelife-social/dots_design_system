import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum SegmentedControlOption {
  left,
  right;

  bool get isLeft => this == SegmentedControlOption.left;
  bool get isRight => this == SegmentedControlOption.right;
}

const _textPadding = EdgeInsets.symmetric(horizontal: 15);
const _itemPadding = EdgeInsets.all(4);

class SegmentedControl extends StatelessWidget {
  final String leftOptionName;
  final String rightOptionName;
  final SegmentedControlOption selectedOption;

  final void Function(SegmentedControlOption optionTaped) onTapOption;

  const SegmentedControl({
    super.key,
    required this.leftOptionName,
    required this.rightOptionName,
    required this.selectedOption,
    required this.onTapOption,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        _BackSegmented(
          leftOptionName: leftOptionName,
          rightOptionName: rightOptionName,
          onTapOption: (SegmentedControlOption optionTaped) => onTapOption(optionTaped),
        ),
        Positioned(
            left: selectedOption.isLeft ? 0 : null,
            right: selectedOption.isRight ? 0 : null,
            child: Padding(
              padding: _itemPadding,
              child: _SelectedSegment(
                optionName: selectedOptionName,
                onTap: () => onTapOption(selectedOption),
              ),
            ))
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
  const _BackSegmented(
      {required this.leftOptionName, required this.rightOptionName, required this.onTapOption});

  final String leftOptionName;
  final String rightOptionName;
  final Function(SegmentedControlOption optionTaped) onTapOption;
  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Container(
      height: 36,
      padding: _itemPadding,
      decoration: ShapeDecoration(
        color: theme.colors.bgContainerSecondary,
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
                    style: theme.typo.main.labelDefaultMedium
                        .copyWith(color: theme.colors.labelSecondary),
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
                    style: theme.typo.main.labelDefaultMedium
                        .copyWith(color: theme.colors.labelSecondary),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SelectedSegment extends StatelessWidget {
  const _SelectedSegment({required this.optionName, required this.onTap});

  final String optionName;
  final Function() onTap;

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
          color: theme.colors.bgSecondaryBtn,
          shape: RoundedRectangleBorder(
            borderRadius: DotsBorderRadius.r1000,
          ),
        ),
        child: Center(
          child: Text(
            optionName,
            textAlign: TextAlign.center,
            style: theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.labelPrimary),
          ),
        ),
      ),
    );
  }
}
