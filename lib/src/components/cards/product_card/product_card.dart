import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:soft_edge_blur/soft_edge_blur.dart';

import '../../../../dots_design_system.dart';

/// Product card: a square media card whose copy sits **over** the background,
/// kept readable by a bottom blur + gradient scrim (same technique as
/// [AlbumGroupCard]).
///
/// The background is a slot, so the card works with a single photo, a photo
/// carousel, a gradient or any other widget. Everything above the background
/// is optional except [title].
///
/// Figma: Chronicle Design System › `product-card` (358 × 358).
class ProductCard extends StatelessWidget {
  const ProductCard({
    this.blurBackground = true,
    super.key,
    required this.title,
    required this.background,
    this.subtitle,
    this.caption,
    this.captionPrevious,
    this.captionPlaceholder,
    this.badge,
    this.pageCount = 0,
    this.activePage = 0,
    this.actionIcon = DotsIconData.right,
    this.aspectRatio = 1,
    this.onTap,
    this.onActionTap,
  });

  /// Main line, always shown.
  final String title;

  /// Whether the bottom scrim also blurs the background.
  ///
  /// Turn it off when [background] holds state — a `PageView`, say. The blur
  /// paints a second, independent copy of the background, which a carousel
  /// desynchronises from: the band keeps showing the page you swiped away
  /// from. Without it the scrim is the gradient alone.
  final bool blurBackground;

  /// Fills the whole card behind the scrim: photo, `PageView`, gradient…
  final Widget background;

  /// Secondary line under [title].
  final String? subtitle;

  /// Third line, typically a price ("Desde 29,99 €").
  final String? caption;

  /// Value shown struck through after [caption], e.g. the price before a
  /// discount. Ignored when [caption] is null.
  final String? captionPrevious;

  /// Shown in the caption's place while its value is still unknown — a price
  /// being fetched from the store, typically a skeleton. Keeps the copy block
  /// from resizing when the value lands. Ignored when [caption] is set.
  final Widget? captionPlaceholder;

  /// Badge pinned to the top-right corner, e.g. a [BadgeLabel].
  final Widget? badge;

  /// Number of dots in the [PageControl]. `0` hides it.
  final int pageCount;

  /// Index of the active dot.
  final int activePage;

  /// Icon of the trailing action button.
  final DotsIconData actionIcon;

  /// Width / height. Defaults to the square ratio of the Figma component;
  /// screens that lay the card out at another height override it.
  final double aspectRatio;

  /// Tap on the whole card.
  final VoidCallback? onTap;

  /// Tap on the trailing action button. `null` hides the button.
  final VoidCallback? onActionTap;

  /// Height of the bottom blur + gradient band.
  static const double _scrimHeight = 160;

  /// Distance from the bottom edge to the copy block and to the dots.
  static const double _contentBottomInset = 20;

  /// The design places a 24-tall PageControl 110 from the bottom, so its dots
  /// are centred at 122. `PageControlVariant.main` adds 18 of vertical
  /// contentPadding around its 8px dots, making the widget 44 tall — position
  /// it by that centre instead of its edge.
  static const double _dotsBottomInset = 122 - 44 / 2;

  /// Horizontal padding, plus the extra left inset the design gives the copy.
  static const double _horizontalPadding = 20;
  static const double _copyLeftInset = 4;

  /// Vertical rhythm inside the copy block.
  static const double _copyGap = 6;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final DotsStyleSquircle squircle = theme.styles.squircle32;
    final DotsStyleShadow shadow = theme.styles.defaultShadow;
    final Color white = theme.colors.labelAlwaysWhite;

    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          shape: SmoothRectangleBorder(
            borderRadius: SmoothBorderRadius(
              cornerRadius: squircle.radius,
              cornerSmoothing: squircle.cornerSmoothing,
            ),
          ),
          shadows: [
            BoxShadow(
              color: shadow.color,
              offset: shadow.offset,
              blurRadius: shadow.blurRadius,
              spreadRadius: shadow.spreadRadius,
            ),
          ],
        ),
        child: ClipSmoothRect(
          radius: SmoothBorderRadius(
            cornerRadius: squircle.radius,
            cornerSmoothing: squircle.cornerSmoothing,
          ),
          child: AspectRatio(
            aspectRatio: aspectRatio,
            child: Stack(
              children: [
                if (!blurBackground)
                  Positioned.fill(child: background)
                else
                  Positioned.fill(
                    child: SoftEdgeBlur(
                      edges: [
                        EdgeBlur(
                          type: EdgeType.bottomEdge,
                          size: _scrimHeight,
                          sigma: 12,
                          controlPoints: [
                            ControlPoint(position: 0.5, type: ControlPointType.visible),
                            ControlPoint(position: 1, type: ControlPointType.transparent),
                          ],
                        ),
                      ],
                      child: background,
                    ),
                  ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: IgnorePointer(
                    child: Container(
                      height: _scrimHeight,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0),
                            Colors.black.withValues(alpha: 0.45),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (badge != null)
                  Positioned(
                    top: _contentBottomInset,
                    right: _horizontalPadding,
                    child: badge!,
                  ),
                // Painted outside the SoftEdgeBlur so the dots stay sharp.
                if (pageCount > 0)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: _dotsBottomInset,
                    // PageControl fills the available width (internal
                    // width: infinity); inside a Positioned it must be bounded
                    // to its natural size: count × (dotSize 8 + dotSpacing 8) +
                    // h contentPadding 12×2.
                    child: Center(
                      child: SizedBox(
                        width: pageCount * 16 + 24,
                        child: PageControl(
                          count: pageCount,
                          activeIndex: activePage,
                          activeColor: white,
                          dotColor: white.withValues(alpha: 0.6),
                        ),
                      ),
                    ),
                  ),
                Positioned(
                  left: _horizontalPadding,
                  right: _horizontalPadding,
                  bottom: _contentBottomInset,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: _copyLeftInset),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: theme.typo.main.titleH6.copyWith(color: white),
                              ),
                              if (subtitle != null) ...[
                                const SizedBox(height: _copyGap),
                                Text(
                                  subtitle!,
                                  style: theme.typo.main.labelDefaultRegular.copyWith(
                                    color: white.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                              if (caption != null) ...[
                                const SizedBox(height: _copyGap),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        caption!,
                                        style: theme.typo.main.bodyDefaultMedium.copyWith(
                                          color: white,
                                        ),
                                      ),
                                    ),
                                    if (captionPrevious != null) ...[
                                      const SizedBox(width: 6),
                                      Flexible(
                                        child: Text(
                                          captionPrevious!,
                                          style: theme.typo.main.labelDefaultRegular.copyWith(
                                            color: white.withValues(alpha: 0.7),
                                            decoration: TextDecoration.lineThrough,
                                            decorationColor: white.withValues(alpha: 0.7),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ] else if (captionPlaceholder != null) ...[
                                const SizedBox(height: _copyGap),
                                captionPlaceholder!,
                              ],
                            ],
                          ),
                        ),
                      ),
                      if (onActionTap != null) ...[
                        const SizedBox(width: 12),
                        DotsIconButton(
                          icon: actionIcon,
                          iconSize: 20,
                          size: DotsIconButtonSize.medium,
                          // Figma calls this style "Surface".
                          style: DotsIconButtonStyle.floating,
                          onTap: onActionTap,
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
