import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsRichButtonSize {
  large(width: 358, height: 75),
  medium(width: 358, height: 60),
  small(width: 248, height: 60);

  final double width;
  final double height;

  const DotsRichButtonSize({
    required this.width,
    required this.height,
  });

  bool get isLarge => this == DotsRichButtonSize.large;
  bool get isMedium => this == DotsRichButtonSize.medium;
  bool get isSmall => this == DotsRichButtonSize.small;
}

enum DotsRichButtonTextSize {
  large,
  medium;

  bool get isLarge => this == DotsRichButtonTextSize.large;
  bool get isMedium => this == DotsRichButtonTextSize.medium;
}

class DotsRichButton extends StatelessWidget {
  const DotsRichButton({
    super.key,
    required this.size,
    required this.textSize,
    this.icon,
    this.image,
    required this.content,
    this.details,
    this.trailingText,
    this.onTap,
  });

  /// The size of the button.
  final DotsRichButtonSize size;

  /// The text size of the content.
  final DotsRichButtonTextSize textSize;

  /// The icon to display on the button (leading).
  final DotsIconData? icon;

  /// The image to display on the button (leading).
  final ImageProvider? image;

  /// The text to display on the button.
  final String content;

  /// Additional details to display on the button.
  final String? details;

  /// Optional trailing text to display on the button.
  ///
  /// If not provided, a right chevron will be displayed.
  final String? trailingText;

  /// Callback when the button is tapped.
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final borderRadius = BorderRadius.circular(size.isLarge ? 100 : 32);

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            height: size.height,
            width: size.width,
            color: theme.colors.bgContainerSecondary,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: size.isLarge ? 18 : 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                image != null
                    ? Image(
                        image: image!,
                        width: 32,
                        height: 32,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      )
                    : icon != null
                    ? DotsIcon(
                        iconData: icon!,
                        size: 24,
                        color: theme.colors.textSecondary,
                      )
                    : const SizedBox.shrink(),

                Column(
                  spacing: 2,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Text(
                          content,
                          style: textSize.isLarge
                              ? theme.typo.main.bodyLargeMedium.copyWith(
                                  color: theme.colors.textPrimary,
                                )
                              : theme.typo.main.bodyDefaultMedium.copyWith(
                                  color: theme.colors.textPrimary,
                                ),
                        ),
                        if (trailingText?.isNotEmpty == true)
                          Positioned(
                            top: 0,
                            right: -8,
                            child: Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                      ],
                    ),
                    if (details?.isNotEmpty == true) ...[
                      Text(
                        details!,
                        style: theme.typo.main.labelSmallRegular.copyWith(
                          color: theme.colors.textSecondary,
                        ),
                      ),
                    ],
                  ],
                ),

                trailingText?.isNotEmpty == true
                    ? Text(
                        trailingText!,
                        style: theme.typo.main.labelDefaultBold.copyWith(
                          color: theme.colors.textTertiary,
                        ),
                      )
                    : DotsIcon(
                        iconData: DotsIconData.chevronRight,
                        size: 20,
                        color: theme.colors.textTertiary,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
