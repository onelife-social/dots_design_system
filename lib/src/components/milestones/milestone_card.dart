import 'package:dots_design_system/dots_design_system.dart';
import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vector_graphics/vector_graphics.dart';
import 'package:visibility_detector/visibility_detector.dart';

class MilestoneCard extends StatefulWidget {
  /// The width of the card.
  final double width;

  /// The image provider for the background image
  final ImageProvider imageProvider;

  /// The default image to show while the main image is loading or if it fails to load.
  final ImageProvider defaultImage;

  /// Callback when an error occurs while loading the image.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Title of the card.
  final String? title;

  /// Whether to limit the title to a single line with ellipsis.
  final bool limitTitle;

  /// The date of the milestone.
  final String? date;

  /// Callback when the image is tapped.
  final VoidCallback? onTap;

  /// Whether to show the badge on the card.
  final bool showBadge;

  /// Whether to show the edit button on the card.
  final bool showEdit;

  /// Callback when the edit button is tapped.
  final VoidCallback? onTapEdit;

  /// Whether this card is selected (used for scroll positioning).
  final bool isSelected;

  /// The badges to show on the card.
  final List<MilestoneBadgeType> badgeTypes;

  /// Callback when the badges are tapped.
  final VoidCallback? onBadgesTap;

  const MilestoneCard({
    super.key,
    required this.width,
    required this.imageProvider,
    required this.defaultImage,
    this.errorBuilder,
    this.title,
    this.limitTitle = false,
    this.date,
    this.onTap,
    this.showBadge = false,
    this.showEdit = false,
    this.onTapEdit,
    this.isSelected = false,
    this.badgeTypes = const [],
    this.onBadgesTap,
  });

  @override
  State<MilestoneCard> createState() => _MilestoneCardState();
}

class _MilestoneCardState extends State<MilestoneCard> {
  bool _forceWithoutBlur = false;
  static const String _visibilityKey = 'milestone_card_visibility_key';

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final bool isBig = widget.width > 150;

