import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SegmentedControlPriceOption extends StatelessWidget {
  final String label;
  final String price;
  final String? priceTrailingText;
  final String? description;
  final String? tag;
  final bool isSelected;
  final SegmentedControlPriceVariant variant;
  final String? originalPrice;

  const SegmentedControlPriceOption({
    super.key,
    required this.label,
    required this.price,
    this.priceTrailingText,
    this.description,
    this.tag,
    this.isSelected = false,
    required this.variant,
    this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final boxDecoration = BoxDecoration(
      color: isSelected ? theme.colors.bgStrong : Colors.transparent,
      borderRadius: BorderRadius.circular(16),
    );

    return DotsDecoratedBox(
      styleType: isSelected ? theme.styles.toastShadow : null,
      decoration: boxDecoration,
      child: DotsDecoratedBox(
        styleType: theme.styles.squircle16,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 6, top: 6, bottom: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: isSelected ? theme.colors.textPrimary : theme.colors.textQuarternary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (tag != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: BadgeLabel(
                        content: tag!,
                        variant: BadgeLabelVariant.green,
                      ),
                    ),
                  ],
                ],
              ),
              if (variant.isSingle) ...[
                if (description != null)
                  _DescriptionText(description: description!, isSelected: isSelected),
                if (originalPrice != null)
                  _OriginalPriceText(originalPrice: originalPrice!),
                _PriceRow(
                  price: price,
                  priceTrailingText: priceTrailingText,
                  isSelected: isSelected,
                ),
              ],
              if (variant.isDual) ...[
                if (originalPrice != null)
                  _OriginalPriceText(originalPrice: originalPrice!),
                _PriceRow(
                  price: price,
                  priceTrailingText: priceTrailingText,
                  isSelected: isSelected,
                ),
                if (description != null)
                  _DescriptionText(description: description!, isSelected: isSelected),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DescriptionText extends StatelessWidget {
  final String description;
  final bool isSelected;

  const _DescriptionText({required this.description, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Text(
      description,
      style: theme.typo.main.bodyDefaultMedium.copyWith(
        color: isSelected ? theme.colors.textQuarternary : theme.colors.textDisabled,
      ),
    );
  }
}

class _OriginalPriceText extends StatelessWidget {
  final String originalPrice;

  const _OriginalPriceText({required this.originalPrice});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Text(
      originalPrice,
      style: theme.typo.main.labelSmallMedium.copyWith(
        color: theme.colors.labelActive,
        decoration: TextDecoration.lineThrough,
        decorationColor: theme.colors.textDisabled,
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String price;
  final String? priceTrailingText;
  final bool isSelected;

  const _PriceRow({
    required this.price,
    this.priceTrailingText,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      children: [
        Text(
          price,
          style: theme.typo.main.titleH6.copyWith(
            color: isSelected ? theme.colors.textPrimary : theme.colors.textTertiary,
          ),
        ),
        if (priceTrailingText != null)
          Text(
            priceTrailingText!,
            style: theme.typo.main.bodyDefaultMedium.copyWith(
              color: isSelected ? theme.colors.textQuarternary : theme.colors.textDisabled,
            ),
          ),
      ],
    );
  }
}
