import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSettingItemRadioBtn extends StatelessWidget {
  /// True if this radio button is selected.
  final bool isSelected;

  /// The main label (left label).
  final String leadingLabel;

  /// The secondary label (right label).
  final String? trailingLabel;

  /// Called when the item is tapped.
  final Function()? onTap;

  const DotsSettingItemRadioBtn({
    super.key,
    required this.isSelected,
    required this.leadingLabel,
    this.trailingLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: context.dotsTheme.colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DotsRadioButton(
                isSelected: isSelected,
                size: 22,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  leadingLabel,
                  style: context.dotsTheme.typo.main.bodyDefaultBold,
                  softWrap: true,
                ),
              ),
              const SizedBox(width: 12),
              if (trailingLabel != null)
                Text(
                  trailingLabel!,
                  style: context.dotsTheme.typo.main.bodyDefaultMedium.copyWith(
                    color: context.dotsTheme.colors.textTertiary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
