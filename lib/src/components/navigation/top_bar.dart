import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title of the top bar.
  ///
  /// If not provided, the top bar will not display a title.
  final String? title;

  /// Subtitle of the top bar.
  ///
  /// If not provided, the top bar will not display a subtitle.
  final String? subtitle;

  /// Segmented control for the top bar.
  ///
  /// If not provided, the top bar will not display a segmented control.
  final SegmentedControl? segmentedControl;

  /// Icon button on the left side of the top bar.
  ///
  /// If not provided, the top bar will not display a left icon button.
  /// Cannot be used with [onTapBack].
  final DotsIconButton? leftIcon;

  /// Icon button on the right side of the top bar.
  ///
  /// If not provided, the top bar will not display a right icon button.
  final DotsIconButton? rightIcon;

  /// Callback when the back button is tapped.
  ///
  /// If not provided, the top bar will not display a back button.
  /// Cannot be used with [leftIcon].
  final Function()? onTapBack;

  final bool _bigStatusBar;

  /// Only status bar, no title or segmented control.
  const TopBar.onlyStatusBar({super.key})
      : title = null,
        subtitle = null,
        segmentedControl = null,
        leftIcon = null,
        rightIcon = null,
        onTapBack = null,
        _bigStatusBar = false;

  /// Bar with title and optional subtitle, left and right icons, and back button.
  const TopBar.title({
    super.key,
    required String this.title,
    this.subtitle,
    this.leftIcon,
    this.rightIcon,
    this.onTapBack,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        segmentedControl = null,
        _bigStatusBar = true;

  /// Bar with segmented control, left and right icons, and back button.
  const TopBar.segmentedBar({
    super.key,
    this.segmentedControl,
    this.leftIcon,
    this.rightIcon,
    this.onTapBack,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        title = null,
        subtitle = null,
        _bigStatusBar = true;

  @override
  Size get preferredSize {
    if (_bigStatusBar) {
      return Size.fromHeight(98);
    } else {
      return Size.fromHeight(50);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return ColoredBox(
      color: theme.colors.bgContainerPrimary,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: preferredSize.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
            if (_bigStatusBar) ...[
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Center(
                      child: segmentedControl ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                title ?? '',
                                style: theme.typo.main.bodyLargeBold,
                              ),
                              if (subtitle != null)
                                Text(
                                  subtitle ?? '',
                                  style: theme.typo.main.labelSmallRegular.copyWith(
                                    color: theme.colors.textSecondary,
                                  ),
                                ),
                            ],
                          ),
                    )),
                    Positioned.fill(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (onTapBack != null) ...[
                            SizedBox(width: 8),
                            DotsIconButton(
                              icon: DotsIconData.chevronLeft,
                              size: DotsIconButtonSize.medium,
                              variant: DotsIconButtonVariant.noBackground,
                              onTap: onTapBack,
                            ),
                          ],
                          if (leftIcon != null) ...[
                            SizedBox(width: 16),
                            leftIcon ?? SizedBox(),
                          ],
                          Spacer(),
                          if (rightIcon != null) ...[
                            rightIcon ?? SizedBox(),
                            SizedBox(width: 16),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ]
          ],
        ),
      ),
    );
  }
}
