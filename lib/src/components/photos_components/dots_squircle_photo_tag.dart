import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

class DotsSquircleImageTag extends StatelessWidget {
  /// The image to display inside the squircle.
  final ImageProvider image;

  /// Path to the default image if loading fails.
  final String? defaultImagePath;

  /// Callback for image load errors.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The squircle style to use.
  final DotsStyleType squircleStyle;

  /// The size of the squircle image.
  final double size;

  /// The border radius of the squircle image.
  final BorderRadius borderRadius;

  /// The color of the border around the squircle image.
  final Color? borderColor;

  /// The size of the border around the squircle image.
  final double borderSize;

  /// The icon to show inside the tag circle.
  final DotsIconData icon;

  /// The size of the icon inside the tag circle.
  final double iconSize;

  /// The color of the icon inside the tag circle.
  final Color? iconColor;

  /// The diameter of the tag circle.
  final double tagCircleSize;

  /// The left offset of the icon inside the tag circle.
  final double iconLeft;

  /// The top offset of the icon inside the tag circle.
  final double iconTop;

  const DotsSquircleImageTag({
    super.key,
    required this.image,
    this.onError,
    this.defaultImagePath,
    required this.squircleStyle,
    this.size = 100,
    this.borderColor,
    this.borderSize = 2,
    this.borderRadius = DotsBorderRadius.r24,
    this.icon = DotsIconData.calendarCheck,
    this.iconSize = 24,
    this.iconColor,
    this.tagCircleSize = 40,
    this.iconLeft = 9,
    this.iconTop = 8,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return SizedBox(
      width: size + 10,
      height: size + 10,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: DotsSquircleImage(
              image: image,
              size: size,
              borderRadius: borderRadius,
              defaultImagePath: defaultImagePath,
              onError: onError,
              hideBorder: false,
              borderSize: borderSize,
              borderColor: borderColor ?? theme.colors.labelAlwaysWhite,
              squircleStyle: squircleStyle,
            ),
          ),
          Positioned(
            right: 2,
            bottom: 2,
            child: Container(
              width: tagCircleSize,
              height: tagCircleSize,
              decoration: BoxDecoration(
                color: theme.colors.labelHighlight,
                shape: BoxShape.circle,
                border: Border.all(
                  color: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.3),
                  width: 1.4,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: iconLeft,
                    top: iconTop,
                    child: DotsIcon(
                      iconData: icon,
                      size: iconSize,
                      color: iconColor ?? theme.colors.labelAlwaysWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
