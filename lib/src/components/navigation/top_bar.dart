import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:dots_design_system/values/constants.dart';

class DotsTopBar extends StatelessWidget implements PreferredSizeWidget {
  /// Title of the top bar.
  ///
  /// If not provided, the top bar will not display a title.
  final String? title;

  /// Subtitle of the top bar.
  ///
  /// If not provided, the top bar will not display a subtitle.
  final String? subtitle;

  /// Custom widget to display in the top bar.
  ///
  /// If not provided, the top bar will not display a custom widget.
  final Widget? child;

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

  /// Whether to hide the background of the top bar.
  final bool hideBackground;

  final bool _bigStatusBar;

  /// Call to action title for the top bar.
  final String? ctaLabel;

  /// Callback when the call to action is tapped.
  final Function()? onCtaTap;

  /// Whether the call to action is enabled.
  final bool ctaEnabled;

  /// Only status bar, no title or segmented control.
  const DotsTopBar.onlyStatusBar({
    super.key,
    this.hideBackground = false,
  })  : title = null,
        subtitle = null,
        child = null,
        leftIcon = null,
        rightIcon = null,
        onTapBack = null,
        _bigStatusBar = false,
        ctaLabel = null,
        onCtaTap = null,
        ctaEnabled = false;

  /// Bar with title and optional subtitle, left and right icons, and back button.
  const DotsTopBar.title({
    super.key,
    this.hideBackground = false,
    required String this.title,
    this.subtitle,
    this.leftIcon,
    this.rightIcon,
    this.onTapBack,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        child = null,
        _bigStatusBar = true,
        ctaLabel = null,
        onCtaTap = null,
        ctaEnabled = false;

  /// Bar with widget, left and right icons, and back button.
  const DotsTopBar.widget({
    super.key,
    this.hideBackground = false,
    this.child,
    this.leftIcon,
    this.rightIcon,
    this.onTapBack,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        title = null,
        subtitle = null,
        _bigStatusBar = true,
        ctaLabel = null,
        ctaEnabled = false,
        onCtaTap = null;

  /// Bar with call to action and back button.
  const DotsTopBar.cta({
    super.key,
    this.hideBackground = false,
    this.title,
    this.onTapBack,
    this.ctaLabel,
    this.onCtaTap,
    this.ctaEnabled = true,
  })  : assert(
          onCtaTap == null || ctaLabel != null,
          'ctaLabel is required when onCtaTap is provided',
        ),
        assert(
          (onTapBack != null),
          'onTapBack cannot be null',
        ),
        child = null,
        subtitle = null,
        _bigStatusBar = true,
        leftIcon = null,
        rightIcon = null;

  @override
  Size get preferredSize {
    if (_bigStatusBar) {
      return Size.fromHeight(kBigHeight);
    } else {
      return Size.fromHeight(kNormalHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return ColoredBox(
      color: hideBackground ? Colors.transparent : theme.colors.bgContainerPrimary,
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
                      child: child ??
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
                          if (ctaLabel != null && onCtaTap != null) ...[
                            DotsMainButton(
                              content: ctaLabel!,
                              onTap: onCtaTap,
                              variant: DotsMainButtonVariant.main,
                              size: DotsMainButtonSize.small,
                              expand: false,
                              enabled: ctaEnabled,
                            ),
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
