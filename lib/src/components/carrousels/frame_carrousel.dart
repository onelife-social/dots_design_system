import 'dart:ui' show lerpDouble;

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// A horizontally scrollable thumbnail carousel with a fixed center selection
/// ring — the thumbnail sitting under the ring is the selected one and is
/// scaled up ([selectedScale]) while the rest stay at their base size.
///
/// The carousel snaps every thumbnail to the center as the user swipes, so the
/// selection follows the swipe ("Desliza para seleccionar"). Tapping a
/// thumbnail animates it to the center too. Selection is controlled: the parent
/// owns [selectedIndex] and is notified of changes through
/// [onSelectedIndexChanged].
///
/// It is intentionally content-agnostic (it renders arbitrary
/// [ImageProvider]s) so it can back any "pick one frame/image out of many"
/// flow — e.g. choosing a video cover frame.
class DotsFrameCarousel extends StatefulWidget {
  /// Thumbnails to display, in order.
  final List<ImageProvider> frames;

  /// Index of the frame currently under the center ring.
  final int selectedIndex;

  /// Called with the new index whenever a different frame reaches the center.
  final ValueChanged<int> onSelectedIndexChanged;

  /// Base (unselected) thumbnail width.
  final double thumbnailWidth;

  /// Base (unselected) thumbnail height.
  final double thumbnailHeight;

  /// Scale applied to the centered thumbnail.
  final double selectedScale;

  /// Horizontal gap between consecutive thumbnails at base size.
  final double spacing;

  /// Color of the center selection ring. Defaults to `labelHighlight`.
  final Color? ringColor;

  /// Color the left/right edges fade to. Defaults to `bgBase`.
  final Color? edgeFadeColor;

  /// Builder used when a thumbnail image fails to load.
  final ImageErrorWidgetBuilder? errorBuilder;

  const DotsFrameCarousel({
    super.key,
    required this.frames,
    required this.selectedIndex,
    required this.onSelectedIndexChanged,
    this.thumbnailWidth = 48,
    this.thumbnailHeight = 64,
    this.selectedScale = 1.15,
    this.spacing = 8,
    this.ringColor,
    this.edgeFadeColor,
    this.errorBuilder,
  });

  double get _slotWidth => thumbnailWidth + spacing;

  @override
  State<DotsFrameCarousel> createState() => _DotsFrameCarouselState();
}

class _DotsFrameCarouselState extends State<DotsFrameCarousel> {
  late final ScrollController _controller;
  late int _reportedIndex;

