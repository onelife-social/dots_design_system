import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotbookPriceSummaryVariant {
  event,
  albumYear,
  albumMonth,
}

class DotbookClaimedBookItem {
  final String quantity;
  final String title;
  final String price;
  final bool greenPrice;

  const DotbookClaimedBookItem({
    required this.quantity,
    required this.title,
    required this.price,
    this.greenPrice = true,
  });
}

class DotbookProductItem {
  final String title;
  final String price;
  final bool greenPrice;

  const DotbookProductItem({
    required this.title,
    required this.price,
    this.greenPrice = false,
  });
}

class DotbookTotalPriceItem {
  final String title;
  final String? taxes;
  final String price;

  const DotbookTotalPriceItem({
    required this.title,
    this.taxes,
    required this.price,
  });
}

class DotbookPriceSummary extends StatelessWidget {

   /// Layout variant of the summary card to display Image, custom widget or a label.
  final DotbookPriceSummaryVariant variant;

  /// Product image shown in the summary header.
  final ImageProvider? imageProvider;

  /// Optional widget builder used when `imageProvider` fails to load.
  final ImageErrorWidgetBuilder? errorBuilder;

  /// Product title shown next to the image or at the top.
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
  final List<DotbookProductItem> products;

  /// Claimed books rows with quantity, title and price.
  final List<DotbookClaimedBookItem> claimedBooks;

  /// Item to display the total price with an optional taxes included label.
  final DotbookTotalPriceItem totalPriceItem;

  /// Custom widget rendered in the header under the title. Only applied for
  /// [DotbookPriceSummaryVariant.albumYear] variant.
  final Widget? customSubtitleWidget;

  /// Text used by the badge in [DotbookPriceSummaryVariant.albumMonth].
  final String? subtitleLabelText;

  /// Callback invoked when tapping the badge in [DotbookPriceSummaryVariant.albumMonth].
  final VoidCallback? onTapSubtitleLabel;

  /// Visual style used by the badge.
  final BadgeLabelVariant subtitleLabelVariant;

  /// Custom widget rendered below the quantity row and above the price summary.
  final Widget? customWidget;

