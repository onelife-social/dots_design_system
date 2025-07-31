import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A notification banner component that displays important information
/// with an optional action button and close functionality.
class NotificationBanner extends StatelessWidget {
  const NotificationBanner({
    super.key,
    required this.title,
    this.body,
    this.actionButtonText,
    this.onActionTap,
    this.onClose,
    this.showCloseButton = true,
  });

  /// The title text displayed at the top of the banner.
  final String title;

  /// The body text displayed below the title.
  final String? body;

  /// The text for the action button. If null, no action button will be shown.
  final String? actionButtonText;

  /// Callback when the action button is tapped.
  final VoidCallback? onActionTap;

  /// Callback when the close button is tapped.
  final VoidCallback? onClose;

  /// Whether to show the close button. Defaults to true.
  final bool showCloseButton;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondary,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, bottom: 16.0, left: 20.0, right: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and close button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: theme.typo.main.labelDefaultBold.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Body text
                if (body != null) ...[
                  Text(
                    body!,
                    textAlign: TextAlign.center,
                    style: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textSecondary,
                    ),
                  ),
                ],

                // Action button
                if (actionButtonText != null) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: DotsMainButton(
                      content: actionButtonText!,
                      onTap: onActionTap,
                      size: DotsMainButtonSize.small,
                      variant: DotsMainButtonVariant.main,
                      expand: false,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showCloseButton) ...[
            Positioned(
              top: 12,
              right: 12,
              child: DotsCloseButton(
                icon: DotsIconData.cross,
                size: DotsCloseButtonSize.small,
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
