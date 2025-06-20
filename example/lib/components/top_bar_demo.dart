import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum TobBarVariant {
  onlyStatusBar,
  title,
  segmentedControl,
  cta;

  bool get isOnlyStatusBar => this == TobBarVariant.onlyStatusBar;
  bool get isTitle => this == TobBarVariant.title;
  bool get isSegmentedControl => this == TobBarVariant.segmentedControl;
  bool get isCta => this == TobBarVariant.cta;
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
    this.ctaLabel,
    this.ctaEnabled = true,
  });

  final TobBarVariant variant;
  final String title;
  final String? subtitle;
  final bool showLeftIcon;
  final bool showRightIcon;
  final bool showBackButton;
  final String? ctaLabel;
  final bool ctaEnabled;

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
        return DotsTopBar.widget(
          leftIcon: leftIcon,
          rightIcon: rightIcon,
          onTapBack: onTapBack,
          child: SegmentedControl(
            leftOptionName: 'Option 1',
            rightOptionName: 'Option 2',
            onTapOption: (_) {},
            selectedOption: SegmentedControlOption.right,
          ),
        );
      case TobBarVariant.cta:
        return DotsTopBar.cta(
          onTapBack: () {},
          title: title,
          ctaLabel: ctaLabel ?? 'Call to Action',
          onCtaTap: () {},
          ctaEnabled: ctaEnabled,
        );

      default:
        return DotsTopBar.onlyStatusBar();
    }
  }
}
