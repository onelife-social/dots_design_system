import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookPriceSummary extends StatelessWidget {
  /// Product image shown in the summary header.
  final ImageProvider imageProvider;

  /// Optional widget builder used when `imageProvider` fails to load.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Product title shown next to the image.
  final String title;

  /// Label used for the quantity row.
  final String quantityLabel;

  /// Current selected quantity.
  final int quantity;

  /// Whether the quantity input stepper is displayed.
  ///
  /// Defaults to `true`.
  final bool showQuantityInput;

  /// Minimum quantity allowed in the stepper.
  final int? minQuantity;

  /// Maximum quantity allowed in the stepper.
  final int? maxQuantity;

  /// Callback invoked when quantity is incremented.
  final VoidCallback? onIncrement;

  /// Callback invoked when quantity is decremented.
  final VoidCallback? onDecrement;

  /// Product price rows where key is label and value is formatted price.
  final Map<String, String> products;

  /// Label for the total row.
  final String totalLabel;

  /// Optional supplementary label, e.g. "IVA included".
  final String? taxesIncludedLabel;

  /// Formatted total price value.
  final String totalPrice;

  const DotbookPriceSummary({
    super.key,
    required this.imageProvider,
    this.errorBuilder,
    required this.title,
    required this.quantityLabel,
    required this.quantity,
    this.showQuantityInput = true,
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
          padding: const EdgeInsets.all(12),
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
                showQuantityInput: showQuantityInput,
                minQuantity: minQuantity,
                maxQuantity: maxQuantity,
                onIncrement: onIncrement,
                onDecrement: onDecrement,
              ),
              DotsDivider(),
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
    required this.showQuantityInput,
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
  final bool showQuantityInput;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
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
        const SizedBox(width: 12),
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
              showQuantityInput ? '$quantityLabel:' : '$quantityLabel: $quantity',
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
              ),
            ),
          ],
        ),
        const SizedBox(width: 6),
        if (showQuantityInput) ...[
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
