import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsActionSheetSpotlightVariant {
  alert,
  user,
  album;
}

class DotsActionSheetSpotlight extends StatelessWidget {
  /// Main title text displayed prominently in the action sheet
  final String title;

  /// Optional label text displayed below the title
  final String? label;

  /// Optional body title for alert variant, displayed in a bordered container
  final String? bodyTitle;

  /// Optional description text displayed below the title/label
  final String? description;

  /// Image provider for the main image displayed at the top
  final ImageProvider image;

  /// Callback function called when the close button is tapped
  final VoidCallback? onClose;

  /// Primary action button widget displayed at the bottom
  final Widget primaryButton;

  /// Visual variant that determines the layout and styling
  final DotsActionSheetSpotlightVariant variant;

  /// Icon data for the icon displayed on the image
  final DotsIconData iconData;

  /// Width of the image in pixels
  final double imageWidth;

  /// Height of the image in pixels
  final double imageHeight;

  /// Size of the icon in pixels
  final double iconSize;

  /// Offset for positioning the icon on the image
  final double iconOffset;

  const DotsActionSheetSpotlight({
    super.key,
    required this.variant,
    required this.title,
    this.label,
    this.bodyTitle,
    this.description,
    required this.image,
    this.onClose,
    required this.primaryButton,
    this.imageWidth = 96,
    this.imageHeight = 96,
    this.iconData = DotsIconData.heart,
    this.iconSize = 20,
    this.iconOffset = 4,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final double bottomPosition = 56;
    final bool showCloseButton = variant != DotsActionSheetSpotlightVariant.user && onClose != null;
    final description = variant == DotsActionSheetSpotlightVariant.alert ? null : this.description;

    final topWidget = ImageWithIcon(
      image: image,
      icon: DotsIcon(iconData: iconData),
      width: imageWidth,
      height: variant == DotsActionSheetSpotlightVariant.user ? imageWidth : imageHeight,
      iconSize: iconSize,
      iconOffset: iconOffset,
      circularImage: variant == DotsActionSheetSpotlightVariant.user,
    );
    final bottomWidget = variant == DotsActionSheetSpotlightVariant.alert
        ? Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: context.dotsTheme.colors.bgContainerSecondary),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (bodyTitle != null)
                  Text(bodyTitle!,
                      textAlign: TextAlign.center,
                      style: context.dotsTheme.typo.main.bodyLargeBold),
                SizedBox(height: bodyTitle != null && this.description != null ? 6 : 0),
                if (this.description != null)
                  Text(this.description!,
                      textAlign: TextAlign.center,
                      style: context.dotsTheme.typo.main.bodyDefaultRegular),
              ],
            ),
          )
        : null;

    return Stack(
      children: [
        GestureDetector(
          onTap: onClose,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(
              color: Color(0xFF000000).dotsWithOpacity(0.3),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: bottomPosition,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.8,
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: theme.colors.bgBaseContrast,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Container(
                              width: 36,
                              height: 4,
                              decoration: ShapeDecoration(
                                color: theme.colors.bgSecondaryBtn,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.50),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          topWidget,
                          SizedBox(height: 20),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(title,
                                    textAlign: TextAlign.center,
                                    style: theme.typo.secondary.title02H6),
                              ),
                              if (label != null) ...[
                                SizedBox(height: 4),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(label!,
                                      textAlign: TextAlign.center,
                                      style: theme.typo.main.labelDefaultMedium.copyWith(
                                        color: theme.colors.textTertiary,
                                        fontSize: 13,
                                      )),
                                ),
                              ],
                              if (description != null) ...[
                                SizedBox(height: 12),
                                SizedBox(
                                  width: double.infinity,
                                  child: Text(description,
                                      textAlign: TextAlign.center,
                                      style: theme.typo.main.bodyDefaultRegular.copyWith(
                                        color: theme.colors.textSecondary,
                                      )),
                                ),
                                SizedBox(height: 28),
                              ],
                            ],
                          ),
                          if (bottomWidget != null) ...[
                            SizedBox(height: 16),
                            bottomWidget,
                            SizedBox(height: 20),
                          ],
                          SizedBox(height: 20),
                          primaryButton,
                        ],
                      ),
                    ),
                    if (showCloseButton)
                      Positioned(
                        top: 12,
                        right: 0,
                        child: DotsCloseButton(
                            onTap: onClose,
                            size: DotsCloseButtonSize.medium,
                            variant: DotsCloseButtonVariant.softContrast),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
        _BackdropFilterMask(bottomPosition: bottomPosition),
        _LinearBlurMask(bottomPosition: bottomPosition),
        Positioned(
          left: 16,
          right: 16,
          bottom: bottomPosition + 16,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DotsActionSheetStandardButtons(
              buttonPositioning: DotsActionSheetButtonPositioning.row,
              primaryButton: primaryButton,
            ),
          ),
        ),
      ],
    );
  }
}

class _LinearBlurMask extends StatelessWidget {
  final double bottomPosition;

  const _LinearBlurMask({required this.bottomPosition});

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    final theme = context.dotsTheme;

    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPosition,
      child: ClipRRect(
        borderRadius: DotsBorderRadius.bottom32,
        child: SizedBox(
          height: totalHeight,
          child: CustomPaint(
            size: Size(double.infinity, totalHeight),
            painter: LinearBlurPainter(
              topColor: theme.colors.gradientInitialLineal,
              bottomColor: theme.colors.gradientFinalLineal,
            ),
          ),
        ),
      ),
    );
  }
}

class _BackdropFilterMask extends StatelessWidget {
  final double bottomPosition;

  const _BackdropFilterMask({required this.bottomPosition});

  @override
  Widget build(BuildContext context) {
    final totalHeight = DotsMainButtonSize.mainAction.height + 26;
    return Positioned(
      left: 16,
      right: 16,
      bottom: bottomPosition,
      child: ClipRRect(
        borderRadius: DotsBorderRadius.bottom32,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 12),
          child: Container(
            height: totalHeight / 2,
            color: context.dotsTheme.colors.transparent,
          ),
        ),
      ),
    );
  }
}
