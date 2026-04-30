import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/date_time_range_selection.dart';
import '../models/enums.dart';

class DotbookDateRangeSelectorUtils {
  const DotbookDateRangeSelectorUtils._();

  static DateTime dateOnly(DateTime value) => DateTime(value.year, value.month, value.day);

  static DateTime previousMonth(DateTime value) => DateTime(value.year, value.month - 1, 1);

  static DateTime nextMonth(DateTime value) => DateTime(value.year, value.month + 1, 1);

  static bool canGoToPreviousMonth(DateTime focusedDay, DateTime firstAllowedDate) {
    final previous = previousMonth(focusedDay);
    return !previous.isBefore(DateTime(firstAllowedDate.year, firstAllowedDate.month, 1));
  }

  static bool canGoToNextMonth(DateTime focusedDay, DateTime lastAllowedDate) {
    final next = nextMonth(focusedDay);
    return !next.isAfter(DateTime(lastAllowedDate.year, lastAllowedDate.month, 1));
  }

  static DateTime clampDate(DateTime value, {DateTime? minDate, DateTime? maxDate}) {
    if (minDate != null && value.isBefore(minDate)) {
      return minDate;
    }

    if (maxDate != null && value.isAfter(maxDate)) {
      return maxDate;
    }

    return value;
  }

  static String formatDate(DateTime? value, String localeName) {
    if (value == null) {
      return '--/--/--';
    }

    return DateFormat('d MMMM y', localeName).format(value);
  }

  static String formatMonthYear(DateTime value, String localeName) {
    final formatted = DateFormat.yMMMM(localeName).format(value);
    return formatted.substring(0, 1).toUpperCase() + formatted.substring(1);
  }

  static String formatWeekday(DateTime value, String localeName) {
    final formatted = DateFormat('EEE', localeName).format(value).replaceAll('.', '');
    if (formatted.length <= 3) {
      return formatted;
    }

    return formatted.substring(0, 3);
  }

  static String localeName(BuildContext context) {
    final locale = Localizations.localeOf(context);
    if (locale.countryCode == null || locale.countryCode!.isEmpty) {
      return locale.languageCode;
    }

    return '${locale.languageCode}_${locale.countryCode}';
  }

  static StartingDayOfWeek startingDayOfWeek(BuildContext context) {
    switch (MaterialLocalizations.of(context).firstDayOfWeekIndex) {
      case 0:
        return StartingDayOfWeek.sunday;
      case 1:
        return StartingDayOfWeek.monday;
      case 2:
        return StartingDayOfWeek.tuesday;
      case 3:
        return StartingDayOfWeek.wednesday;
      case 4:
        return StartingDayOfWeek.thursday;
      case 5:
        return StartingDayOfWeek.friday;
      case 6:
        return StartingDayOfWeek.saturday;
      default:
        return StartingDayOfWeek.monday;
    }
  }

  static ({DateTimeRangeSelection selection, DateTime focusedDate, DotbookDateField? nextField})
  resolveSelectionChange({
    required DotbookDateField selectedField,
    required DateTime tappedDate,
    required DateTime startDate,
    required DateTime? endDate,
  }) {
    final selectedDate = dateOnly(tappedDate);
    var nextStartDate = dateOnly(startDate);
    DateTime? nextEndDate = endDate != null ? dateOnly(endDate) : null;
    DotbookDateField? nextField;
    var focusedDate = selectedDate;

    if (selectedField == DotbookDateField.start) {
      nextStartDate = selectedDate;
      if (nextEndDate != null && selectedDate.isAfter(nextEndDate)) {
        nextEndDate = selectedDate;
      }
      nextField = DotbookDateField.end;
      focusedDate = dateOnly(nextEndDate ?? selectedDate);
    } else {
      nextEndDate = selectedDate;
      if (selectedDate.isBefore(nextStartDate)) {
        nextStartDate = selectedDate;
      }
    }

    return (
      selection: DateTimeRangeSelection(
        startDate: nextStartDate,
        endDate: nextEndDate,
      ),
      focusedDate: focusedDate,
      nextField: nextField,
    );
  }
}
