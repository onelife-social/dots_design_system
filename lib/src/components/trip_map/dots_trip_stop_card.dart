import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

const double _kCardWidth = 160;
const double _kThumbnailSize = 42;
const int _kMaxThumbnails = 4;

/// A summary card for one stop of a trip: memory miniatures + title + count.
class DotsTripStopCard extends StatelessWidget {
  const DotsTripStopCard({
    required this.thumbnails,
    required this.memoryCount,
    this.title,
    this.onTap,
    this.accentColor,
    super.key,
  });

  /// Image widgets for the memories at this stop, most recent first.
  ///
  /// Only the first four are shown; use [memoryCount] for the true total.
  final List<Widget> thumbnails;

  /// Total memories at this stop, which may exceed [thumbnails.length].
  final int memoryCount;

  /// Optional place label shown below the thumbnails.
  final String? title;

  final VoidCallback? onTap;

  /// Defaults to [DotsColorsModel.labelHighlight].
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      child: DotsDecoratedBox(
        styleType: theme.styles.defaultShadow,
        decoration: BoxDecoration(
          borderRadius: DotsBorderRadius.r16,
          color: theme.colors.bgContainerPrimary,
        ),
        child: Container(
          width: _kCardWidth,
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _StopThumbnailsRow(
                thumbnails: thumbnails,
                memoryCount: memoryCount,
                accentColor: accentColor ?? theme.colors.labelHighlight,
              ),
              const SizedBox(height: 8),
              if (title != null) ...[
                Text(
                  title!,
                  style: theme.typo.main.labelDefaultMedium.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
              ],
              Text(
                '$memoryCount photos',
                style: theme.typo.main.labelSmallRegular.copyWith(
                  color: theme.colors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StopThumbnailsRow extends StatelessWidget {
  const _StopThumbnailsRow({
    required this.thumbnails,
    required this.memoryCount,
    required this.accentColor,
  });

  final List<Widget> thumbnails;
  final int memoryCount;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    if (thumbnails.isEmpty) {
      return ClipRRect(
        borderRadius: DotsBorderRadius.r8,
        child: Container(
          width: _kThumbnailSize,
          height: _kThumbnailSize,
          color: theme.colors.fillSecondary,
        ),
      );
    }

    final shown = thumbnails.take(_kMaxThumbnails).toList();
    final remaining = memoryCount - shown.length;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < shown.length; i++) ...[
          if (i > 0) const SizedBox(width: 6),
          _StopThumbnail(
            image: shown[i],
            badgeCount: (i == shown.length - 1 && remaining > 0) ? remaining : null,
            accentColor: accentColor,
          ),
        ],
      ],
    );
  }
}

class _StopThumbnail extends StatelessWidget {
  const _StopThumbnail({
    required this.image,
    required this.badgeCount,
    required this.accentColor,
  });

  final Widget image;
  final int? badgeCount;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final badgeCount = this.badgeCount;

    return SizedBox(
      width: _kThumbnailSize,
      height: _kThumbnailSize,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(borderRadius: DotsBorderRadius.r8, child: image),
          if (badgeCount != null)
            ClipRRect(
              borderRadius: DotsBorderRadius.r8,
              child: Container(
                color: accentColor.dotsWithOpacity(0.85),
                alignment: Alignment.center,
                child: Text(
                  '+$badgeCount',
                  style: theme.typo.main.labelSmallBold.copyWith(
                    color: theme.colors.labelAlwaysWhite,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
