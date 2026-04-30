import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class DotbookDateRangeSelector extends StatelessWidget {
  const DotbookDateRangeSelector({
    super.key,
    this.firstYearOptionTitle = '',
    this.specificYearOptionTitle = '',
    this.dateRangeOptionTitle = '',
    required this.selectedOption,
    required this.selectedField,
    required this.startDate,
    this.endDate,
    required this.initDateTitle,
    required this.endDateTitle,
    required this.onOptionChanged,
    required this.onFieldChanged,
    required this.onChanged,
    this.firstYearOptionDescription,
    this.specificYearOptionDescription,
    this.dateRangeOptionDescription,
    this.firstAllowedDate,
    this.lastAllowedDate,
    this.focusedDate,
    this.showCustomOption = true,
    this.currentDate,
    this.onFocusedDateChanged,
  });

  final String firstYearOptionTitle;
  final String specificYearOptionTitle;
  final String dateRangeOptionTitle;
  final String? firstYearOptionDescription;
  final String? specificYearOptionDescription;
  final String? dateRangeOptionDescription;
  final DotbookDateRangeOption selectedOption;
  final DotbookDateField selectedField;
  final DateTime startDate;
  final DateTime? endDate;
  final String initDateTitle;
  final String endDateTitle;
  final DateTime? firstAllowedDate;
  final DateTime? lastAllowedDate;
  final DateTime? focusedDate;
  final bool showCustomOption;
  final DateTime? currentDate;
  final ValueChanged<DotbookDateRangeOption> onOptionChanged;
  final ValueChanged<DotbookDateField> onFieldChanged;
  final ValueChanged<DateTimeRangeSelection> onChanged;
  final ValueChanged<DateTime>? onFocusedDateChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final localeName = DotbookDateRangeSelectorUtils.localeName(context);
    final normalizedStartDate = DotbookDateRangeSelectorUtils.dateOnly(startDate);
    final normalizedEndDate = endDate != null ? DotbookDateRangeSelectorUtils.dateOnly(endDate!) : null;
    final normalizedCurrentDate = DotbookDateRangeSelectorUtils.dateOnly(currentDate ?? DateTime.now());
    final normalizedFirstAllowedDate = DotbookDateRangeSelectorUtils.dateOnly(
      firstAllowedDate ?? DateTime(1970, 1, 1),
    );
    final normalizedLastAllowedDate = DotbookDateRangeSelectorUtils.dateOnly(
      lastAllowedDate ?? DateTime(2100),
    );
    final hasFirstYearOption = _hasVisibleLabel(firstYearOptionTitle);
    final hasSpecificYearOption = _hasVisibleLabel(specificYearOptionTitle);
    final hasDateRangeOption = showCustomOption && _hasVisibleLabel(dateRangeOptionTitle);
    final isCustomSelected = hasDateRangeOption && selectedOption == DotbookDateRangeOption.custom;
    final selectedDate = selectedField == DotbookDateField.start
        ? normalizedStartDate
        : normalizedEndDate ?? normalizedStartDate;
    final displayedDate = DotbookDateRangeSelectorUtils.clampDate(
      DotbookDateRangeSelectorUtils.dateOnly(
        focusedDate ??
            (selectedField == DotbookDateField.start
                ? normalizedStartDate
                : normalizedEndDate ?? normalizedStartDate),
      ),
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
            if (hasFirstYearOption)
              DotbookDateRangeOptionRow(
                title: firstYearOptionTitle,
                description: firstYearOptionDescription,
                isSelected: selectedOption == DotbookDateRangeOption.first,
                onTap: () => onOptionChanged(DotbookDateRangeOption.first),
              ),
            if (hasSpecificYearOption)
              DotbookDateRangeOptionRow(
                title: specificYearOptionTitle,
                description: specificYearOptionDescription,
                isSelected: selectedOption == DotbookDateRangeOption.second,
                onTap: () => onOptionChanged(DotbookDateRangeOption.second),
              ),
            if (hasDateRangeOption) ...[
              DotbookDateRangeOptionRow(
                title: dateRangeOptionTitle,
                description: dateRangeOptionDescription,
                isSelected: isCustomSelected,
                onTap: () => onOptionChanged(DotbookDateRangeOption.custom),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: isCustomSelected
                    ? DotbookCustomDateRangeSection(
                        key: const ValueKey('custom-date-range'),
                        localeName: localeName,
                        selectedField: selectedField,
                        startDate: normalizedStartDate,
                        endDate: normalizedEndDate,
                        currentDate: normalizedCurrentDate,
                        firstAllowedDate: normalizedFirstAllowedDate,
                        lastAllowedDate: normalizedLastAllowedDate,
                        displayedDate: displayedDate,
                        selectedDate: selectedDate,
                        initDateTitle: initDateTitle,
                        endDateTitle: endDateTitle,
                        onFieldChanged: onFieldChanged,
                        onDateSelected: _onDateSelected,
                        onFocusedDateChanged: onFocusedDateChanged,
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _onDateSelected(DateTime date) {
    final change = DotbookDateRangeSelectorUtils.resolveSelectionChange(
      selectedField: selectedField,
      tappedDate: date,
      startDate: startDate,
      endDate: endDate,
    );

    onChanged(change.selection);

    if (change.nextField != null) {
      onFieldChanged(change.nextField!);
    }

    onFocusedDateChanged?.call(change.focusedDate);
  }

  bool _hasVisibleLabel(String value) => value.trim().isNotEmpty;
}
