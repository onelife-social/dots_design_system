import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookOrderItem extends StatelessWidget {
  // The image of the order item.
  final ImageProvider dotbookImage;

  /// Default image path to be used when the image fails to load.
  final String? defaultImagePath;

  /// Callback for image load errors.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  // The title of the album.
  final String title;

  // The date of the order.
  final String subtitle;

  // The text of the order status.
  final String labelText;

  // The visual variant of the order status label.
  final BadgeLabelVariant labelVariant;

  // An optional icon to display on the right side of the order item.
  final DotsIcon? rightIcon;

  // An optional callback to be invoked when the order item is tapped.
  final VoidCallback? onItemTap;

  const DotbookOrderItem({
    super.key,
    required this.dotbookImage,
    this.defaultImagePath,
    this.onError,
    required this.title,
    required this.subtitle,
    required this.labelText,
    required this.labelVariant,
    this.rightIcon,
    this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onItemTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          Container(
            width: 72,
            height: 72,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: theme.colors.bgContainerSecondary,
              borderRadius: BorderRadius.circular(13.45),
            ),
            child: Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Positioned(
                  top: 9.09,
                  left: 8.78,
                  right: 9,
                  child: Image(
                    image: dotbookImage,
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, err, trace) {
                      onError?.call(err, trace);
                      if (defaultImagePath != null) {
                        return Image.asset(
                          defaultImagePath!,
                          fit: BoxFit.cover,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typo.main.bodyLargeMedium.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.typo.main.labelDefaultRegular.copyWith(
                    color: theme.colors.textTertiary,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: BadgeLabel(
                    content: labelText,
                    size: BadgeLabelSize.small,
                    variant: labelVariant,
                  ),
                ),
              ],
            ),
          ),
          rightIcon ??
              DotsIcon(
                iconData: DotsIconData.chevronRight,
                size: 16,
                color: theme.colors.textTertiary,
              ),
        ],
      ),
    );
  }
}
