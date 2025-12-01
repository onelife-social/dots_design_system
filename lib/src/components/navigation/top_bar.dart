import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

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

  /// Widget on the left side of the top bar.
  ///
  /// If not provided, the top bar will not display a left widget.
  /// Cannot be used with [onTapBack].
  final Widget? leftIcon;

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

  /// Whether to use the big status bar style.
  final bool? bigStatusBar;

  /// Call to action title for the top bar.
  final String? ctaLabel;

  /// Callback when the call to action is tapped.
  final Function()? onCtaTap;

  /// Whether the call to action is enabled.
  final bool ctaEnabled;

  /// Image to display in the top bar.
  final ImageProvider? imageTitle;

  /// Callback for image load error.
  final void Function(Object exception, StackTrace? stackTrace)? onErrorImageTitle;

  /// Whether to show the back button inside a gray circular background.
  final bool showCircleBackButton;

  /// Color of the top bar background.
  ///
  /// If it's provided, ignores the [hideBackground] property.
  final Color? color;

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
        bigStatusBar = false,
        ctaLabel = null,
        onCtaTap = null,
        ctaEnabled = false,
        imageTitle = null,
        onErrorImageTitle = null,
        showCircleBackButton = false,
        color = null;

  /// Bar with title and optional subtitle, left and right icons, back button and image.
  const DotsTopBar.title({
    super.key,
    this.hideBackground = false,
    required String this.title,
    this.subtitle,
    this.leftIcon,
    this.rightIcon,
    this.bigStatusBar,
    this.onTapBack,
    this.imageTitle,
    this.onErrorImageTitle,
    this.showCircleBackButton = false,
    this.color,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        child = null,
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
    this.bigStatusBar,
    this.onTapBack,
    this.showCircleBackButton = false,
    this.color,
  })  : assert(
          (leftIcon == null || onTapBack == null),
          'leftIcon cannot be used with onTapBack',
        ),
        title = null,
        subtitle = null,
        ctaLabel = null,
        ctaEnabled = false,
        imageTitle = null,
        onErrorImageTitle = null,
        onCtaTap = null;

  /// Bar with call to action and back button.
  const DotsTopBar.cta({
    super.key,
    this.hideBackground = false,
    this.title,
    this.imageTitle,
    this.onErrorImageTitle,
    this.bigStatusBar,
    this.onTapBack,
    this.ctaLabel,
    this.onCtaTap,
    this.ctaEnabled = true,
    this.showCircleBackButton = false,
    this.color,
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
        leftIcon = null,
        rightIcon = null;

  @override
  Size get preferredSize {
    if (bigStatusBar ?? true) {
      return Size.fromHeight(kTopBarBigHeight);
    } else {
      return Size.fromHeight(kTopBarNormalHeight);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return ColoredBox(
      color: color ?? (hideBackground ? Colors.transparent : theme.colors.bgContainerPrimary),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: preferredSize.height),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 50,
              width: double.infinity,
            ),
            if (bigStatusBar ?? true) ...[
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: Center(
                      child: child ??
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (imageTitle != null) ...[
                                    DotsProfilePhoto(
                                      imageProvider: imageTitle!,
                                      width: 20,
                                      height: 20,
                                      onError: onErrorImageTitle,
                                    ),
                                    SizedBox(width: 6)
                                  ],
                                  Text(
                                    title ?? '',
                                    style: theme.typo.main.titleH6.copyWith(
                                      color: theme.colors.textPrimary,
                                    ),
                                  ),
                                ],
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
                            SizedBox(width: showCircleBackButton ? 16 : 8),
                            DotsIconButton(
                              icon: DotsIconData.chevronLeft,
                              size: DotsIconButtonSize.medium,
                              variant: showCircleBackButton
                                  ? DotsIconButtonVariant.solid
                                  : DotsIconButtonVariant.noBackground,
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
