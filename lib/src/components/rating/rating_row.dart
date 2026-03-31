import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsRatingStarRow extends StatelessWidget {
  // Labels for each star
  final List<String> starLabels;

  // Text shown on the left below the stars
  final String? leftText;

  // Text shown on the right below the stars
  final String? rightText;

  // Index of the selected star
  final int? selectedIndex;

  // Callback when a star is tapped
  final void Function(int index)? onStarTap;

  // If true, show compact layout (for small ratio)
  final bool compact;

  final bool showStarText;

  final double? iconSize;

  const DotsRatingStarRow({
    super.key,
    required this.starLabels,
    this.leftText,
    this.rightText,
    this.selectedIndex,
    this.onStarTap,
    this.compact = false,
    this.showStarText = true,
    this.iconSize,
  }) : assert(starLabels.length == 10 || starLabels.length == 5);

  @override
  Widget build(BuildContext context) {
    final variants = _buildVariants();

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 342),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: compact
              ? _CompactLayout(
                  starLabels: starLabels,
                  variants: variants,
                  onStarTap: onStarTap,
                  showText: showStarText,
                  iconSize: iconSize,
                )
              : _DefaultLayout(
                  starLabels: starLabels,
                  variants: variants,
                  onStarTap: onStarTap,
                  leftText: leftText,
                  rightText: rightText,
                  showText: showStarText,
                  iconSize: iconSize,
                ),
        ),
      ),
    );
  }

  List<RatingIconVariant> _buildVariants() {
    if (selectedIndex == null) {
      return List.filled(starLabels.length, RatingIconVariant.disabled);
    }

    return List.generate(starLabels.length, (i) {
      if (starLabels.length == 5) {
        return i <= selectedIndex! ? RatingIconVariant.neutral : RatingIconVariant.disabled;
      }

      if (selectedIndex! <= 5) {
        return i <= selectedIndex! ? RatingIconVariant.detractor : RatingIconVariant.disabled;
      } else if (selectedIndex! <= 7) {
        return i <= selectedIndex! ? RatingIconVariant.neutral : RatingIconVariant.disabled;
      } else {
        return i <= selectedIndex! ? RatingIconVariant.promoter : RatingIconVariant.disabled;
      }
    });
  }
}

class _DefaultLayout extends StatelessWidget {
  final List<String> starLabels;
  final List<RatingIconVariant> variants;
  final void Function(int index)? onStarTap;
  final String? leftText;
  final String? rightText;
  final bool showText;
  final double? iconSize;

  const _DefaultLayout({
    required this.starLabels,
    required this.variants,
    this.onStarTap,
    this.leftText,
    this.rightText,
    required this.showText,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            starLabels.length,
            (index) => _Star(
              index: index,
              label: starLabels[index],
              variant: variants[index],
              onTap: onStarTap,
              showText: showText,
              iconSize: iconSize,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText ?? '',
              style: theme.typo.main.labelSmallMedium.copyWith(color: theme.colors.textQuarternary),
            ),
            Text(
              rightText ?? '',
              style: theme.typo.main.labelSmallMedium.copyWith(color: theme.colors.textQuarternary),
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactLayout extends StatelessWidget {
  final List<String> starLabels;
  final List<RatingIconVariant> variants;
  final void Function(int index)? onStarTap;
  final bool showText;
  final double? iconSize;

  const _CompactLayout({
    required this.starLabels,
    required this.variants,
    this.onStarTap,
    required this.showText,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 8,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            starLabels.length > 5 ? 6 : starLabels.length,
            (index) => Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 5),
              child: _Star(
                index: index,
                label: starLabels[index],
                variant: variants[index],
                onTap: onStarTap,
                showText: showText,
                iconSize: iconSize,
              ),
            ),
          ),
        ),
        if (starLabels.length > 5)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(4, (i) {
              final index = i + 6;
              return Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 5),
                child: _Star(
                  index: index,
                  label: starLabels[index],
                  variant: variants[index],
                  onTap: onStarTap,
                  showText: showText,
                  iconSize: iconSize,
                ),
              );
            }),
          ),
      ],
    );
  }
}

class _Star extends StatelessWidget {
  final int index;
  final String label;
  final RatingIconVariant variant;
  final void Function(int index)? onTap;
  final bool showText;
  final double? iconSize;

  const _Star({
    required this.index,
    required this.label,
    required this.variant,
    required this.showText,
    this.onTap,
    this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return DotsRatingStar(
      text: label,
      variant: variant,
      onTap: onTap != null ? () => onTap!(index) : null,
      showText: showText,
      iconSize: iconSize,
    );
  }
}
