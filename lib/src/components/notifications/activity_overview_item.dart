import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

/// A customizable activity overview item widget that displays a social media-style card
/// with an image, icon, count, title, reactions count, and user images.
class ActivityOverviewItem extends StatelessWidget {
  const ActivityOverviewItem({
    super.key,
    this.image,
    this.onError,
    required this.icon,
    required this.count,
    required this.title,
    required this.reactionsCount,
    required this.userImages,
    this.width = 53,
    this.height = 68,
    this.borderRadius = 12.0,
    this.elevation = 4.0,
    this.borderWidth = 2.0,
    this.maxUserImages = 2,
  });

  /// Image provider for the main image to display
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Icon widget to display in the top-right corner
  final Widget icon;

  /// The count number to display below the image
  final int count;

  /// The title text to display below the count
  final String title;

  /// The reactions count to display at the bottom
  final int reactionsCount;

  /// List of user images to display at the bottom right
  final List<ImageProvider> userImages;

  /// Width of the widget
  final double width;

  /// Height of the widget
  final double height;

  /// Border radius for the card
  final double borderRadius;

  /// Elevation of the card
  final double elevation;

  /// Border width
  final double borderWidth;

  /// Maximum number of user images to display
  final int maxUserImages;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final imageBorderRadius = BorderRadius.all(Radius.circular(borderRadius));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Card(
          elevation: elevation,
          child: Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                width: width,
                height: height,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: imageBorderRadius,
                  image: (image != null)
                    ? DecorationImage(
                        image: image!,
                        fit: BoxFit.cover,
                        onError: (exception, stackTrace) {
                          onError?.call(exception, stackTrace);
                        },
                      )
                    : null,
                ),
              ),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: imageBorderRadius,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 0.5],
                      colors: [
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: width,
                height: height,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: imageBorderRadius,
                    side: BorderSide(
                        color: Colors.white60,
                        width: borderWidth,
                        strokeAlign: BorderSide.strokeAlignInside),
                  ),
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: theme.colors.bgBase,
                  child: Container(
                    margin: const EdgeInsets.all(1),
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: theme.colors.bgSecondaryBtn,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SizedBox(
                        width: 14,
                        height: 14,
                        child: icon,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatCount(count),
              maxLines: 1,
              style: theme.typo.main.labelDefaultBold.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.main.labelDefaultBold.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '+${formatCount(reactionsCount)}',
                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: theme.colors.labelHighlight,
                  ),
                ),
                const SizedBox(width: 4),
                if (userImages.isNotEmpty)
                  SizedBox(
                    width: _calculateUserImagesWidth(
                        userImages.take(maxUserImages).length),
                    height: 17,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: userImages
                          .take(maxUserImages)
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                        final index = entry.key;
                        final image = entry.value;
                        final leftOffset = index * 10.0;

                        return Positioned(
                          left: leftOffset,
                          child: SizedBox(
                            width: 17,
                            height: 17,
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: theme.colors.bgBase,
                                border: Border.all(
                                  color: theme.colors.bgBase,
                                  width: 1,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: FadeInImage(
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: image,
                                  fit: BoxFit.cover,
                                  imageErrorBuilder:
                                      (context, error, stackTrace) {
                                    return Container(
                                      color: theme.colors.bgContainerSecondary,
                                      child: Icon(
                                        Icons.person,
                                        size: 12,
                                        color: theme.colors.textTertiary,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  String formatCount(int count) {
    if (count >= 1000000000) {
      return '${(count / 1000000000).toStringAsFixed(1)}B';
    } else if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }

  /// Calculates the total width needed for the user images stack
  /// Each image is 17px wide, and they overlap by 7px
  /// So: first image = 17px, each additional image = +10px
  double _calculateUserImagesWidth(int imageCount) {
    if (imageCount <= 0) return 0;
    return 17.0 + ((imageCount - 1) * 10.0);
  }
}