  const DotbookPriceSummary({
    super.key,
    this.imageProvider,
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
    required this.totalPriceItem,
    this.variant = DotbookPriceSummaryVariant.event,
    this.customWidget,
    this.customSubtitleWidget,
    this.subtitleLabelText,
    this.onTapSubtitleLabel,
    this.subtitleLabelVariant = BadgeLabelVariant.warningMaterial,
    this.claimedBooks = const [],
  }) : assert(
        !showQuantityInput ||
            (minQuantity != null &&
                maxQuantity != null &&
                onIncrement != null &&
                onDecrement != null),
        'When showQuantityInput is true, minQuantity, maxQuantity, onIncrement and onDecrement are required.',
      );

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
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 230),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                SummaryTitleAndQuantity(
                  variant: variant,
                  imageProvider: imageProvider,
                  errorBuilder: errorBuilder,
                  title: title,
                  customSubtitleWidget: customSubtitleWidget,
                  subtitleLabelText: subtitleLabelText,
                  onTapSubtitleLabel: onTapSubtitleLabel,
                  subtitleLabelVariant: subtitleLabelVariant,
                  quantityLabel: quantityLabel,
                  quantity: quantity,
                  showQuantityInput: showQuantityInput,
                  minQuantity: minQuantity,
                  maxQuantity: maxQuantity,
                  onIncrement: onIncrement,
                  onDecrement: onDecrement,
                ),
                DotsDivider(),
                customWidget != null
                    ? SizedBox(
                        width: double.infinity,
                        child: Align(
                          alignment: Alignment.center,
                          child: customWidget,
                        ),
                      )
                    : SummaryInfo(
                        products: products,
                        claimedBooks: claimedBooks,
                        totalPriceItem: totalPriceItem,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SummaryTitleAndQuantity extends StatelessWidget {
  final DotbookPriceSummaryVariant variant;
  final ImageProvider? imageProvider;
  final ImageErrorWidgetBuilder? errorBuilder;
  final String title;
  final Widget? customSubtitleWidget;
  final String? subtitleLabelText;
  final BadgeLabelVariant subtitleLabelVariant;
  final String quantityLabel;
  final int quantity;
  final bool showQuantityInput;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onTapSubtitleLabel;

  const SummaryTitleAndQuantity({
    super.key,
    required this.variant,
    this.imageProvider,
    this.errorBuilder,
    required this.title,
    this.customSubtitleWidget,
    this.subtitleLabelText,
    this.onTapSubtitleLabel,
    this.subtitleLabelVariant = BadgeLabelVariant.warningMaterial,
    required this.quantityLabel,
    required this.quantity,
    this.showQuantityInput = false,
    this.minQuantity,
    this.maxQuantity,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    if (variant == DotbookPriceSummaryVariant.event) {
      return _EventSummaryHeader(
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
      );
    }

    return _AlbumSummaryHeader(
      variant: variant,
      title: title,
      customSubtitleWidget: customSubtitleWidget,
      subtitleLabelText: subtitleLabelText,
      subtitleLabelVariant: subtitleLabelVariant,
      quantityLabel: quantityLabel,
      quantity: quantity,
      showQuantityInput: showQuantityInput,
      minQuantity: minQuantity,
      maxQuantity: maxQuantity,
      onIncrement: onIncrement,
      onDecrement: onDecrement,
      onTapSubtitleLabel: onTapSubtitleLabel,
    );
  }
}

class _EventSummaryHeader extends StatelessWidget {
  final ImageProvider? imageProvider;
  final ImageErrorWidgetBuilder? errorBuilder;
  final String title;
  final String quantityLabel;
  final int quantity;
  final bool showQuantityInput;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const _EventSummaryHeader({
    this.imageProvider,
    this.errorBuilder,
    required this.title,
    required this.quantityLabel,
    required this.quantity,
    required this.showQuantityInput,
    this.minQuantity,
    this.maxQuantity,
    this.onIncrement,
    this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imageProvider != null) ...[
          ClipRRect(
            borderRadius: DotsBorderRadius.r16,
            child: Image(
              image: imageProvider!,
              fit: BoxFit.cover,
              width: 64,
              height: 64,
              errorBuilder: errorBuilder,
            ),
          ),
          const SizedBox(width: 12),
        ],
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 4,
            children: [
              Text(
                title,
                softWrap: true,
                style: theme.typo.main.bodyLargeMedium.copyWith(
                  color: theme.colors.textPrimary,
                ),
              ),
              _QuantityLabelText(
                quantityLabel: quantityLabel,
                quantity: quantity,
                showQuantityInput: showQuantityInput,
              ),
            ],
          ),
        ),
        if (showQuantityInput) ...[
          const SizedBox(width: 12),
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

class _AlbumSummaryHeader extends StatelessWidget {
  final DotbookPriceSummaryVariant variant;
  final String title;
  final Widget? customSubtitleWidget;
  final String? subtitleLabelText;
  final BadgeLabelVariant subtitleLabelVariant;
  final String quantityLabel;
  final int quantity;
  final bool showQuantityInput;
  final int? minQuantity;
  final int? maxQuantity;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;
  final VoidCallback? onTapSubtitleLabel;

  const _AlbumSummaryHeader({
    required this.variant,
    required this.title,
    this.customSubtitleWidget,
    this.subtitleLabelText,
    this.onTapSubtitleLabel,
    this.subtitleLabelVariant = BadgeLabelVariant.warningMaterial,
    required this.quantityLabel,
    required this.quantity,
    required this.showQuantityInput,
    this.minQuantity,
    this.maxQuantity,
    this.onIncrement,
    this.onDecrement,
  });

  Widget? _buildTitleExtra(BuildContext context) {
    switch (variant) {
      case DotbookPriceSummaryVariant.event:
        return null;
      case DotbookPriceSummaryVariant.albumYear:
        if (customSubtitleWidget == null) return null;
        return SizedBox(
          width: double.infinity,
          child: Align(
            alignment: Alignment.centerLeft,
            child: customSubtitleWidget,
          ),
        );
      case DotbookPriceSummaryVariant.albumMonth:
        if (subtitleLabelText == null || subtitleLabelText!.trim().isEmpty) return null;
        return GestureDetector(
          onTap: onTapSubtitleLabel,
          child: Row(
            children: [
              BadgeLabel(
                content: subtitleLabelText!,
                variant: subtitleLabelVariant,
              ),
              const SizedBox(width: 2),
              DotsIcon(
                iconData: DotsIconData.helpCircle,
                size: 14,
                color: context.dotsTheme.colors.textTertiary,
              ),
            ],
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final titleExtra = _buildTitleExtra(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text(
            title,
            softWrap: true,
            style: theme.typo.main.bodyLargeMedium.copyWith(
              color: theme.colors.textPrimary,
            ),
          ),
          if (titleExtra != null) titleExtra,
          if (showQuantityInput)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _QuantityLabelText(
                    quantityLabel: quantityLabel,
                    quantity: quantity,
                    showQuantityInput: true,
                  ),
                ),
                const SizedBox(width: 12),
                DotsInputStepper(
                  value: quantity,
                  minValue: minQuantity!,
                  maxValue: maxQuantity!,
                  onIncrement: onIncrement!,
                  onDecrement: onDecrement!,
                ),
              ],
            )
          else
            _QuantityLabelText(
              quantityLabel: quantityLabel,
              quantity: quantity,
              showQuantityInput: false,
            ),
        ],
      ),
    );
  }
}

class _QuantityLabelText extends StatelessWidget {
  final String quantityLabel;
  final int quantity;
  final bool showQuantityInput;

  const _QuantityLabelText({
    required this.quantityLabel,
    required this.quantity,
    required this.showQuantityInput,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Text(
      showQuantityInput ? '$quantityLabel:' : '$quantityLabel: $quantity',
      style: theme.typo.main.labelDefaultRegular.copyWith(
        color: theme.colors.textSecondary,
      ),
    );
  }
}

class SummaryInfo extends StatelessWidget {
  final List<DotbookProductItem> products;
  final List<DotbookClaimedBookItem> claimedBooks;
  final DotbookTotalPriceItem totalPriceItem;

  const SummaryInfo({
    super.key,
    required this.products,
    this.claimedBooks = const [],
    required this.totalPriceItem,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 8,
        children: [
          ...products.map((entry) => PriceRow(label: entry.title, price: entry.price, greenPrice: entry.greenPrice)),
          if (claimedBooks.isNotEmpty) ...[
            ...claimedBooks.map(
              (entry) => ClaimedBooksRow(
                quantity: entry.quantity,
                title: entry.title,
                price: entry.price,
                greenPrice: entry.greenPrice,
              ),
            ),
          ],
          TotalPriceRow(
            totalPriceItem: totalPriceItem,
          ),
        ],
      ),
    );
  }
}

class PriceRow extends StatelessWidget {
  final String label;
  final String price;
  final bool greenPrice;

  const PriceRow({
    super.key,
    required this.label,
    required this.price,
    this.greenPrice = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      spacing: 10,
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
            style: theme.typo.main.bodyDefaultMedium.copyWith(color: greenPrice ? theme.colors.labelActive : theme.colors.textSecondary),
          ),
        ),
      ],
    );
  }
}

