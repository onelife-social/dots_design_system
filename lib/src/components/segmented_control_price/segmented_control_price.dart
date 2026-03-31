import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import 'segmented_control_price_option.dart';
import 'segmented_control_price_variant.dart';

class SegmentedControlPrice extends StatelessWidget {
  /// The variant of the segmented control price.
  final SegmentedControlPriceVariant variant;

  /// The label for the left option.
  final String leftOptionName;

  /// The label for the right option (required for [SegmentedControlPriceVariant.dual]).
  final String? rightOptionName;

  /// The price for the left option.
  final String leftOptionPrice;

  /// The price for the right option (required for [SegmentedControlPriceVariant.dual]).
  final String? rightOptionPrice;

  /// The trailing text for the left option price (e.g. "/año").
  final String? leftOptionPriceTrailing;

  /// The trailing text for the right option price (e.g. "/año").
  final String? rightOptionPriceTrailing;

  /// The description for the left option (e.g. "8,25€/mes").
  final String? leftOptionDescription;

  /// The description for the right option (e.g. "8,25€/mes").
  final String? rightOptionDescription;

  /// The tag for the left option (e.g. "17% OFF").
  final String? leftOptionTag;

  /// The tag for the right option (e.g. "17% OFF").
  final String? rightOptionTag;

  /// The currently selected option (ignored for [SegmentedControlPriceVariant.single]).
  final SegmentedControlOption selectedOption;

  /// The background color of the segmented control.
  final Color? backgroundColor;

  /// Callback when an option is tapped.
  final void Function(SegmentedControlOption optionTaped) onTapOption;

  const SegmentedControlPrice({
    super.key,
    this.variant = SegmentedControlPriceVariant.dual,
    required this.leftOptionName,
    this.rightOptionName,
    required this.leftOptionPrice,
    this.rightOptionPrice,
    this.leftOptionPriceTrailing,
    this.rightOptionPriceTrailing,
    this.leftOptionDescription,
    this.rightOptionDescription,
    this.leftOptionTag,
    this.rightOptionTag,
    required this.selectedOption,
    this.backgroundColor,
    required this.onTapOption,
  }) : assert(
         variant == SegmentedControlPriceVariant.single ||
             (rightOptionName != null && rightOptionPrice != null),
         'rightOptionName and rightOptionPrice are required for the dual variant',
       );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return DotsDecoratedBox(
      styleType: theme.styles.squircle16,
      decoration: BoxDecoration(
        color: backgroundColor ?? theme.colors.bgContainerSecondaryOnBackground,
      ),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: IntrinsicHeight(
          child: variant.isSingle ? _buildSingleOption() : _buildDualOptions(),
        ),
      ),
    );
  }

  Widget _buildSingleOption() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onTapOption(SegmentedControlOption.left),
      child: _buildOption(
        label: leftOptionName,
        price: leftOptionPrice,
        priceTrailingText: leftOptionPriceTrailing,
        description: leftOptionDescription,
        tag: leftOptionTag,
        isSelected: true,
      ),
    );
  }

  Widget _buildDualOptions() {
    return Row(
      spacing: 4,
      children: [
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTapOption(SegmentedControlOption.left),
            child: _buildOption(
              label: leftOptionName,
              price: leftOptionPrice,
              priceTrailingText: leftOptionPriceTrailing,
              description: leftOptionDescription,
              tag: leftOptionTag,
              isSelected: selectedOption.isLeft,
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onTapOption(SegmentedControlOption.right),
            child: _buildOption(
              label: rightOptionName!,
              price: rightOptionPrice!,
              priceTrailingText: rightOptionPriceTrailing,
              description: rightOptionDescription,
              tag: rightOptionTag,
              isSelected: selectedOption.isRight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOption({
    required String label,
    required String price,
    String? priceTrailingText,
    String? description,
    String? tag,
    required bool isSelected,
  }) {
    return SegmentedControlPriceOption(
      label: label,
      price: price,
      priceTrailingText: priceTrailingText,
      description: description,
      tag: tag,
      isSelected: isSelected,
    );
  }
}
