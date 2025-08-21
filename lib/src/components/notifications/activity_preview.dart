import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum ActivityPreviewVariant {
  reactions,
  views,
  favs;

  bool get isReactions => this == ActivityPreviewVariant.reactions;
  bool get isViews => this == ActivityPreviewVariant.views;
  bool get isFavs => this == ActivityPreviewVariant.favs;
}


class ActivityPreview extends StatelessWidget {

  /// The variant of the activity preview.
  /// default is [ActivityPreviewVariant.reactions].
  final ActivityPreviewVariant variant;

  /// the image to be displayed in the activity preview.
  final ImageProvider? image;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// The reactions count to display at the bottom.
  final List<String>? reactions;

  /// The number to display at the bottom.
  /// the number has to be formated before passing it to this widget.
  /// for example: '123' or '1.2K' and the 'K' depends on the idiom.
  final String? number;

  /// Callback when the card is tapped.
  final Function()? onCardTap;

  const ActivityPreview({
    this.variant = ActivityPreviewVariant.reactions,
    this.onCardTap,
    super.key,
    this.image,
    this.onError,
    this.reactions,
    this.number,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onCardTap,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(
              color: theme.colors.bgContainerSecondary,
              width: 1,
            ),
            borderRadius: DotsBorderRadius.r24,
            image: (image != null)
              ? DecorationImage(
                  image: image!,
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) {
                    onError?.call(exception, stackTrace);
                  },
                )
              : null,
            boxShadow: [
              BoxShadow(
                color: theme.colors.shadowPrimary,
                blurRadius: 10,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: ClipRRect(
                  borderRadius: DotsBorderRadius.r100,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), 
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: theme.colors.bgSecondaryBtn,
                        borderRadius: DotsBorderRadius.r100,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (variant.isReactions && reactions?.isNotEmpty == true)
                            ...reactions!.map((reaction) => Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Text(
                                    reaction,
                                    style: context.getByRatio(
                                      theme.typo.number.numLabelDefault, 
                                      theme.typo.number.numLabelSmall,
                                    ),
                                  ),
                                )),
                          if (!variant.isReactions)
                            DotsIcon(
                              iconData: variant.isViews
                                  ? DotsIconData.eye
                                  : DotsIconData.heart,
                              size: 14,
                              color: theme.colors.labelAlwaysWhite,
                            ),
                          SizedBox(width: variant.isReactions ? 0 : 4),
                          Text(
                            number ?? '',
                            style: theme.typo.number.numBodyDefault.copyWith(
                              color: theme.colors.labelAlwaysWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
