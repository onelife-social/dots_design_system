import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookPriceSummary extends StatelessWidget {
  final ImageProvider imageProvider;
  final ImageErrorWidgetBuilder? errorBuilder;

  final String title;
  final String quantityLabel;
  final int quantity;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  final Map<String, String> products;
  final String totalLabel;
  final String? taxesIncludedLabel;
  final String totalPrice;

  const DotbookPriceSummary({
    super.key,
    required this.imageProvider,
    this.errorBuilder,
    required this.title,
    required this.quantityLabel,
    required this.quantity,
    this.minQuantity,
    this.maxQuantity,
    this.onIncrement,
    this.onDecrement,
    required this.products,
    required this.totalLabel,
    this.taxesIncludedLabel,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return DotsDecoratedBox(
      styleType: theme.styles.defaultShadow,
      decoration: BoxDecoration(
        color: theme.colors.bgStrong,
        borderRadius: BorderRadius.circular(24),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              _TitleAndQuantity(
                imageProvider: imageProvider,
                errorBuilder: errorBuilder,
                title: title,
                quantityLabel: quantityLabel,
                quantity: quantity,
                minQuantity: minQuantity,
                maxQuantity: maxQuantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
              Divider(
                height: 3,
                color: theme.colors.labelSecondary.dotsWithOpacity(0.5),
                thickness: 0.2,
              ),
              _Info(
                products: products,
                totalLabel: totalLabel,
                taxesIncludedLabel: taxesIncludedLabel,
                totalPrice: totalPrice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TitleAndQuantity extends StatelessWidget {
  const _TitleAndQuantity({
    required this.imageProvider,
    required this.errorBuilder,
    required this.title,
    required this.quantityLabel,
    required this.quantity,
    required this.minQuantity,
    required this.maxQuantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final ImageProvider imageProvider;
  final ImageErrorWidgetBuilder? errorBuilder;
  final String title;
  final String quantityLabel;
  final int quantity;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final bool addInput =
        minQuantity != null && maxQuantity != null && onIncrement != null && onDecrement != null;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 12,
      children: [
        ClipRRect(
          borderRadius: DotsBorderRadius.r16,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
            width: 64,
            height: 64,
            errorBuilder: errorBuilder,
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              title,
              style: theme.typo.main.bodyLargeMedium.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
            Text(
              addInput ? '$quantityLabel:' : '$quantityLabel: $quantity',
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
              ),
            ),
          ],
        ),
        if (addInput) ...[
          const Spacer(),
          DotsInputStepper(
            value: quantity,
            minValue: minQuantity!,
            maxValue: maxQuantity!,
            onIncrement: onIncrement!,
            onDecrement: onDecrement!,
          ),
        ],
      ],
    );
  }
}

class _Info extends StatelessWidget {
  final Map<String, String> products;
  final String totalLabel;
  final String? taxesIncludedLabel;
  final String totalPrice;

  const _Info({
    required this.products,
    required this.totalLabel,
    this.taxesIncludedLabel,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          ...products.entries.map((entry) => _PriceRow(label: entry.key, price: entry.value)),

          _TotalPriceRow(
            totalLabel: totalLabel,
            taxesIncludedLabel: taxesIncludedLabel,
            totalPrice: totalPrice,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String price;

  const _PriceRow({
    required this.label,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            label,
            style: theme.typo.main.bodyDefaultRegular.copyWith(color: theme.colors.textSecondary),
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            price,
            textAlign: TextAlign.right,
            style: theme.typo.main.bodyDefaultMedium.copyWith(color: theme.colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class _TotalPriceRow extends StatelessWidget {
  final String totalLabel;
  final String? taxesIncludedLabel;
  final String totalPrice;

  const _TotalPriceRow({
    required this.totalLabel,
    required this.taxesIncludedLabel,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              totalLabel,
              style: theme.typo.main.bodyLargeBold.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
            if (taxesIncludedLabel != null) ...[
              const SizedBox(width: 6),
              Text(
                taxesIncludedLabel!,
                style: theme.typo.main.bodyLargeMedium.copyWith(
                  color: theme.colors.textQuarternary,
                ),
              ),
            ],
          ],
        ),
        Text(
          totalPrice,
          style: theme.typo.main.bodyLargeBold.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