class ClaimedBooksRow extends StatelessWidget {
  final String quantity;
  final String title;
  final String price;
  final bool greenPrice;

  const ClaimedBooksRow({
    super.key,
    required this.quantity,
    required this.title,
    required this.price,
    this.greenPrice = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Row(
      spacing: 10,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            children: [
              Text(
                quantity,
                style: theme.typo.main.bodyDefaultRegular.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset( 
                '${ImagesPaths.imagesIcons}/icon_prime_circle.webp',
                width: 12,
                height: 12,
              ),
              const SizedBox(width: 4),
              Text(
                title,
                style: theme.typo.main.bodyDefaultRegular.copyWith(
                  color: theme.colors.textTertiary,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 100,
          child: Text(
            price,
            textAlign: TextAlign.right,
            style: theme.typo.main.bodyDefaultMedium.copyWith(color: greenPrice 
              ? theme.colors.labelActive 
              : theme.colors.textSecondary
            ),
          ),
        ),
      ],
    );
  }
}

class TotalPriceRow extends StatelessWidget {
  final DotbookTotalPriceItem totalPriceItem;

  const TotalPriceRow({
    super.key,
    required this.totalPriceItem,
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
              totalPriceItem.title,
              style: theme.typo.main.bodyLargeBold.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
            if (totalPriceItem.taxes != null) ...[
              const SizedBox(width: 6),
              Text(
                totalPriceItem.taxes!,
                style: theme.typo.main.bodyLargeMedium.copyWith(
                  color: theme.colors.textQuarternary,
                ),
              ),
            ],
          ],
        ),
        Text(
          totalPriceItem.price,
          style: theme.typo.main.bodyLargeBold.copyWith(
            color: theme.colors.textPrimary,
          ),
        ),
      ],
    );
  }
}
