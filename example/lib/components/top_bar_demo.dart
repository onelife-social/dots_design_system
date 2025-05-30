import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum TobBarVariant {
  onlyStatusBar,
  title,
  segmentedControl,
}

class TopBarDemo extends StatelessWidget {
  const TopBarDemo({
    super.key,
    required this.variant,
    required this.title,
    this.subtitle,
    required this.showLeftIcon,
    required this.showRightIcon,
    required this.showBackButton,
  });

  final TobBarVariant variant;
  final String title;
  final String? subtitle;
  final bool showLeftIcon;
  final bool showRightIcon;
  final bool showBackButton;

  DotsIconButton? get leftIcon => showLeftIcon
      ? DotsIconButton(
          icon: DotsIconData.lightbulb,
          size: DotsIconButtonSize.medium,
          onTap: () {},
        )
      : null;

  DotsIconButton? get rightIcon => showRightIcon
      ? DotsIconButton(
          icon: DotsIconData.lightbulb,
          size: DotsIconButtonSize.medium,
          onTap: () {},
        )
      : null;

  Function()? get onTapBack => showLeftIcon
      ? null
      : showBackButton
          ? () {}
          : null;

  @override
  Widget build(BuildContext context) {
    switch (variant) {
      case TobBarVariant.title:
        return DotsTopBar.title(
          title: title,
          subtitle: subtitle,
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          onTapBack: onTapBack,
        );
      case TobBarVariant.segmentedControl:
        return DotsTopBar.segmentedBar(
          segmentedControl: SegmentedControl(
            leftOptionName: 'Option 1',
            rightOptionName: 'Option 2',
            onTapOption: (_) {},
            selectedOption: SegmentedControlOption.right,
          ),
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          onTapBack: onTapBack,
        );
      default:
        return DotsTopBar.onlyStatusBar();
    }
  }
}
