import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/components/components_lib.dart';
import 'package:dots_design_system/src/core/core_lib.dart';
import 'package:flutter/material.dart';

class SegmentedControlPriceOption extends StatelessWidget {
  final String label;
  final String price;
  final String? priceTrailingText;
  final String? description;
  final String? tag;
  final bool isSelected;

  const SegmentedControlPriceOption({
    super.key,
    required this.label,
    required this.price,
    this.priceTrailingText,
    this.description,
    this.tag,
    this.isSelected = false,
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
              Row(
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
                        color: isSelected
                            ? theme.colors.textQuarternary
                            : theme.colors.textDisabled,
                      ),
                    ),
                ],
              ),
              if (description != null)
                Text(
                  description!,
                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: isSelected ? theme.colors.textQuarternary : theme.colors.textDisabled,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
