import 'package:flutter/material.dart';

import '../../../dots_design_system.dart';

class DotsSquircleImage extends StatelessWidget {
  /// Image to be displayed.
  final ImageProvider image;

  /// Default image path to be used when the image fails to load.
  final String? defaultImagePath;

  /// Callback for image load errors.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Style of the squircle decoration.
  final DotsStyleType squircleStyle;

  /// Size of the image (width and height).
  final double size;

  /// Whether to hide the border around the image.
  final bool hideBorder;

  /// Size of the border.
  final double borderSize;

  /// Border radius of the image.
  final BorderRadius borderRadius;

  /// Border color of the image.
  final Color? borderColor;

  /// Whether there is an upload error.
  final bool uploadError;

  /// Icon to show on upload error.
  final DotsIconData uploadErrorIcon;

  const DotsSquircleImage({
    super.key,
    required this.image,
    this.onError,
    this.defaultImagePath,
    required this.squircleStyle,
    this.hideBorder = true,
    this.borderColor,
    this.size = 52,
    this.borderSize = 1,
    this.borderRadius = DotsBorderRadius.r16,
    this.uploadError = false,
    this.uploadErrorIcon = DotsIconData.cloudFail,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return DotsDecoratedBox(
      styleType: theme.styles.defaultShadow,
      child: DotsDecoratedBox(
        styleType: squircleStyle,
        child: Stack(
          children: [
            SizedBox(
              width: size,
              height: size,
              child: ClipRRect(
                borderRadius: borderRadius,
                child: Image(
                  image: image,
                  fit: BoxFit.cover,
                  width: size,
                  height: size,
                  errorBuilder: (context, err, trace) {
                    onError?.call(err, trace);
                    return Image.asset(
                      defaultImagePath ?? ImagesPaths.defaultSectionPlanning,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
            if (!hideBorder)
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: borderColor ?? theme.colors.bgBtnImage.withOpacity(0.6),
                        width: borderSize,
                      ),
                      borderRadius: borderRadius,
                    ),
                  ),
                ),
              ),
            if (uploadError)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                  ),
                  child: Center(
                    child: DotsIcon(
                      iconData: uploadErrorIcon,
                      color: theme.colors.labelAlwaysWhite,
                      size: 24,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}