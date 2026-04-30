import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class DotbookCustomDateRangeSection extends StatelessWidget {
  const DotbookCustomDateRangeSection({
    super.key,
    required this.localeName,
    required this.selectedField,
    required this.startDate,
    required this.endDate,
    required this.currentDate,
    required this.firstAllowedDate,
    required this.lastAllowedDate,
    required this.displayedDate,
    required this.selectedDate,
    required this.initDateTitle,
    required this.endDateTitle,
    required this.onFieldChanged,
    required this.onDateSelected,
    this.onFocusedDateChanged,
  });

  final String localeName;
  final DotbookDateField selectedField;
  final DateTime startDate;
  final DateTime? endDate;
  final DateTime currentDate;
  final DateTime firstAllowedDate;
  final DateTime lastAllowedDate;
  final DateTime displayedDate;
  final DateTime selectedDate;
  final String initDateTitle;
  final String endDateTitle;
  final ValueChanged<DotbookDateField> onFieldChanged;
  final ValueChanged<DateTime> onDateSelected;
  final ValueChanged<DateTime>? onFocusedDateChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final rangeFillColor = theme.colors.labelHighlight.dotsWithOpacity(0.16);
    final dayTextStyle = theme.typo.main.bodyDefaultMedium;
    final weekdayTextStyle = theme.typo.main.labelDefaultRegular.copyWith(
      color: theme.colors.textQuarternary,
    );
    final selectedDayTextStyle = dayTextStyle.copyWith(
      color: theme.colors.labelAlwaysWhite,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        _DateFieldsRow(
          localeName: localeName,
          selectedField: selectedField,
          startDate: startDate,
          endDate: endDate,
          initDateTitle: initDateTitle,
          endDateTitle: endDateTitle,
          onFieldChanged: onFieldChanged,
        ),
        ClipRRect(
          borderRadius: DotsBorderRadius.r16,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                DotbookCalendarHeader(
                  title: DotbookDateRangeSelectorUtils.formatMonthYear(displayedDate, localeName),
                  onTitleTap: () => _showMonthYearPicker(context),
                  onPreviousMonth: DotbookDateRangeSelectorUtils.canGoToPreviousMonth(
                    displayedDate,
                    firstAllowedDate,
                  )
                      ? () => onFocusedDateChanged?.call(
                          DotbookDateRangeSelectorUtils.previousMonth(displayedDate),
                        )
                      : null,
                  onNextMonth: DotbookDateRangeSelectorUtils.canGoToNextMonth(
                    displayedDate,
                    lastAllowedDate,
                  )
                      ? () => onFocusedDateChanged?.call(
                          DotbookDateRangeSelectorUtils.nextMonth(displayedDate),
                        )
                      : null,
                ),
                const SizedBox(height: 8),
                TableCalendar<DateTime>(
                  locale: localeName,
                  headerVisible: false,
                  firstDay: firstAllowedDate,
                  lastDay: lastAllowedDate,
                  focusedDay: displayedDate,
                  currentDay: currentDate,
                  rangeStartDay: endDate != null ? startDate : null,
                  rangeEndDay: endDate,
                  availableCalendarFormats: const {CalendarFormat.month: 'month'},
                  calendarFormat: CalendarFormat.month,
                  startingDayOfWeek: DotbookDateRangeSelectorUtils.startingDayOfWeek(context),
                  availableGestures: AvailableGestures.horizontalSwipe,
                  rowHeight: 38,
                  daysOfWeekHeight: 22,
                  selectedDayPredicate: (day) => isSameDay(day, selectedDate),
                  onDaySelected: (pickedDay, focusedDay) {
                    onFocusedDateChanged?.call(DotbookDateRangeSelectorUtils.dateOnly(focusedDay));
                    onDateSelected(pickedDay);
                  },
                  onPageChanged: (focusedDay) {
                    onFocusedDateChanged?.call(DotbookDateRangeSelectorUtils.dateOnly(focusedDay));
                  },
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: weekdayTextStyle,
                    weekendStyle: weekdayTextStyle,
                  ),
                  calendarStyle: _buildCalendarStyle(
                    theme: theme,
                    rangeFillColor: rangeFillColor,
                    dayTextStyle: dayTextStyle,
                    selectedDayTextStyle: selectedDayTextStyle,
                  ),
                  calendarBuilders: _buildCalendarBuilders(
                    theme: theme,
                    rangeFillColor: rangeFillColor,
                    weekdayTextStyle: weekdayTextStyle,
                    dayTextStyle: dayTextStyle,
                    selectedDayTextStyle: selectedDayTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  CalendarStyle _buildCalendarStyle({
    required DotsTheme theme,
    required Color rangeFillColor,
    required TextStyle dayTextStyle,
    required TextStyle selectedDayTextStyle,
  }) {
    return CalendarStyle(
      outsideDaysVisible: false,
      cellMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      rangeHighlightScale: 1,
      rangeHighlightColor: rangeFillColor,
      selectedDecoration: BoxDecoration(
        color: theme.colors.labelHighlight,
        shape: BoxShape.circle,
      ),
      selectedTextStyle: selectedDayTextStyle,
      rangeStartDecoration: BoxDecoration(
        color: theme.colors.labelHighlight,
        shape: BoxShape.circle,
      ),
      rangeEndDecoration: BoxDecoration(
        color: theme.colors.labelHighlight,
        shape: BoxShape.circle,
      ),
      rangeStartTextStyle: selectedDayTextStyle,
      rangeEndTextStyle: selectedDayTextStyle,
      withinRangeDecoration: BoxDecoration(
        color: rangeFillColor,
        borderRadius: BorderRadius.circular(999),
      ),
      withinRangeTextStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
      todayDecoration: BoxDecoration(
        border: Border.all(color: theme.colors.labelHighlight.dotsWithOpacity(0.35)),
        shape: BoxShape.circle,
      ),
      todayTextStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
      defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
      weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
      defaultTextStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
      weekendTextStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
      disabledTextStyle: dayTextStyle.copyWith(color: theme.colors.textQuarternary),
    );
  }

  CalendarBuilders<DateTime> _buildCalendarBuilders({
    required DotsTheme theme,
    required Color rangeFillColor,
    required TextStyle weekdayTextStyle,
    required TextStyle dayTextStyle,
    required TextStyle selectedDayTextStyle,
  }) {
    return CalendarBuilders<DateTime>(
                    dowBuilder: (context, day) => Center(
                      child: Text(
                        DotbookDateRangeSelectorUtils.formatWeekday(day, localeName),
                        style: weekdayTextStyle,
                      ),
                    ),
                    selectedBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: selectedDayTextStyle,
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                    defaultBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
                    ),
                    todayBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colors.labelHighlight.dotsWithOpacity(0.35),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    disabledBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: dayTextStyle.copyWith(color: theme.colors.textQuarternary),
                    ),
                    withinRangeBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: dayTextStyle.copyWith(color: theme.colors.textPrimary),
                      decoration: BoxDecoration(
                        color: rangeFillColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    rangeStartBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: selectedDayTextStyle,
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                    rangeEndBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: selectedDayTextStyle,
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
  }

  Future<void> _showMonthYearPicker(BuildContext context) async {
    var selectedYear = displayedDate.year;
    var selectedMonth = displayedDate.month;
    final theme = context.dotsTheme;
    final years = List<int>.generate(
      lastAllowedDate.year - firstAllowedDate.year + 1,
      (index) => firstAllowedDate.year + index,
    );
    final monthController = FixedExtentScrollController(initialItem: selectedMonth - 1);
    final yearController = FixedExtentScrollController(
      initialItem: years.indexOf(selectedYear),
    );

    String monthLabel(int month) {
      final formatted = DateFormat('MMMM', localeName).format(DateTime(2000, month));
      return formatted.substring(0, 1).toUpperCase() + formatted.substring(1);
    }

    DateTime resolvedFocusedDate() => DotbookDateRangeSelectorUtils.clampDate(
          DateTime(selectedYear, selectedMonth, 1),
          minDate: DateTime(firstAllowedDate.year, firstAllowedDate.month, 1),
          maxDate: DateTime(lastAllowedDate.year, lastAllowedDate.month, 1),
        );

    await showCupertinoModalPopup<void>(
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: Column(
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CupertinoButton(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      onPressed: () {
                        onFocusedDateChanged?.call(resolvedFocusedDate());
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        MaterialLocalizations.of(context).okButtonLabel,
                        style: theme.typo.main.bodyLargeMedium.copyWith(
                          color: theme.colors.labelHighlight,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CupertinoTheme(
                  data: CupertinoThemeData(
                    brightness: Theme.of(context).brightness,
                    textTheme: CupertinoTextThemeData(
                      dateTimePickerTextStyle: theme.typo.main.bodyLargeMedium.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: monthController,
                          itemExtent: 36,
                          useMagnifier: true,
                          magnification: 1.05,
                          onSelectedItemChanged: (index) {
                            selectedMonth = index + 1;
                          },
                          children: List<Widget>.generate(
                            12,
                            (index) => Center(
                              child: Text(monthLabel(index + 1)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker(
                          scrollController: yearController,
                          itemExtent: 36,
                          useMagnifier: true,
                          magnification: 1.05,
                          onSelectedItemChanged: (index) {
                            selectedYear = years[index];
                          },
                          children: years
                              .map((year) => Center(child: Text(year.toString())))
                              .toList(growable: false),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    monthController.dispose();
    yearController.dispose();
  }
}

class _DateFieldsRow extends StatelessWidget {
  const _DateFieldsRow({
    required this.localeName,
    required this.selectedField,
    required this.startDate,
    required this.endDate,
    required this.initDateTitle,
    required this.endDateTitle,
    required this.onFieldChanged,
  });

  final String localeName;
  final DotbookDateField selectedField;
  final DateTime startDate;
  final DateTime? endDate;
  final String initDateTitle;
  final String endDateTitle;
  final ValueChanged<DotbookDateField> onFieldChanged;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: DotbookDateFieldCard(
              label: initDateTitle,
              value: DotbookDateRangeSelectorUtils.formatDate(startDate, localeName),
              isActive: selectedField == DotbookDateField.startDate,
              onTap: () => onFieldChanged(DotbookDateField.startDate),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: DotbookDateFieldCard(
              label: endDateTitle,
              value: DotbookDateRangeSelectorUtils.formatDate(endDate, localeName),
              isActive: selectedField == DotbookDateField.endDate,
              onTap: () => onFieldChanged(DotbookDateField.endDate),
            ),
          ),
        ],
      ),
    );
  }
}
