import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotbookDateRangeSelector extends StatelessWidget {
  const DotbookDateRangeSelector({
    super.key,
    required this.items,
    this.selectedField,
    this.startDate,
    this.endDate,
    this.initDateTitle,
    this.endDateTitle,
    this.onFieldChanged,
    this.onChanged,
    this.firstAllowedDate,
    this.lastAllowedDate,
    this.focusedDate,
    this.currentDate,
    this.onFocusedDateChanged,
  });

  /// Rows rendered by the selector.
  final List<DotbookDateRangeSelectorItem> items;

  /// Currently active field inside the calendar section (`start` or `end`).
  final DotbookDateField? selectedField;

  /// Current start date value to display at the start date card.
  final DateTime? startDate;

  /// Current end date value to display at the end date card. It can be null until the user picks it.
  final DateTime? endDate;

  /// Label shown above the start date card.
  final String? initDateTitle;

  /// Label shown above the end date card.
  final String? endDateTitle;

  /// Minimum allowed date for the calendar.
  final DateTime? firstAllowedDate;

  /// Maximum allowed date for the calendar.
  final DateTime? lastAllowedDate;

  /// Focused month/day used by the calendar UI.
  final DateTime? focusedDate;

  /// Date considered as “today” in the calendar.
  final DateTime? currentDate;

  /// Called when the active date field changes.
  final ValueChanged<DotbookDateField>? onFieldChanged;

  /// Called when start/end dates change.
  final ValueChanged<DateTimeRangeSelection>? onChanged;

  /// Called when the focused calendar date changes.
  final ValueChanged<DateTime>? onFocusedDateChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final localeName = DotbookDateRangeSelectorUtils.localeName(context);
    final resolvedSelectedField = selectedField ?? DotbookDateField.startDate;
    final normalizedStartDate = DotbookDateRangeSelectorUtils.dateOnly(startDate ?? DateTime.now());
    final normalizedEndDate = endDate == null ? null : DotbookDateRangeSelectorUtils.dateOnly(endDate!);
    final normalizedCurrentDate = DotbookDateRangeSelectorUtils.dateOnly(currentDate ?? DateTime.now());
    final normalizedFirstAllowedDate = DotbookDateRangeSelectorUtils.dateOnly(
      firstAllowedDate ?? DateTime(1970, 1, 1),
    );
    final normalizedLastAllowedDate = DotbookDateRangeSelectorUtils.dateOnly(
      lastAllowedDate ?? DateTime(2100),
    );
    final visibleOptions = _visibleItems;
    final selectedVisibleOption = visibleOptions.where((option) => option.isSelected).firstOrNull;
    final shouldShowCalendar = selectedVisibleOption?.showCalendar ?? false;
    final selectedDate = resolvedSelectedField == DotbookDateField.startDate
        ? normalizedStartDate
        : normalizedEndDate ?? normalizedStartDate;
    final baseFocusedDate = focusedDate ??
      (resolvedSelectedField == DotbookDateField.startDate
        ? normalizedStartDate
        : normalizedEndDate ?? normalizedStartDate);
    final displayedDate = DotbookDateRangeSelectorUtils.clampDate(
      DotbookDateRangeSelectorUtils.dateOnly(baseFocusedDate),
      minDate: normalizedFirstAllowedDate,
      maxDate: normalizedLastAllowedDate,
    );

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
            if (shouldShowCalendar)
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: DotbookCustomDateRangeSection(
                  key: ValueKey(selectedVisibleOption?.title),
                  localeName: localeName,
                  selectedField: resolvedSelectedField,
                  startDate: normalizedStartDate,
                  endDate: normalizedEndDate,
                  currentDate: normalizedCurrentDate,
                  firstAllowedDate: normalizedFirstAllowedDate,
                  lastAllowedDate: normalizedLastAllowedDate,
                  displayedDate: displayedDate,
                  selectedDate: selectedDate,
                  initDateTitle: initDateTitle ?? '',
                  endDateTitle: endDateTitle ?? '',
                  onFieldChanged: (field) => onFieldChanged?.call(field),
                  onDateSelected: _onDateSelected,
                  onFocusedDateChanged: onFocusedDateChanged,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    final resolvedSelectedField = selectedField ?? DotbookDateField.startDate;
    final resolvedStartDate = startDate ?? DateTime.now();

    final change = DotbookDateRangeSelectorUtils.resolveSelectionChange(
      selectedField: resolvedSelectedField,
      tappedDate: date,
      startDate: resolvedStartDate,
      endDate: endDate,
    );

    onChanged?.call(change.selection);

    if (change.nextField != null) {
      onFieldChanged?.call(change.nextField!);
    }

    onFocusedDateChanged?.call(change.focusedDate);
  }

  bool _hasVisibleLabel(String value) => value.trim().isNotEmpty;

  List<DotbookDateRangeSelectorItem> get _visibleItems =>
      items.where((item) => _hasVisibleLabel(item.title)).toList(growable: false);
}
