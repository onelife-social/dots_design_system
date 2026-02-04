import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class MilestoneCard extends StatelessWidget {
  /// The width of the card.
  final double width;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Callback when an error occurs while loading the image.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Title of the card.
  final String? title;

  /// The date of the milestone.
  final String? date;

  /// Callback when the image is tapped.
  final VoidCallback? onTap;

  /// Whether to show the badge on the card.
  final bool showBadge;

  /// Whether to show the edit button on the card.
  final bool showEdit;

  /// Callback when the edit button is tapped.
  final VoidCallback? onEdit;

  const MilestoneCard._({
    required this.width,
    required this.imageProvider,
    this.errorBuilder,
    this.title,
    this.date,
    this.onTap,
    
  });

  factory MilestoneCard.blocked({
    required double width,
    required ImageProvider imageProvider,
    required String buttonText,
    required Function()? onTap,
    required Function()? onInfoTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
    ImageProvider? textImageProvider,
  }) => MilestoneCard._(
    variant: MilestoneVariant.blocked,
    width: width,
    imageProvider: imageProvider,
    textImageProvider: textImageProvider,
    buttonText: buttonText,
    onTap: onTap,
    onInfoTap: onInfoTap,
    errorBuilder: errorBuilder,
    title: title,
  );

  factory MilestoneCard.active({
    required double width,
    required ImageProvider imageProvider,
    required String buttonText,
    required Function()? onTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
    String? badgeText,
    ImageProvider? textImageProvider,
  }) => MilestoneCard._(
    variant: MilestoneVariant.active,
    width: width,
    imageProvider: imageProvider,
    textImageProvider: textImageProvider,
    buttonText: buttonText,
    onTap: onTap,
    errorBuilder: errorBuilder,
    title: title,
    badgeText: badgeText,
  );

  factory MilestoneCard.generated({
    required double width,
    required ImageProvider imageProvider,
    required String createdBy,
    required String albumName,
    required Function()? onTap,
    required Function() onInfoTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
    ImageProvider? textImageProvider,
    String? badgeText,
  }) => MilestoneCard._(
    variant: MilestoneVariant.generated,
    width: width,
    imageProvider: imageProvider,
    textImageProvider: textImageProvider,
    createdBy: createdBy,
    albumName: albumName,
    onTap: onTap,
    onInfoTap: onInfoTap,
    errorBuilder: errorBuilder,
    title: title,
    badgeText: badgeText,
  );

  factory MilestoneCard.onlyTitle({
    required double width,
    required ImageProvider imageProvider,
    ImageErrorWidgetBuilder? errorBuilder,
    ImageProvider? textImageProvider,
  }) => MilestoneCard._(
    variant: MilestoneVariant.active,
    width: width,
    imageProvider: imageProvider,
    textImageProvider: textImageProvider,
    errorBuilder: errorBuilder,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final imageWidget = Image(
      image: imageProvider,
      fit: BoxFit.cover,
      width: double.infinity,
      height: double.infinity,
      errorBuilder: errorBuilder,
    );

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: width,
        child: AspectRatio(
          aspectRatio: 4 / 5,
          child: DotsDecoratedBox(
            styleType: theme.styles.defaultShadow,
            child: DotsDecoratedBox(
              styleType: theme.styles.squircle52,
              child: Stack(
                children: [
                  variant.isBlocked
                      ? ImageFiltered(
                          imageFilter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                          child: imageWidget,
                        )
                      : imageWidget,
                  Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: DotsBorderRadius.r52,
                        side: BorderSide(
                          color: theme.colors.borderButton,
                          width: 2,
                          strokeAlign: BorderSide.strokeAlignInside,
                        ),
                      ),
                      color: Colors.black.withValues(alpha: 0.3),
                    ),
                    child: Stack(
                      children: [
                        if (textImageProvider != null)
                          Positioned.fill(
                            child: Image(
                              image: textImageProvider!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                            ),
                          ),
                        _buildContent(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final theme = context.dotsTheme;
    return Padding(
      padding: EdgeInsets.all(24),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _RecapCardTitle(title: title),
                if (!variant.isBlocked && badgeText != null && badgeText!.isNotEmpty)
                  BadgeLabel(
                    content: badgeText!,
                    variant: BadgeLabelVariant.premium,
                    size: BadgeLabelSize.large,
                  ),
                if (variant.isGenerated && badgeText == null)
                  DotsIconButton(
                    icon: DotsIconData.share,
                    onTap: onInfoTap,
                    style: DotsIconButtonStyle.floating,
                    size: DotsIconButtonSize.large,
                    state: DotsIconButtonState.defaultState,
                    color: theme.colors.textPrimary,
                  ),
                if (variant.isBlocked)
                  DotsIconButton(
                    icon: DotsIconData.lock,
                    onTap: onInfoTap,
                    style: DotsIconButtonStyle.floating,
                    size: DotsIconButtonSize.large,
                    state: DotsIconButtonState.defaultState,
                    color: theme.colors.textPrimary,
                    backgroundColor: theme.colors.bgBtnImage.withValues(
                      alpha: 0.5,
                    ),
                  ),
              ],
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: variant.isGenerated
                ? _CreatedByText(
                    createdBy: createdBy,
                    albumName: albumName,
                  )
                : buttonText == null
                ? const SizedBox.shrink()
                : DotsMainButton(
                    content: buttonText ?? '',
                    variant: DotsMainButtonVariant.main,
                    expand: false,
                    onTap: onTap,
                    shouldApplyBlur: true,
                  ),
          ),
        ],
      ),
    );
  }
}

class _RecapCardTitle extends StatelessWidget {
  final String? title;

  const _RecapCardTitle({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return title == null || title!.isEmpty
        ? const SizedBox.shrink()
        : Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 4,
            children: [
              DotsIcon(
                iconData: DotsIconData.clockTimer,
                size: 16,
                color: theme.colors.labelAlwaysWhite,
              ),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: theme.typo.main.bodyDefaultMedium.copyWith(
                  color: theme.colors.labelAlwaysWhite,
                ),
              ),
            ],
          );
  }
}

class _CreatedByText extends StatelessWidget {
  final String? createdBy;
  final String? albumName;

  const _CreatedByText({
    required this.createdBy,
    required this.albumName,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (albumName != null && albumName!.isNotEmpty)
          Text(
            albumName!,
            textAlign: TextAlign.center,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: theme.colors.labelAlwaysWhite,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        if (createdBy != null && createdBy!.isNotEmpty)
          Text(
            createdBy!,
            textAlign: TextAlign.center,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: theme.colors.labelAlwaysWhite,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
      ],
    );
  }
}
