import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/extensions/media_query_data_extensions.dart';
import 'package:flutter/material.dart';

class DotsEmptyStateCard extends StatelessWidget {
  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;

  /// Title of the empty state card.
  final String title;

  /// Description of the empty state card.
  final String description;

  /// Icon to display in the empty state card.
  final DotsMainButton? button;

  const DotsEmptyStateCard({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.description,
    this.button,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final aspectRatio = MediaQuery.of(context).aspectRatio;

    return Container(
      width: aspectRatio > 16
        ? screenWidth * 0.8205
        : screenWidth * 0.9,
      padding: EdgeInsets.symmetric(horizontal: aspectRatio > 16 ? 20 : 12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: imageProvider,
          ),
          const SizedBox(height: 4),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: aspectRatio > 16 ? 20 : 12),
            child: Text(
              title,
              style: theme.typo.secondary.title02H6.copyWith(
                color: theme.colors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: theme.typo.main.labelDefaultRegular.copyWith(
              color: theme.colors.textQuarternary,
            ),
            textAlign: TextAlign.center,
          ),
          if (button != null) ...[
            SizedBox(height: aspectRatio > 16 ? 16 : 10),
            button!,
          ],
        ],
      ),
    );
  }
}