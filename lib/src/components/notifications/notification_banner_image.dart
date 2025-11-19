import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class NotificationBannerImage extends StatelessWidget {
  const NotificationBannerImage({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.actionButtonText,
    this.onActionTap,
    this.onClose,
    this.showCloseButton = true,
  });

  /// The image to display in the notification banner.
  final ImageProvider imageProvider;

  /// The title text shown in the banner.
  final String title;

  /// The text for the action button.
  final String actionButtonText;

  /// Callback when the action button is tapped.
  final VoidCallback? onActionTap;

  /// Callback when the close button is tapped.
  final VoidCallback? onClose;

  /// Whether to show the close button.
  ///
  /// Defaults to `true`.
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 16.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: imageProvider,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => SizedBox(),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.typo.main.titleH6.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: DotsMainButton(
                    content: actionButtonText,
                    onTap: onActionTap,
                    size: DotsMainButtonSize.medium,
                    variant: DotsMainButtonVariant.main,
                    expand: false,
                  ),
                ),
              ],
            ),
          ),
          if (showCloseButton) ...[
            Positioned(
              top: 12,
              right: 12,
              child: DotsCloseButton(
                icon: DotsIconData.cross,
                size: DotsCloseButtonSize.medium,
                variant: DotsCloseButtonVariant.softContrast,
                onTap: onClose,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
