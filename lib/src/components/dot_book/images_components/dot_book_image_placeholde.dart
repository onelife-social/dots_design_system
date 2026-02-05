import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotBookImagePlaceholder extends StatelessWidget {
  /// Image provider to display in the card.
  final ImageProvider imageProvider;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Border radius, by default 32.
  final BorderRadius borderRadius;

  /// Optional badge text to display over the image (bottom-left).
  final String? sizeText;

  /// Optional background color for the badge. Defaults to semi-transparent black.
  final Color? badgeBackgroundColor;

  /// Optional border color for the badge. Defaults to white.
  final Color? badgeBorderColor;

  /// Optional handler for back button tap. Defaults to `Navigator.maybePop`.
  final Function()? onBackPressed;

  /// Optional icon for the back button. Defaults to `DotsIconData.chevronLeft`.
  final DotsIconData? backIcon;

  const DotBookImagePlaceholder({
    super.key,
    required this.imageProvider,
    this.onError,
    this.borderRadius = const BorderRadius.all(Radius.circular(32.0)),
    this.sizeText,
    this.badgeBackgroundColor,
    this.badgeBorderColor,
    this.onBackPressed,
    this.backIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 6 / 7,
        child: ClipRRect(
          borderRadius: borderRadius,
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image(
                image: imageProvider,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  if (onError != null) onError!(error, stackTrace);
                  return const SizedBox();
                },
              ),
              if (onBackPressed != null)
                Positioned(
                  left: 12,
                  top: 10,
                  child: DotsIconButton(
                    icon: backIcon ?? DotsIconData.chevronLeft,
                    size: DotsIconButtonSize.medium,
                    style: DotsIconButtonStyle.floating,
                    state: DotsIconButtonState.defaultState,
                    onTap: onBackPressed
                  ),
                ),
              if (sizeText != null && sizeText!.isNotEmpty)
                Positioned(
                  left: 16,
                  bottom: 16,
                  child: BadgeLabel(
                    content: sizeText!,
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