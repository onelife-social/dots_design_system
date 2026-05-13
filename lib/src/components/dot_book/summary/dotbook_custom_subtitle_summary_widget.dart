import 'package:flutter/material.dart';

import '../../../../dots_design_system.dart';

class DotbookCustomSubtitleSummaryWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final int quantity;
  final String title;

  const DotbookCustomSubtitleSummaryWidget({
    super.key, 
    this.onTap,
    required this.quantity,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      onTap: onTap,
      child: Expanded(
          child: Row(
            spacing: 4,
            children: [
              Text(
                '${quantity}x',
                style: theme.typo.main.bodyDefaultRegular.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
              Image.asset( 
                '${ImagesPaths.imagesIcons}/icon_prime_circle.webp',
                width: 12,
                height: 12,
              ),
              Text(
                title,
                style: theme.typo.main.bodyDefaultRegular.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
              DotsIcon(
                iconData: DotsIconData.helpCircle,
                color: theme.colors.textTertiary,
                size: 14,
              ),
            ],
          ),
        ),
    );
  }
}