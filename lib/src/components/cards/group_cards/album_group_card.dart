import 'package:dots_design_system/dots_design_system.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

enum AlbumGroupCardVariant {
  small,
  large;

  bool get isSmall => this == AlbumGroupCardVariant.small;
  bool get isLarge => this == AlbumGroupCardVariant.large;
}

class AlbumGroupCard extends StatelessWidget {
  /// The variant of the group card.
  final AlbumGroupCardVariant variant;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Title that will be displayed at the bottom of the card.
  final String title;

  /// The icon data for the Card tag.
  final DotsIconData? tagIconData;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The sigma value for the blur effect.
  final double? blurSigma;

  /// The size of the edge blur effect.
  final double? edgeSize;

  /// Indicates if the group is blocked.
  final bool isBlocked;

  const AlbumGroupCard({
    super.key,
    required this.imageProvider,
    required this.title,
    this.variant = AlbumGroupCardVariant.small,
    this.tagIconData,
    this.onTap,
    this.onError,
    this.blurSigma,
    this.edgeSize,
    this.isBlocked = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final DotsStyleSquircle styleType = variant.isLarge
        ? theme.styles.squircle52
        : theme.styles.squircle32;
    final double bottomBlurHeight = edgeSize ?? (variant.isLarge ? 110 : 60);

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          constraints: BoxConstraints(
            minWidth: variant.isSmall ? 135 : 288,
            minHeight: variant.isSmall ? 135 : 288,
            maxHeight: variant.isSmall ? 160 : kAlbumLargeCardSize,
            maxWidth: variant.isSmall ? 160 : kAlbumLargeCardSize,
          ),
          child: DotsDecoratedBox(
            styleType: styleType,
            child: Stack(
              children: [
                ClipSmoothRect(
                  radius: SmoothBorderRadius(
                    cornerRadius: styleType.radius,
                    cornerSmoothing: styleType.cornerSmoothing,
                  ),
                  child: SoftEdgeBlur(
                    edges: [
                      EdgeBlur(
                        type: EdgeType.bottomEdge,
                        size: bottomBlurHeight,
                        sigma: blurSigma ?? 12,
                        controlPoints: [
                          ControlPoint(
                            position: 0.5,
                            type: ControlPointType.visible,
                          ),
                          ControlPoint(
                            position: 1,
                            type: ControlPointType.transparent,
                          ),
                        ],
                      ),
                    ],
                    child: Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        if (onError != null) onError!(error, stackTrace);
                        return SizedBox();
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IgnorePointer(
                    child: Container(
                      height: bottomBlurHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.0),
                            Color.fromARGB(255, 0, 0, 0).withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(variant.isSmall ? 16 : 24),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          title,
                          textAlign: TextAlign.center,
                          style:
                              (variant.isSmall
                                      ? theme.typo.main.bodyDefaultMedium
                                      : theme.typo.main.bodyLargeMedium)
                                  .copyWith(color: theme.colors.labelAlwaysWhite),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      if (!isBlocked && tagIconData != null)
                        Positioned(
                          left: 0,
                          top: 0,
                          child: CardTag(
                            iconData: tagIconData!,
                            size: 28,
                            iconSize: 20,
                          ),
                        ),
                      if (isBlocked)
                        Positioned.fill(
                          child: Center(
                            child: DotsIcon(
                              iconData: DotsIconData.lock,
                              size: 32,
                              color: theme.colors.labelAlwaysWhite,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
