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

  const DotsRatingStarRow({
    super.key,
    required this.starLabels,
    this.leftText,
    this.rightText,
    this.selectedIndex,
    this.onStarTap,
    this.compact = false,
  }) : assert(starLabels.length == 10);

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
                )
              : _DefaultLayout(
                  starLabels: starLabels,
                  variants: variants,
                  onStarTap: onStarTap,
                  leftText: leftText,
                  rightText: rightText,
                ),
        ),
      ),
    );
  }

  List<RatingIconVariant> _buildVariants() {
    if (selectedIndex == null) {
      return List.filled(10, RatingIconVariant.disabled);
    }

    return List.generate(10, (i) {
      if (selectedIndex! <= 5) {
        return i <= selectedIndex!
            ? RatingIconVariant.detractor
            : RatingIconVariant.disabled;
      } else if (selectedIndex! <= 7) {
        return i <= selectedIndex!
            ? RatingIconVariant.neutral
            : RatingIconVariant.disabled;
      } else {
        return i <= selectedIndex!
            ? RatingIconVariant.promoter
            : RatingIconVariant.disabled;
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

  const _DefaultLayout({
    required this.starLabels,
    required this.variants,
    this.onStarTap,
    this.leftText,
    this.rightText,
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
            10,
            (index) => _Star(
              index: index,
              label: starLabels[index],
              variant: variants[index],
              onTap: onStarTap,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText ?? '',
              style: theme.typo.main.labelSmallMedium.copyWith(
                color: theme.colors.textQuarternary,
              ),
            ),
            Text(
              rightText ?? '',
              style: theme.typo.main.labelSmallMedium.copyWith(
                color: theme.colors.textQuarternary,
              ),
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

  const _CompactLayout({
    required this.starLabels,
    required this.variants,
    this.onStarTap,
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
            6,
            (index) => Padding(
              padding: EdgeInsets.only(left: index == 0 ? 0 : 5),
              child: _Star(
                index: index,
                label: starLabels[index],
                variant: variants[index],
                onTap: onStarTap,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            4,
            (i) {
              final index = i + 6;
              return Padding(
                padding: EdgeInsets.only(left: i == 0 ? 0 : 5),
                child: _Star(
                  index: index,
                  label: starLabels[index],
                  variant: variants[index],
                  onTap: onStarTap,
                ),
              );
            },
          ),
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

  const _Star({
    required this.index,
    required this.label,
    required this.variant,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DotsRatingStar(
      text: label,
      variant: variant,
      onTap: onTap != null ? () => onTap!(index) : null,
    );
  }
}
