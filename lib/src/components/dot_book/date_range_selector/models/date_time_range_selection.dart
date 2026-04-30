import 'enums.dart';

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
