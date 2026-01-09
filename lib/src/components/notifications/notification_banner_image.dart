import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class NotificationBannerImage extends StatelessWidget {
  const NotificationBannerImage({
    super.key,
    required this.imageProvider,
    this.imageSize,
    this.imgPadding = 20,
    required this.title,
    this.description,
    this.appendedDescription,
    this.actionButtonText,
    this.actionBtnSize = DotsMainButtonSize.medium,
    this.onActionTap,
    this.onClose,
    this.showCloseButton = true,
    this.isBtnActive = true,
  });

  /// The image to display in the notification banner.
  final ImageProvider imageProvider;

  /// The size of the image (width and height).
  final double? imageSize;

  /// The horizontal padding around the image.
  final double imgPadding ;

  /// The title text shown in the banner.
  final String title;

  /// The description text shown in the banner.
  final String? description;

  /// An optional appended description.
  final String? appendedDescription;

  /// The text for the action button.
  final String? actionButtonText;

  /// The size of the action button (default `DotsMainButtonSize.medium`).
  final DotsMainButtonSize actionBtnSize;

  /// Whether the action button is active (default `true`).
  final bool isBtnActive;

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

    final container = Container(
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: imgPadding),
                  child: imageSize != null
                    ? Image(
                        image: imageProvider,
                        width: imageSize,
                        height: imageSize,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      )
                    : Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => const SizedBox(),
                      ),
                ),
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    spacing: 12,
                    children: [
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
                      if (description?.isNotEmpty == true)
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: description!,
                                style: theme.typo.main.bodyDefaultRegular.copyWith(
                                  color: theme.colors.textTertiary,
                                ),
                              ),
                              if (appendedDescription?.isNotEmpty == true)
                                TextSpan(
                                  text: ' ${appendedDescription!}',
                                  style: theme.typo.main.bodyDefaultRegular.copyWith(
                                    color: theme.colors.labelHighlight,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      if (actionButtonText?.isNotEmpty == true)
                        Center(
                          child: DotsMainButton(
                            content: actionButtonText!,
                            onTap: onActionTap,
                            size: actionBtnSize,
                            variant: isBtnActive ? 
                              DotsMainButtonVariant.main : 
                              DotsMainButtonVariant.secondary,
                            expand: false,
                          ),
                        ),
                    ],
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

    return onActionTap != null
        ? GestureDetector(
            onTap: onActionTap,
            child: container,
          )
        : container;
  }
}
