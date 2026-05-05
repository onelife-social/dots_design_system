import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookDateRangeSelector extends StatelessWidget {
  const DotbookDateRangeSelector({
    super.key,
    required this.items,
    this.content,
  });

  /// Rows rendered by the selector.
  final List<DotbookDateRangeSelectorItem> items;

  /// Custom widget rendered below the selected option.
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final visibleOptions = _visibleItems;
    final selectedVisibleOption = visibleOptions.where((option) => option.isSelected).firstOrNull;
    final shouldShowContent = (selectedVisibleOption?.showContent ?? false) && content != null;

    return DotsDecoratedBox(
      styleType: theme.styles.defaultShadow,
      decoration: BoxDecoration(
        color: theme.colors.bgStrong,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            ...visibleOptions.map(
              (option) => DotbookDateRangeOptionRow(
                title: option.title,
                description: option.subtitle,
                isSelected: option.isSelected,
                onTap: option.onTap,
              ),
            ),
            if (shouldShowContent && content != null)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: KeyedSubtree(
                  key: ValueKey(selectedVisibleOption?.title),
                  child: content!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  bool _hasVisibleLabel(String value) => value.trim().isNotEmpty;

  List<DotbookDateRangeSelectorItem> get _visibleItems =>
      items.where((item) => _hasVisibleLabel(item.title)).toList(growable: false);
}
