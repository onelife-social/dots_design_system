import 'package:flutter/material.dart';
import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/extensions/media_query_data_extensions.dart';
import 'package:dots_design_system/values/constants.dart';
import 'dart:ui';

class DotsHomeTopBar extends StatelessWidget implements PreferredSizeWidget {

  /// Title of the top bar.
  ///
  /// If not provided, the top bar will not display a title.
  final String? title;

  /// Custom widget to display in the top bar.
  ///
  /// If not provided, the top bar will not display a custom widget.
  final Widget? child;

  /// Icon button on the left side of the top bar.
  ///
  /// If not provided, the top bar will not display a left icon button.
  final Widget? imgProfile;

  /// Icon button on the right side of the top bar.
  ///
  /// If not provided, the top bar will not display a right icon button.
  final Widget? rightIcon;

  /// List of icon buttons on the right side of the top bar.
  final Widget? secondRightIcon;

  /// Whether to hide the background of the top bar.
  final bool showGradient;

  final bool _bigStatusBar;

  /// Only status bar, no title or segmented control.
  const DotsHomeTopBar.onlyStatusBar({
    super.key,
    this.showGradient = false,
  })  : title = null,
        child = null,
        imgProfile = null,
        rightIcon = null,
        secondRightIcon = null,
        _bigStatusBar = false;

  /// Bar with title,left image profile and right icons.
  const DotsHomeTopBar.title({
    super.key,
    this.showGradient = false,
    required String this.title,
    this.imgProfile,
    this.rightIcon,
    this.secondRightIcon,
  })  : 
        child = null,
        _bigStatusBar = true;

  /// Bar with widget, left image profile and right icons.
  const DotsHomeTopBar.widget({
    super.key,
    this.showGradient = false,
    this.child,
    this.imgProfile,
    this.rightIcon,
    this.secondRightIcon,
  })  : 
        title = null,
        _bigStatusBar = true;

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
    final aspectRatio = MediaQuery.of(context).aspectRatio;

    final content = _TopBarContent(context, theme, aspectRatio);

    return ClipRRect(
      borderRadius: BorderRadius.zero,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: preferredSize.height),
        child: Stack(
          fit: StackFit.expand,
          children: [
            showGradient
                ? ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          theme.colors.bgContainerPrimary,
                          Colors.transparent,
                        ],
                      ).createShader(bounds);
                    },
                    blendMode: BlendMode.dstIn,
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                      child: Container(
                        color: theme.colors.bgContainerPrimary,
                      ),
                    ),
                  )
                : BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                    child: Container(
                      color: theme.colors.bgContainerPrimary,
                    ),
                  ),
            content,
          ],
        ),
      ),
    );
  }

  Widget _TopBarContent(BuildContext context, DotsTheme theme, double aspectRatio) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(height: preferredSize.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 50),
          if (_bigStatusBar)
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Center(
                      child: child ??
                          (title != null
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      title!,
                                      style: theme.typo.main.labelDefaultBold.copyWith(
                                        color: theme.colors.textTertiary,
                                      ),
                                    ),
                                  ],
                                )
                              : null),
                    ),
                  ),
                  Positioned.fill(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (imgProfile != null) ...[
                          const SizedBox(width: 16),
                          imgProfile!,
                        ],
                        const Spacer(),
                        if (rightIcon != null) ...[
                          rightIcon!,
                          SizedBox(width: secondRightIcon != null
                            ? (aspectRatio > (19.5 / 9) ? 12 : 4)
                            : 16),
                        ],
                        if (secondRightIcon != null) ...[
                          secondRightIcon!,
                          const SizedBox(width: 16),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
