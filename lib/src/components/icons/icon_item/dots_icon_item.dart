import 'package:flutter/material.dart';

import '../../../core/extensions/extensions_lib.dart';
import '../icons_lib.dart';

/// A widget that represents an icon item, which consists of an icon slot and a text label.
class DotsIconItem extends StatelessWidget {
  /// Type of the icon item, which determines the image to be displayed in the slot.
  final DotsIconItemSlotType type;

  /// Text label to be displayed next to the icon slot.
  final String label;

  /// Callback function to be called when the icon item is tapped.
  final VoidCallback? onTap;

  const DotsIconItem({required this.type, required this.label, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DotsIconItemSlot(type: type),
                  SizedBox(width: 12),
                  Text(
                    label,
                    style: context.dotsTheme.typo.main.bodyLargeMedium.copyWith(
                      color: context.dotsTheme.colors.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            DotsIcon(
              iconData: DotsIconData.chevronRight,
              color: context.dotsTheme.colors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
