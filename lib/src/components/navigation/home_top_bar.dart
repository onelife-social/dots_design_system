import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:dots_design_system/extensions/media_query_data_extensions.dart';
import 'package:dots_design_system/values/constants.dart';

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
  final DotsProfilePhoto? imgProfile;

  /// Icon button on the right side of the top bar.
  ///
  /// If not provided, the top bar will not display a right icon button.
  final DotsIconButton? rightIcon;
  /// List of icon buttons on the right side of the top bar.
  final DotsIconButton? secondRightIcon;

  /// Whether to hide the background of the top bar.
  final bool hideBackground;

  final bool _bigStatusBar;

  /// Only status bar, no title or segmented control.
  const DotsHomeTopBar.onlyStatusBar({
    super.key,
    this.hideBackground = false,
  })  : title = null,
        child = null,
        imgProfile = null,
        rightIcon = null,
        secondRightIcon = null,
        _bigStatusBar = false;

  /// Bar with title,left image profile and right icons.
  const DotsHomeTopBar.title({
    super.key,
    this.hideBackground = false,
    required String this.title,
    this.imgProfile,
    this.rightIcon,
    this.secondRightIcon,
  })  : 
        child = null,
        _bigStatusBar = true;

  /// Bar with widget,  left image profile and right icons.
  const DotsHomeTopBar.widget({
    super.key,
    this.hideBackground = false,
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
                    )),
                    Positioned.fill(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (imgProfile != null) ...[
                            SizedBox(width: 16),
                            imgProfile ?? SizedBox(),
                          ],
                          Spacer(),
                          if (rightIcon != null) ...[
                            rightIcon ?? SizedBox(),
                            SizedBox(width: aspectRatio > 19.5 ? 12 : 4),
                          ],

                          if (secondRightIcon != null) ...[
                            secondRightIcon ?? SizedBox(),
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
