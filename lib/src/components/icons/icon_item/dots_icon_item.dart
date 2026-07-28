import 'package:flutter/material.dart';

import '../../../core/extensions/extensions_lib.dart';
import '../icons_lib.dart';

/// A widget that represents an icon item, which consists of an icon slot and a
/// text label with an optional supporting subtitle.
class DotsIconItem extends StatelessWidget {
  /// Type of the icon item, which determines the image to be displayed in the slot.
  final DotsIconItemSlotType type;

  /// Text label to be displayed next to the icon slot.
  final String label;

  /// Optional secondary line shown under [label] (e.g. a selection summary).
  final String? subtitle;

  /// Callback function to be called when the icon item is tapped.
  final VoidCallback? onTap;

  const DotsIconItem({
    required this.type,
    required this.label,
    this.subtitle,
    this.onTap,
    super.key,
  });

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
                  const SizedBox(width: 14),
                  Expanded(child: _labelColumn(context)),
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

  Widget _labelColumn(BuildContext context) {
    final theme = context.dotsTheme;
    final Text labelText = Text(
      label,
      style: theme.typo.main.bodyLargeMedium.copyWith(
        color: theme.colors.textPrimary,
      ),
    );

    if (subtitle == null) {
      return labelText;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText,
        const SizedBox(height: 2),
        Text(
          subtitle!,
          style: theme.typo.main.labelDefaultRegular.copyWith(
            color: theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
