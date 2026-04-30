import 'package:dots_design_system/dots_design_system.dart';
import 'package:cupertino_calendar_picker/cupertino_calendar_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum DotbookDateRangeOption {
  first,
  second,
  custom,
}

enum DotbookDateField {
  start,
  end,
}

class DotbookDateRangeSelector extends StatelessWidget {
  const DotbookDateRangeSelector({
    super.key,
    required this.firstOptionLabel,
    required this.secondOptionLabel,
    required this.thirdOptionLabel,
    required this.selectedOption,
    required this.selectedField,
    required this.startDate,
    this.endDate,
    required this.initDateTitle,
    required this.endDateTitle,
    required this.onOptionChanged,
    required this.onFieldChanged,
    required this.onChanged,
    this.firstOptionDescription,
    this.secondOptionDescription,
    this.thirdOptionDescription,
    this.firstAllowedDate,
    this.lastAllowedDate,
    this.focusedDate,
    this.showCustomOption = true,
    this.currentDate,
    this.onFocusedDateChanged,
  });

  final String firstOptionLabel;
  final String secondOptionLabel;
  final String thirdOptionLabel;
  final String? firstOptionDescription;
  final String? secondOptionDescription;
  final String? thirdOptionDescription;
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
    final localeName = _localeName(context);
    final normalizedStartDate = _dateOnly(startDate);
    final normalizedEndDate = endDate != null ? _dateOnly(endDate!) : null;
    final normalizedCurrentDate = _dateOnly(currentDate ?? DateTime.now());
    final normalizedFirstAllowedDate = _dateOnly(firstAllowedDate ?? DateTime(1970, 1, 1));
    final normalizedLastAllowedDate = _dateOnly(lastAllowedDate ?? DateTime(2100));
    final isCustomSelected = selectedOption == DotbookDateRangeOption.custom;
    final selectedDate = selectedField == DotbookDateField.start
        ? normalizedStartDate
        : normalizedEndDate ?? normalizedStartDate;
    final displayedDate = _clampDate(
      _dateOnly(
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
            _DateRangeOptionRow(
              title: firstOptionLabel,
              description: firstOptionDescription,
              isSelected: selectedOption == DotbookDateRangeOption.first,
              onTap: () => onOptionChanged(DotbookDateRangeOption.first),
            ),
            _DateRangeOptionRow(
              title: secondOptionLabel,
              description: secondOptionDescription,
              isSelected: selectedOption == DotbookDateRangeOption.second,
              onTap: () => onOptionChanged(DotbookDateRangeOption.second),
            ),
            if (showCustomOption) ...[
              _DateRangeOptionRow(
                title: thirdOptionLabel,
                description: thirdOptionDescription,
                isSelected: isCustomSelected,
                onTap: () => onOptionChanged(DotbookDateRangeOption.custom),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: isCustomSelected
                    ? Column(
                        key: const ValueKey('custom-date-range'),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 12,
                        children: [
                          IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Expanded(
                                  child: _DateFieldCard(
                                    label: initDateTitle,
                                    value: _formatDate(normalizedStartDate, localeName),
                                    isActive: selectedField == DotbookDateField.start,
                                    onTap: () => onFieldChanged(DotbookDateField.start),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: _DateFieldCard(
                                    label: endDateTitle,
                                    value: _formatDate(normalizedEndDate, localeName),
                                    isActive: selectedField == DotbookDateField.end,
                                    onTap: () => onFieldChanged(DotbookDateField.end),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: DotsBorderRadius.r16,
                            child: Container(
                              color: theme.colors.bgContainerSecondary,
                              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                              child: Theme(
                                data: Theme.of(context),
                                child: CupertinoCalendar(
                                  key: ValueKey(
                                    '${selectedField.name}-${selectedDate.millisecondsSinceEpoch}-${displayedDate.millisecondsSinceEpoch}',
                                  ),
                                  initialDateTime: selectedDate,
                                  minimumDateTime: normalizedFirstAllowedDate,
                                  maximumDateTime: normalizedLastAllowedDate,
                                  currentDateTime: normalizedCurrentDate,
                                  firstDayOfWeekIndex: MaterialLocalizations.of(
                                    context,
                                  ).firstDayOfWeekIndex,
                                  onDateTimeChanged: _onDateSelected,
                                  onDateSelected: _onDateSelected,
                                  onDisplayedMonthChanged: (date) {
                                    onFocusedDateChanged?.call(_dateOnly(date));
                                  },
                                  mainColor: theme.colors.labelHighlight,
                                  use24hFormat: MediaQuery.alwaysUse24HourFormatOf(context),
                                  mode: CupertinoCalendarMode.date,
                                  type: CupertinoCalendarType.inline,
                                  monthPickerDecoration: CalendarMonthPickerDecoration(
                                    defaultDayStyle: CalendarMonthPickerDefaultDayStyle(
                                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                                        color: theme.colors.textPrimary,
                                      ),
                                    ),
                                    currentDayStyle: CalendarMonthPickerCurrentDayStyle(
                                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                                        color: theme.colors.labelHighlight,
                                      ),
                                    ),
                                    selectedDayStyle: CalendarMonthPickerSelectedDayStyle(
                                      mainColor: theme.colors.labelHighlight,
                                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                                        color: theme.colors.labelHighlight,
                                      ),
                                    ),
                                    selectedCurrentDayStyle:
                                        CalendarMonthPickerSelectedCurrentDayStyle(
                                          mainColor: theme.colors.labelHighlight,
                                          backgroundCircleColor: theme.colors.labelHighlight
                                              .dotsWithOpacity(0.20),
                                          textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                                            color: theme.colors.labelHighlight,
                                          ),
                                        ),
                                    disabledDayStyle: CalendarMonthPickerDisabledDayStyle(
                                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                                        color: theme.colors.textQuarternary,
                                      ),
                                    ),
                                  ),
                                  weekdayDecoration: CalendarWeekdayDecoration(
                                    textStyle: theme.typo.main.labelDefaultRegular.copyWith(
                                      color: theme.colors.textQuarternary,
                                    ),
                                  ),
                                  headerDecoration: CalendarHeaderDecoration(
                                    mainColor: theme.colors.labelHighlight,
                                    monthDateStyle: theme.typo.main.bodyLargeMedium.copyWith(
                                      color: theme.colors.textPrimary,
                                    ),
                                    monthDateArrowColor: theme.colors.labelHighlight,
                                    forwardButtonColor: theme.colors.labelHighlight,
                                    backwardButtonColor: theme.colors.labelHighlight,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
    final selectedDate = _dateOnly(date);
    var nextStartDate = _dateOnly(startDate);
    DateTime? nextEndDate = endDate != null ? _dateOnly(endDate!) : null;
    final shouldMoveToEndField = selectedField == DotbookDateField.start && nextEndDate == null;

    if (selectedField == DotbookDateField.start) {
      nextStartDate = selectedDate;
      if (nextEndDate != null && selectedDate.isAfter(nextEndDate)) {
        nextEndDate = selectedDate;
      }
    } else {
      nextEndDate = selectedDate;
      if (selectedDate.isBefore(nextStartDate)) {
        nextStartDate = selectedDate;
      }
    }

    onChanged(
      DateTimeRangeSelection(
        option: DotbookDateRangeOption.custom,
        startDate: nextStartDate,
        endDate: nextEndDate,
      ),
    );

    if (shouldMoveToEndField) {
      onFieldChanged(DotbookDateField.end);
      onFocusedDateChanged?.call(_dateOnly(nextEndDate ?? selectedDate));
      return;
    }

    onFocusedDateChanged?.call(selectedDate);
  }

  DateTime _dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);

  DateTime _clampDate(DateTime value, {DateTime? minDate, DateTime? maxDate}) {
    if (minDate != null && value.isBefore(minDate)) {
      return minDate;
    }

    if (maxDate != null && value.isAfter(maxDate)) {
      return maxDate;
    }

    return value;
  }

  String _formatDate(DateTime? value, String localeName) {
    if (value == null) {
      return '--/--/--';
    }

    return DateFormat('d MMMM y', localeName).format(value);
  }

  String _localeName(BuildContext context) {
    final locale = Localizations.localeOf(context);

    if (locale.countryCode == null || locale.countryCode!.isEmpty) {
      return locale.languageCode;
    }

    return '${locale.languageCode}_${locale.countryCode}';
  }
}

class _DateRangeOptionRow extends StatelessWidget {
  final String title;
  final String? description;
  final bool isSelected;
  final Function()? onTap;

  const _DateRangeOptionRow({
    required this.title,
    this.description,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            DotsRadioButton(isSelected: isSelected),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.typo.main.bodyLargeMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                  ),
                  if (description != null && description!.isNotEmpty)
                    Text(
                      description!,
                      style: theme.typo.main.bodyDefaultRegular.copyWith(
                        color: theme.colors.textTertiary,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateFieldCard extends StatelessWidget {
  const _DateFieldCard({
    required this.label,
    required this.value,
    required this.isActive,
    this.onTap,
  });

  final String label;
  final String value;
  final bool isActive;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 13, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: theme.colors.bgContainerSecondary,
          borderRadius: DotsBorderRadius.r16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 4,
          children: [
            Text(
              label,
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.textQuarternary,
              ),
            ),
            Text(
              value,
              style: theme.typo.main.bodyLargeMedium.copyWith(
                color: isActive ? theme.colors.labelHighlight : theme.colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateTimeRangeSelection {
  const DateTimeRangeSelection({
    required this.option,
    required this.startDate,
    required this.endDate,
  });

  final DotbookDateRangeOption option;
  final DateTime startDate;
  final DateTime? endDate;
}
