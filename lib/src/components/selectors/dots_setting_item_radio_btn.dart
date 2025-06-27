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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomDivider(context: context),
        GestureDetector(
          onTap: onTap,
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
                Text(
                  leadingLabel,
                  style: context.dotsTheme.typo.main.bodyDefaultBold,
                ),
                const Spacer(),
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
        CustomDivider(context: context),
      ],
    );
  }
}

class CustomDivider extends StatelessWidget {
  final BuildContext context;

  const CustomDivider({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 0,
      thickness: 0.5,
      color: context.dotsTheme.colors.labelSecondary.dotsWithOpacity(0.3),
      indent: 44.3,
      endIndent: 16.0,
    );
  }
}
