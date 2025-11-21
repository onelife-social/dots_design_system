import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum RecapCardVariant {
  blocked,
  active,
  generated;

  bool get isBlocked => this == RecapCardVariant.blocked;
  bool get isActive => this == RecapCardVariant.active;
  bool get isGenerated => this == RecapCardVariant.generated;
}

class RecapCard extends StatelessWidget {
  /// The width of the card.
  final double width;

  /// The variant of the group card.
  final RecapCardVariant variant;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// Button text that will be displayed at the bottom of the card.
  final String? buttonText;

  /// The text to display on the badge label.
  final String? badgeText;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when the info icon is tapped.
  final Function()? onInfoTap;

  /// Title of the recap card.
  final String? title;

  /// The name of the album.
  final String? albumName;

  /// The name of the user who created the album.
  final String? createdBy;

  /// Callback when an error occurs while loading the image.
  final ImageErrorWidgetBuilder? errorBuilder;

  // private constructor
  const RecapCard._({
    required this.variant,
    required this.width,
    required this.imageProvider,
    this.buttonText,
    this.badgeText,
    this.title,
    this.albumName,
    this.createdBy,
    this.onTap,
    this.onInfoTap,
    this.errorBuilder,
  });

  factory RecapCard.blocked({
    required double width,
    required ImageProvider imageProvider,
    required String buttonText,
    required Function()? onTap,
    required Function()? onInfoTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
  }) => RecapCard._(
    variant: RecapCardVariant.blocked,
    width: width,
    imageProvider: imageProvider,
    buttonText: buttonText,
    onTap: onTap,
    onInfoTap: onInfoTap,
    errorBuilder: errorBuilder,
    title: title,
  );

  factory RecapCard.active({
    required double width,
    required ImageProvider imageProvider,
    required String buttonText,
    required Function()? onTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
    String? badgeText,
  }) => RecapCard._(
    variant: RecapCardVariant.active,
    width: width,
    imageProvider: imageProvider,
    buttonText: buttonText,
    onTap: onTap,
    errorBuilder: errorBuilder,
    title: title,
    badgeText: badgeText,
  );

  factory RecapCard.generated({
    required double width,
    required ImageProvider imageProvider,
    required String createdBy,
    required String albumName,
    required Function()? onTap,
    ImageErrorWidgetBuilder? errorBuilder,
    String? title,
  }) => RecapCard._(
    variant: RecapCardVariant.generated,
    width: width,
    imageProvider: imageProvider,
    createdBy: createdBy,
    albumName: albumName,
    onTap: onTap,
    errorBuilder: errorBuilder,
    title: title,
  );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

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
                  Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: errorBuilder,
                  ),
                  Padding(
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
                              if (!variant.isBlocked && badgeText != null)
                                BadgeLabel(
                                  content: badgeText!,
                                  variant: BadgeLabelVariant.premium,
                                  size: BadgeLabelSize.large,
                                ),
                              if (variant.isBlocked)
                                DotsIconButton(
                                  icon: DotsIconData.lock,
                                  onTap: onInfoTap,
                                  style: DotsIconButtonStyle.floating,
                                  size: DotsIconButtonSize.large,
                                  state: DotsIconButtonState.defaultState,
                                  color: theme.colors.textPrimary,
                                  backgroundColor: theme.colors.bgBtnImage.withValues(alpha: 0.5),
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
                  ),
                ],
              ),
            ),
          ),
        ),
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