  @override
  void initState() {
    super.initState();
    _reportedIndex = _clampIndex(widget.selectedIndex);
    _controller = ScrollController(
      initialScrollOffset: _reportedIndex * widget._slotWidth,
    );
    _controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(covariant DotsFrameCarousel oldWidget) {
    super.didUpdateWidget(oldWidget);

    final target = _clampIndex(widget.selectedIndex);
    if (target != _reportedIndex && _controller.hasClients) {
      _reportedIndex = target;
      _controller.animateTo(
        target * widget._slotWidth,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onScroll);
    _controller.dispose();
    super.dispose();
  }

  int _clampIndex(int index) => index.clamp(0, widget.frames.length - 1);

  double get _currentPage {
    if (!_controller.hasClients || !_controller.position.hasPixels) {
      return _reportedIndex.toDouble();
    }
    return _controller.offset / widget._slotWidth;
  }

  void _onScroll() {
    final index = _clampIndex(_currentPage.round());
    if (index != _reportedIndex) {
      _reportedIndex = index;
      widget.onSelectedIndexChanged(index);
    }
  }

  void _onThumbnailTap(int index) {
    _controller.animateTo(
      index * widget._slotWidth,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final ringColor = widget.ringColor ?? theme.colors.labelHighlight;
    final fadeColor = widget.edgeFadeColor ?? theme.colors.bgBase;

    final selectedWidth = widget.thumbnailWidth * widget.selectedScale;
    final selectedHeight = widget.thumbnailHeight * widget.selectedScale;
    final height = selectedHeight + 12;

    if (widget.frames.isEmpty) {
      return SizedBox(height: height);
    }

    return SizedBox(
      height: height,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sidePadding = (constraints.maxWidth - widget._slotWidth) / 2;
          final fadeWidth = widget._slotWidth * 1.1;

          return Stack(
            alignment: Alignment.center,
            children: [
              ListView.builder(
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemExtent: widget._slotWidth,
                padding: EdgeInsets.symmetric(
                  horizontal: sidePadding.clamp(0, double.infinity),
                ),
                physics: _SnapScrollPhysics(itemExtent: widget._slotWidth),
                itemCount: widget.frames.length,
                itemBuilder: (context, index) => _FrameThumbnail(
                  image: widget.frames[index],
                  width: widget.thumbnailWidth,
                  height: widget.thumbnailHeight,
                  selectedScale: widget.selectedScale,
                  controller: _controller,
                  currentPage: () => _currentPage,
                  index: index,
                  errorBuilder: widget.errorBuilder,
                  onTap: () => _onThumbnailTap(index),
                ),
              ),
              IgnorePointer(
                child: _EdgeFade(width: fadeWidth, color: fadeColor, begin: true),
              ),
              IgnorePointer(
                child: _EdgeFade(width: fadeWidth, color: fadeColor, begin: false),
              ),
              IgnorePointer(
                child: _SelectionRing(
                  width: selectedWidth,
                  height: selectedHeight,
                  color: ringColor,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _FrameThumbnail extends StatelessWidget {
  final ImageProvider image;
  final double width;
  final double height;
  final double selectedScale;
  final ScrollController controller;
  final double Function() currentPage;
  final int index;
  final ImageErrorWidgetBuilder? errorBuilder;
  final VoidCallback onTap;

  const _FrameThumbnail({
    required this.image,
    required this.width,
    required this.height,
    required this.selectedScale,
    required this.controller,
    required this.currentPage,
    required this.index,
    required this.errorBuilder,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final thumbnail = ClipRRect(
      borderRadius: DotsBorderRadius.r8,
      child: Image(
        image: image,
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder:
            errorBuilder ??
            (context, _, _) => Container(
              width: width,
              height: height,
              color: theme.colors.bgContainerSecondaryOnBackground,
            ),
      ),
    );

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            final distance = (currentPage() - index).abs().clamp(0.0, 1.0);
            final scale = lerpDouble(selectedScale, 1.0, distance) ?? 1.0;
            return Transform.scale(scale: scale, child: child);
          },
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: DotsBorderRadius.r8,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.dotsWithOpacity(0.15),
                  blurRadius: 3,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: thumbnail,
          ),
        ),
      ),
    );
  }
}

class _SelectionRing extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const _SelectionRing({required this.width, required this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width + 6,
      height: height + 6,
      decoration: BoxDecoration(
        borderRadius: DotsBorderRadius.r10,
        border: Border.all(color: color, width: 2.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.dotsWithOpacity(0.15),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _EdgeFade extends StatelessWidget {
  final double width;
  final Color color;

  /// Fades the left edge when `true`, the right edge when `false`.
  final bool begin;

  const _EdgeFade({required this.width, required this.color, required this.begin});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: begin ? Alignment.centerLeft : Alignment.centerRight,
      child: SizedBox(
        width: width,
        height: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: begin ? Alignment.centerLeft : Alignment.centerRight,
              end: begin ? Alignment.centerRight : Alignment.centerLeft,
              colors: [color, color.dotsWithOpacity(0)],
            ),
          ),
        ),
      ),
    );
  }
}

/// Snaps the nearest thumbnail to the center, PageView-style, but for a
/// fixed [itemExtent] list.
class _SnapScrollPhysics extends ScrollPhysics {
  final double itemExtent;

  const _SnapScrollPhysics({required this.itemExtent, super.parent});

  @override
  _SnapScrollPhysics applyTo(ScrollPhysics? ancestor) =>
      _SnapScrollPhysics(itemExtent: itemExtent, parent: buildParent(ancestor));

  double _targetPixels(ScrollMetrics position, Tolerance tolerance, double velocity) {
    double page = position.pixels / itemExtent;
    if (velocity < -tolerance.velocity) {
      page -= 0.5;
    } else if (velocity > tolerance.velocity) {
      page += 0.5;
    }
    return (page.roundToDouble() * itemExtent).clamp(
      position.minScrollExtent,
      position.maxScrollExtent,
    );
  }

  @override
  Simulation? createBallisticSimulation(ScrollMetrics position, double velocity) {
    if ((velocity <= 0.0 && position.pixels <= position.minScrollExtent) ||
        (velocity >= 0.0 && position.pixels >= position.maxScrollExtent)) {
      return super.createBallisticSimulation(position, velocity);
    }

    final tolerance = toleranceFor(position);
    final target = _targetPixels(position, tolerance, velocity);
    if (target != position.pixels) {
      return ScrollSpringSimulation(
        spring,
        position.pixels,
        target,
        velocity,
        tolerance: tolerance,
      );
    }
    return null;
  }

  @override
  bool get allowImplicitScrolling => false;
}
