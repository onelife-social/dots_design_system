import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class PromptCard extends StatelessWidget {
  const PromptCard({
    super.key,
    required this.title,
    required this.icon,
    required this.primaryColor,
    required this.secondaryColor,
    this.width = 164,
    this.onTap,
  });

  /// The text to display at the bottom of the card.
  final String title;

  /// The icon to display in the top-left corner.
  final DotsIconData icon;

  /// The primary color for the gradient (left).
  final Color primaryColor;

  /// The secondary color for the gradient (right).
  final Color secondaryColor;

  /// The width of the card.
  final double width;

  /// Callback when the card is tapped.
  final VoidCallback? onTap;
  static const double _height = 112;
  static const double _borderRadius = 24;
  static const double _iconContainerSize = 36;
  static const double _iconSize = 32;
  static const double _iconContainerIconSize = 20;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_borderRadius),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [primaryColor, secondaryColor],
          ),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DotsIcon(
                    iconData: icon,
                    size: _iconSize,
                  ),
                  const Spacer(),
                  Text(
                    title,
                    style: theme.typo.main.bodyLargeMedium.copyWith(
                      color: theme.colors.labelAlwaysWhite,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Positioned(
              right: 11,
              top: 11,
              child: _IconContainer(
                icon: DotsIconData.add,
                size: _iconContainerSize,
                iconSize: _iconContainerIconSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconContainer extends StatelessWidget {
  const _IconContainer({
    required this.icon,
    required this.size,
    required this.iconSize,
  });

  final DotsIconData icon;
  final double size;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: theme.colors.bgBtnImage.dotsWithOpacity(0.4),
        borderRadius: BorderRadius.circular(size),
      ),
      child: Center(
        child: DotsIcon(
          iconData: icon,
          color: theme.colors.labelAlwaysWhite,
          size: iconSize,
        ),
      ),
    );
  }
}
