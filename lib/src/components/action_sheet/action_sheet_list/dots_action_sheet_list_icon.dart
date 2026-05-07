import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsActionSheetIconModel {
  final DotsIconData icon;
  final DotsIconButtonVariant variant;
  final VoidCallback? onTap;
  final DotsIconButtonSize size;

  DotsActionSheetIconModel({
    required this.icon,
    required this.variant,
    required this.size,
    this.onTap,
  });
}

class DotsActionSheetListIcon extends StatelessWidget {
  /// The [title] parameter is the title of the action sheet.
  final String title;

  /// The [onBackButtonTap] is a callback for the back button.
  final Function()? onBackButtonTap;

  /// The [onClose] is a callback for the close button.
  final Function()? onClose;

  /// The [showBlurBackground] parameter determines whether to show a blurred background.
  final bool showBlurBackground;

  /// The [bottomPosition] parameter determines the position of the action sheet from the bottom.
  final double bottomPosition;

  /// The [icons] parameter is a list of icons to display in the action sheet.
  final List<DotsActionSheetIconModel> icons;

  const DotsActionSheetListIcon({
    super.key,
    required this.title,
    this.onBackButtonTap,
    this.onClose,
    this.showBlurBackground = true,
    this.bottomPosition = 56,
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: Container(
            child: showBlurBackground
                ? BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Container(
                      color: Colors.black.dotsWithOpacity(0.3),
                    ),
                  )
                : null,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: context.getByRatio(657, 480),
              ),
              decoration: BoxDecoration(
                color: theme.colors.bgBaseContrast,
                borderRadius: DotsBorderRadius.r32,
              ),
              width: double.infinity,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: DotsBorderRadius.r32,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _Header(
                          title: title,
                          onBackButtonTap: onBackButtonTap,
                        ),
                        _Body(
                          icons: icons,
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: -1,
                    child: IgnorePointer(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(32),
                          bottomRight: Radius.circular(32),
                        ),
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              stops: [0.0, 0.5, 1.0],
                              colors: [
                                theme.colors.bgBaseContrast,
                                theme.colors.bgBaseContrast.dotsWithOpacity(0.7),
                                theme.colors.bgBaseContrast.dotsWithOpacity(0.0),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;
  final Function()? onBackButtonTap;
  const _Header({
    required this.title,
    this.onBackButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (onBackButtonTap != null) ...[
                Container(
                  alignment: Alignment.centerLeft,
                  width: 44,
                  child: DotsIconButton(
                    icon: DotsIconData.chevronLeft,
                    size: DotsIconButtonSize.medium,
                    variant: DotsIconButtonVariant.noBackground,
                    onTap: onBackButtonTap,
                  ),
                ),
              ] else ...[
                const SizedBox(width: 44),
              ],
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      title,
                      style: theme.typo.secondary.title02H6,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 44),
            ],
          ),
        ],
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final List<DotsActionSheetIconModel> icons;

  const _Body({
    required this.icons,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
        physics: const AlwaysScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
        ),
        itemCount: icons.length,
        itemBuilder: (context, index) {
          final iconModel = icons[index];
          return DotsIconButton(
            icon: iconModel.icon,
            variant: iconModel.variant,
            size: iconModel.size,
            onTap: iconModel.onTap,
            color: theme.colors.textTertiary,
          );
        },
      ),
    );
  }
}
