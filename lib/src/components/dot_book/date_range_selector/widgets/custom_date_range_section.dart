import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 12,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: DotbookDateFieldCard(
                  label: initDateTitle,
                  value: DotbookDateRangeSelectorUtils.formatDate(startDate, localeName),
                  isActive: selectedField == DotbookDateField.start,
                  onTap: () => onFieldChanged(DotbookDateField.start),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DotbookDateFieldCard(
                  label: endDateTitle,
                  value: DotbookDateRangeSelectorUtils.formatDate(endDate, localeName),
                  isActive: selectedField == DotbookDateField.end,
                  onTap: () => onFieldChanged(DotbookDateField.end),
                ),
              ),
            ],
          ),
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
                    weekdayStyle: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textQuarternary,
                    ),
                    weekendStyle: theme.typo.main.labelDefaultRegular.copyWith(
                      color: theme.colors.textQuarternary,
                    ),
                  ),
                  calendarStyle: CalendarStyle(
                    outsideDaysVisible: false,
                    cellMargin: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                    rangeHighlightScale: 1,
                    rangeHighlightColor: rangeFillColor,
                    selectedDecoration: BoxDecoration(
                      color: theme.colors.labelHighlight,
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.labelAlwaysWhite,
                    ),
                    rangeStartDecoration: BoxDecoration(
                      color: theme.colors.labelHighlight,
                      shape: BoxShape.circle,
                    ),
                    rangeEndDecoration: BoxDecoration(
                      color: theme.colors.labelHighlight,
                      shape: BoxShape.circle,
                    ),
                    rangeStartTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.labelAlwaysWhite,
                    ),
                    rangeEndTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.labelAlwaysWhite,
                    ),
                    withinRangeDecoration: BoxDecoration(
                      color: rangeFillColor,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    withinRangeTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                    todayDecoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colors.labelHighlight.dotsWithOpacity(0.35),
                      ),
                      shape: BoxShape.circle,
                    ),
                    todayTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                    defaultDecoration: const BoxDecoration(shape: BoxShape.circle),
                    weekendDecoration: const BoxDecoration(shape: BoxShape.circle),
                    defaultTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                    weekendTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.textPrimary,
                    ),
                    disabledTextStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                      color: theme.colors.textQuarternary,
                    ),
                  ),
                  calendarBuilders: CalendarBuilders<DateTime>(
                    dowBuilder: (context, day) => Center(
                      child: Text(
                        DotbookDateRangeSelectorUtils.formatWeekday(day, localeName),
                        style: theme.typo.main.labelDefaultRegular.copyWith(
                          color: theme.colors.textQuarternary,
                        ),
                      ),
                    ),
                    selectedBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.labelAlwaysWhite,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                    ),
                    defaultBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                    ),
                    todayBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colors.labelHighlight.dotsWithOpacity(0.35),
                        ),
                        shape: BoxShape.circle,
                      ),
                    ),
                    disabledBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.textQuarternary,
                      ),
                    ),
                    withinRangeBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.textPrimary,
                      ),
                      decoration: BoxDecoration(
                        color: rangeFillColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    rangeStartBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.labelAlwaysWhite,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                      backgroundMargin: const EdgeInsets.only(
                        left: 16,
                        top: 5,
                        right: 0,
                        bottom: 5,
                      ),
                    ),
                    rangeEndBuilder: (context, day, focusedDay) => DotbookCalendarDayCell(
                      text: '${day.day}',
                      textStyle: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: theme.colors.labelAlwaysWhite,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colors.labelHighlight,
                        shape: BoxShape.circle,
                      ),
                      backgroundMargin: const EdgeInsets.only(
                        left: 0,
                        top: 5,
                        right: 16,
                        bottom: 5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showMonthYearPicker(BuildContext context) async {
    DateTime tempDate = displayedDate;
    final theme = context.dotsTheme;

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
                        onFocusedDateChanged?.call(DotbookDateRangeSelectorUtils.dateOnly(tempDate));
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
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.monthYear,
                    initialDateTime: displayedDate,
                    minimumDate: firstAllowedDate,
                    maximumDate: lastAllowedDate,
                    onDateTimeChanged: (value) {
                      tempDate = DotbookDateRangeSelectorUtils.dateOnly(value);
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