    final imageWidget = ClipSmoothRect(
      radius: SmoothBorderRadius(cornerRadius: isBig ? 32 : 24, cornerSmoothing: 0.5),
      child: Image(
        image: widget.imageProvider,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: widget.errorBuilder,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Image(
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            image: widget.defaultImage,
          );
        },
      ),
    );

    return SizedBox(
      width: widget.width,
      child: AspectRatio(
        aspectRatio: 3 / 4,
        child: VisibilityDetector(
          key: const Key(_visibilityKey),
          onVisibilityChanged: (info) {
            if (mounted) {
              final forceWithoutBlur = info.visibleFraction == 0;
              if (_forceWithoutBlur != forceWithoutBlur) {
                setState(() {
                  _forceWithoutBlur = forceWithoutBlur;
                });
              }
            }
          },
          child: _MilestoneItem(
            theme: theme,
            title: widget.title,
            imageProvider: widget.imageProvider,
            imageWidget: imageWidget,
            limitTitle: widget.limitTitle,
            date: widget.date,
            showBadge: widget.showBadge,
            showEdit: widget.showEdit,
            onTapEdit: widget.onTapEdit,
            forceWithoutBlur: _forceWithoutBlur,
            onTap: widget.onTap,
            isBig: isBig,
            badgeTypes: widget.badgeTypes,
            onBadgesTap: widget.onBadgesTap,
          ),
        ),
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  final DotsTheme theme;
  final String? title;
  final ImageProvider<Object> imageProvider;
  final ClipSmoothRect imageWidget;
  final bool limitTitle;
  final String? date;
  final bool showBadge;
  final bool showEdit;
  final VoidCallback? onTapEdit;
  final bool forceWithoutBlur;
  final VoidCallback? onTap;
  final bool isBig;
  final List<MilestoneBadgeType> badgeTypes;
  final VoidCallback? onBadgesTap;

  const _MilestoneItem({
    required this.theme,
    required this.title,
    required this.imageProvider,
    required this.imageWidget,
    required this.limitTitle,
    required this.date,
    required this.showBadge,
    required this.showEdit,
    required this.onTapEdit,
    required this.forceWithoutBlur,
    required this.onTap,
    required this.isBig,
    this.badgeTypes = const [],
    this.onBadgesTap,
  });

  @override
  Widget build(BuildContext context) {
    return DotsDecoratedBox(
      styleType: theme.styles.floatingBtnShadow,
      child: DotsDecoratedBox(
        styleType: isBig ? theme.styles.squircle32 : theme.styles.squircle24,
        child: ClipSmoothRect(
          radius: SmoothBorderRadius(cornerRadius: isBig ? 32 : 24, cornerSmoothing: 0.5),
          child: Stack(
            children: [
              Positioned.fill(
                child: GestureDetector(
                  onTap: onTap,
                  behavior: HitTestBehavior.opaque,
                  child: title?.isNotEmpty == true && !forceWithoutBlur
                      ? RepaintBoundary(
                          key: ValueKey(imageProvider),
                          child: _CardWithBlur(
                            imageWidget: imageWidget,
                          ),
                        )
                      : imageWidget,
                ),
              ),
              Positioned.fill(
                child: IgnorePointer(
                  child: Container(
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: isBig ? DotsBorderRadius.r32 : DotsBorderRadius.r24,
                        side: BorderSide(
                          color: theme.colors.labelAlwaysWhite,
                          width: 3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (title?.isNotEmpty == true)
                Positioned.fill(
                  child: IgnorePointer(
                    child: _CardTitle(
                      title: title!,
                      limitTitle: limitTitle,
                      date: date,
                    ),
                  ),
                ),
              if (showBadge)
                Positioned(
                  top: 5,
                  right: 5,
                  child: IgnorePointer(
                    child: _CardBadge(),
                  ),
                ),
              if (showEdit)
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: _BtnEdit(onTap: onTapEdit),
                ),
              if (badgeTypes.isNotEmpty)
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: _MilestoneBadges(badgeTypes: badgeTypes, onTap: onBadgesTap),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CardWithBlur extends StatelessWidget {
  final Widget imageWidget;

  const _CardWithBlur({required this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final h = constraints.maxHeight.isFinite ? constraints.maxHeight : 0;
        final stop = h > 0 ? (108.0 / h).clamp(0.0, 1.0) : 0.0;
        return DotsLinearGradientBlur(
          sigma: 15,
          linearGradientBlur: LinearGradientBlur(
            values: const [1, 0],
            stops: [0, stop],
            start: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          tintColor: Colors.black.dotsWithOpacity(0.35),
          child: imageWidget,
        );
      },
    );
  }
}

class _CardTitle extends StatelessWidget {
  final String title;
  final bool limitTitle;
  final String? date;

  const _CardTitle({
    required this.title,
    this.limitTitle = false,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 36, right: 36),
      child: Column(
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            maxLines: limitTitle ? 1 : null,
            overflow: limitTitle ? TextOverflow.ellipsis : null,
            style: theme.typo.main.bodyLargeMedium.copyWith(
              color: theme.colors.labelAlwaysWhite,
            ),
          ),
          if (date?.isNotEmpty == true)
            Text(
              date!,
              textAlign: TextAlign.center,
              style: theme.typo.main.bodyDefaultRegular.copyWith(
                color: theme.colors.labelAlwaysWhite,
              ),
            ),
        ],
      ),
    );
  }
}

class _CardBadge extends StatelessWidget {
  const _CardBadge();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 5, right: 5),
        child: SvgPicture(
          AssetBytesLoader(
            'packages/dots_design_system/assets/images/milestones/badge-milestone-1.svg.vec',
          ),
        ),
      ),
    );
  }
}

class _BtnEdit extends StatelessWidget {
  final VoidCallback? onTap;

  const _BtnEdit({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: DotsIconButton(
        icon: DotsIconData.pencil,
        backgroundColor: context.dotsTheme.colors.bgBtnImage,
        onTap: onTap,
      ),
    );
  }
}

class _MilestoneBadges extends StatelessWidget {
  final List<MilestoneBadgeType> badgeTypes;
  final VoidCallback? onTap;

  const _MilestoneBadges({required this.badgeTypes, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BadgeIconGroup(
      icons: badgeTypes.map((badge) => badge.icon).toList(),
      iconColors: badgeTypes.map((badge) => badge.color(context.dotsTheme)).toList(),
      onTap: onTap,
    );
  }
}
