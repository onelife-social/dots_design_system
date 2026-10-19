import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/widget/gradient_progress_indicator_widget.dart';

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
  /// The size of the button.
  final DotsRichButtonSize size;

  /// The text size of the content.
  final DotsRichButtonTextSize textSize;

  /// The icon to display on the button (leading).
  final DotsIconData? icon;

  /// Optional color for the leading icon.
  ///
  /// Defaults to `textSecondary` if not provided.
  final Color? iconColor;

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

  /// When false, the button is painted with the disabled colors of
  /// [DotsMainButton] (`bgBtnDisabled`, `textDisabled`) and taps are ignored.
  final bool enabled;

  /// Replaces leading, content and trailing with a centered spinner
  /// (`labelHighlight`) and ignores taps. The background does not change.
  final bool isLoading;

  const DotsRichButton({
    super.key,
    required this.size,
    required this.textSize,
    this.icon,
    this.iconColor,
    this.image,
    required this.content,
    this.details,
    this.trailingText,
    this.onTap,
    this.enabled = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final borderRadius = BorderRadius.circular(size.isLarge ? 100 : 32);
    final disabled = !enabled && !isLoading;
    final iconColor = disabled
        ? theme.colors.textDisabled
        : this.iconColor ?? theme.colors.textSecondary;
    final contentColor = disabled
        ? theme.colors.textDisabled
        : theme.colors.textPrimary;
    final secondaryColor = disabled
        ? theme.colors.textDisabled
        : theme.colors.textSecondary;
    final trailingColor = disabled
        ? theme.colors.textDisabled
        : theme.colors.textTertiary;

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: GestureDetector(
          onTap: (enabled && !isLoading) ? onTap : null,
          child: Container(
            height: size.height,
            width: size.width,
            color: disabled
                ? theme.colors.bgBtnDisabled
                : theme.colors.bgContainerSecondary,
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: size.isLarge ? 18 : 8,
            ),
            child: isLoading
                ? Center(
                    child: GradientProgressIndicator(
                      radius: 12,
                      duration: 1,
                      strokeWidth: 3.0,
                      gradientStops: const [0.0001, 1.0],
                      gradientColors: [
                        theme.colors.labelHighlight.dotsWithOpacity(0),
                        theme.colors.labelHighlight,
                      ],
                      child: const SizedBox.shrink(),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      image != null
                          ? Opacity(
                              // An image cannot be tinted: same alpha as textDisabled
                              opacity: disabled ? 0.2 : 1,
                              child: Image(
                                image: image!,
                                width: 32,
                                height: 32,
                                fit: BoxFit.cover,
                                errorBuilder: (_, _, _) =>
                                    const SizedBox.shrink(),
                              ),
                            )
                          : icon != null
                          ? DotsIcon(
                              iconData: icon!,
                              size: 24,
                              color: iconColor,
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
                                        color: contentColor,
                                      )
                                    : theme.typo.main.bodyDefaultMedium
                                          .copyWith(color: contentColor),
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
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        ],
                      ),

                      trailingText?.isNotEmpty == true
                          ? Text(
                              trailingText!,
                              style: theme.typo.main.labelDefaultBold.copyWith(
                                color: trailingColor,
                              ),
                            )
                          : DotsIcon(
                              iconData: DotsIconData.chevronRight,
                              size: 20,
                              color: trailingColor,
                            ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
