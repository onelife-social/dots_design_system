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
    final variants = getVariants();

    if (compact) {
      return Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 342),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(6, (index) {
                    return Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 2,
                        right: index == 5 ? 0 : 0,
                      ),
                      child: DotsRatingStar(
                        text: starLabels[index],
                        variant: variants[index],
                        onTap: onStarTap != null ? () => onStarTap!(index) : null,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (i) {
                    final index = i + 6;
                    return Padding(
                      padding: EdgeInsets.only(
                        left: i == 0 ? 0 : 5,
                        right: i == 3 ? 0 : 0,
                      ),
                      child: DotsRatingStar(
                        text: starLabels[index],
                        variant: variants[index],
                        onTap: onStarTap != null ? () => onStarTap!(index) : null,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 342),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(10, (index) {
                  return DotsRatingStar(
                    text: starLabels[index],
                    variant: variants[index],
                    onTap: onStarTap != null ? () => onStarTap!(index) : null,
                  );
                }),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    leftText ?? '',
                    style: context.dotsTheme.typo.main.labelSmallMedium.copyWith(
                      color: context.dotsTheme.colors.textQuarternary,
                    ),
                  ),
                  Text(
                    rightText ?? '',
                    style: context.dotsTheme.typo.main.labelSmallMedium.copyWith(
                      color: context.dotsTheme.colors.textQuarternary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<RatingIconVariant> getVariants() {
    if (selectedIndex == null) {
      return List.filled(10, RatingIconVariant.disabled);
    }
    return List.generate(10, (i) {
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