import 'dart:math';
import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

enum EventGroupCardVariant {
  small,
  active,
  passed;

  bool get isSmall => this == EventGroupCardVariant.small;
  bool get isActive => this == EventGroupCardVariant.active;
  bool get isPassed => this == EventGroupCardVariant.passed;
}

class EventGroupCard extends StatelessWidget {
  /// The variant of the group card.
  ///
  /// Defaults to [EventGroupCardVariant.small].
  final EventGroupCardVariant variant;

  /// The image provider for the background image.
  final ImageProvider imageProvider;

  /// The icon data for the Card tag.
  final DotsIconData? tagIconData;

  /// The title displayed on top of the card.
  final String title;

  /// The text to display when the group is active or passed.
  final String secondaryText;

  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Callback when the inner button is tapped.
  final Function()? onSecondaryTap;

  /// Callback when an error occurs while loading the image.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The actions to display in the card menu.
  final List<GroupEventCardModel> actions;

  /// Indicates if the group is blocked.
  final bool isBlocked;

  /// The size of the edge blur effect.
  final double? edgeSize;

  const EventGroupCard({
    this.variant = EventGroupCardVariant.small,
    required this.imageProvider,
    this.title = '',
    this.secondaryText = '',
    this.tagIconData,
    this.actions = const [],
    this.onTap,
    this.onSecondaryTap,
    this.onError,
    this.isBlocked = false,
    this.edgeSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final DotsStyleSquircle styleType = variant.isSmall
        ? theme.styles.squircle32
        : theme.styles.squircle52;
    final double bottomBlurHeight = edgeSize ?? (variant.isSmall ? 60 : 110);

    return GestureDetector(
      onTap: onTap,
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          constraints: BoxConstraints(
            minWidth: variant.isSmall ? 135 : 288,
            minHeight: variant.isSmall ? 135 : 288,
            maxHeight: variant.isSmall ? 160 : 340,
            maxWidth: variant.isSmall ? 160 : 340,
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
                        sigma: 12,
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
                if (!variant.isSmall)
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 94,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0x803c3c3c),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.all(variant.isSmall ? 16 : 24),
                  child: Stack(
                    children: [
                      if (variant.isSmall)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: SizedBox(
                            width: double.infinity,
                            child: _Title(title: title, variant: variant),
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
                      if (!variant.isSmall) ...[
                        Align(
                          alignment: Alignment.topCenter,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 28),
                                child: _Title(title: title, variant: variant),
                              ),
                              SizedBox(height: variant.isActive ? 4 : 5),
                              variant.isActive
                                  ? GestureDetector(
                                      onTap: onSecondaryTap,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            width: 3,
                                            height: 3,
                                            decoration: ShapeDecoration(
                                              color: theme.colors.labelAlwaysWhite.dotsWithOpacity(
                                                0.7,
                                              ),
                                              shape: OvalBorder(),
                                            ),
                                          ),
                                          const SizedBox(width: 3),
                                          Text(
                                            secondaryText,
                                            style: theme.typo.main.labelSmallRegular.copyWith(
                                              color: theme.colors.labelAlwaysWhite.dotsWithOpacity(
                                                0.7,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : DotsMainButton(
                                      content: secondaryText,
                                      textColor: theme.colors.labelAlwaysWhite,
                                      icon: DotsIconData.exitFullscreen,
                                      variant: DotsMainButtonVariant.secondary,
                                      iconSize: 14,
                                      expand: false,
                                      size: DotsMainButtonSize.small,
                                      onTap: onSecondaryTap,
                                    ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: _MenuEvent(
                            actions: actions,
                          ),
                        ),
                      ],
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

class _Title extends StatelessWidget {
  final String title;
  final EventGroupCardVariant variant;

  const _Title({required this.variant, required this.title});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Text(
      title,
      textAlign: TextAlign.center,
      style: (variant.isSmall ? theme.typo.main.labelDefaultMedium : theme.typo.main.bodyLargeBold)
          .copyWith(color: theme.colors.labelAlwaysWhite),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }
}

class _MenuEvent extends StatelessWidget {
  final List<GroupEventCardModel> actions;

  const _MenuEvent({required this.actions});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return ClipRRect(
      borderRadius: DotsBorderRadius.r20,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: ShapeDecoration(
            color: theme.colors.bgBtnDisabled,
            shape: RoundedRectangleBorder(
              borderRadius: DotsBorderRadius.r20,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(max(0, actions.length * 2 - 1), (i) {
              if (i.isOdd) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Container(
                    width: 0.5,
                    height: 22.78,
                    color: Colors.black.dotsWithOpacity(0.1),
                  ),
                );
              }
              final action = actions[i ~/ 2];
              return GestureDetector(
                onTap: action.onTap,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DotsIcon(
                        iconData: action.icon,
                        size: 20,
                        color: theme.colors.labelAlwaysWhite,
                      ),
                      ConstrainedBox(
                        constraints: BoxConstraints(minWidth: 46),
                        child: Text(
                          action.text,
                          textAlign: TextAlign.center,
                          style: theme.typo.main.labelSmallRegular.copyWith(
                            color: theme.colors.labelAlwaysWhite,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
