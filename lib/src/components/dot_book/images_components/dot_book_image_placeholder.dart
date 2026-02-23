import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookImagePlaceholder extends StatelessWidget {
  /// Media widget to display in the card (image or video).
  final Widget media;

  /// Aspect ratio for the media. Defaults to 6:7.
  final double mediaAspectRatio;

  /// Border radius, by default 32.
  final BorderRadius borderRadius;

  /// Optional badge text to display over the image (bottom-left).
  final String? badgeText;

  /// Optional icon for the badge. Defaults to null (no icon).
  final DotsIconData? badgeIcon;

  /// Optional handler for back button tap. If null, no back button is shown.
  final Function()? onBackPressed;

  /// Optional icon for the back button. Defaults to `DotsIconData.chevronLeft`.
  final DotsIconData? backIcon;

  const DotBookImagePlaceholder({
    super.key,
    required this.media,
    this.mediaAspectRatio = 4 / 5,
    this.borderRadius = const BorderRadius.all(Radius.circular(32.0)),
    this.badgeText,
    this.badgeIcon,
    this.onBackPressed,
    this.backIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: mediaAspectRatio,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(child: media),
              if (onBackPressed != null)
                Positioned(
                  left: 12,
                  top: 10,
                  child: DotsIconButton(
                    icon: backIcon ?? DotsIconData.chevronLeft,
                    size: DotsIconButtonSize.medium,
                    style: DotsIconButtonStyle.floating,
                    state: DotsIconButtonState.defaultState,
                    onTap: onBackPressed,
                  ),
                ),
              if (badgeText != null && badgeText!.isNotEmpty)
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: BadgeLabel(
                    content: badgeText!,
                    badgeIcon: badgeIcon,
                    variant: BadgeLabelVariant.white,
                    size: BadgeLabelSize.large,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
