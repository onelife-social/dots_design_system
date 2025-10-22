import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

/// A customizable activity overview item widget that displays a social media-style card
/// with an image, icon, count, title, reactions count, and user images.
class ActivityOverviewItem extends StatelessWidget {
  const ActivityOverviewItem({
    super.key,
    this.images,
    this.onError,
    required this.icon,
    required this.variant,
    required this.count,
    required this.title,
    required this.reactionsCount,
    required this.userImages,
    this.width = 53,
    this.height = 68,
    this.borderRadius = 12.0,
    this.elevation = 4.0,
    this.borderWidth = 1.0,
    this.maxUserImages = 2,
  });

  /// List of Image providers for the main images to display
  final List<ImageProvider>? images;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Icon widget to display in the top-right corner
  final Widget icon;

  /// The variant of the activity preview.
  final ActivityPreviewVariant variant;
  
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
    final bgBadgeColor = _backgroundColor(theme, variant);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.center,
          children: [
            if (images != null && images!.length > 1)
              Transform(
                alignment: Alignment.bottomRight,
                transform: Matrix4.identity()..rotateZ(-0.087),
                child: Stack(
                  children: [
                    Container(
                      width: width,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: imageBorderRadius,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0x26000000),
                            blurRadius: 10,
                            offset: const Offset(-6, 5),
                          ),
                        ],
                        image: (images != null && images!.isNotEmpty)
                            ? DecorationImage(
                                image: images!.last,
                                fit: BoxFit.cover,
                                onError: (exception, stackTrace) {
                                  onError?.call(exception, stackTrace);
                                },
                              )
                            : null,
                      ),
                    ),
                    Container(
                      width: width,
                      height: height,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          borderRadius: imageBorderRadius,
                          side: BorderSide(
                            color: const Color(0x4DFFFFFF),
                            width: borderWidth,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                borderRadius: imageBorderRadius,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x26000000),
                    blurRadius: 6,
                    offset: const Offset(0, 6),
                  ),
                ],
                image: (images != null && images!.isNotEmpty)
                    ? DecorationImage(
                        image: images!.first,
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
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.5],
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
                    color: const Color(0x4DFFFFFF),
                    width: borderWidth,
                    strokeAlign: BorderSide.strokeAlignInside,
                  ),
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
                  margin: const EdgeInsets.all(1.5),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: bgBadgeColor,
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
        const SizedBox(height: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              formatCount(count),
              maxLines: 1,
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            const SizedBox(height: 2),
            if (reactionsCount > 0)
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
                      width: _calculateUserImagesWidth(userImages.take(maxUserImages).length),
                      height: 17,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children:
                            userImages.take(maxUserImages).toList().asMap().entries.map((entry) {
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
                                    imageErrorBuilder: (context, error, stackTrace) {
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


Color _backgroundColor(DotsTheme theme, ActivityPreviewVariant variant) {
    switch (variant) {
      case ActivityPreviewVariant.reactions:
        return theme.colors.friends001;
      case ActivityPreviewVariant.views:
        return theme.colors.hobby002;
      case ActivityPreviewVariant.favs:
        return theme.colors.couple001;
      
    }
  }
