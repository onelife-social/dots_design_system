import 'package:flutter/material.dart';

class DotbookDateRangeSelectorItem {
  const DotbookDateRangeSelectorItem({
    required this.title,
    this.subtitle,
    this.isSelected = false,
    this.showCalendar = false,
    this.onTap,
  });

  /// Main text shown in the row.
  final String title;

  /// Optional secondary text shown below the title.
  final String? subtitle;

  /// Whether this row is currently selected.
  final bool isSelected;

  /// Whether selecting this row should reveal the calendar section.
  final bool showCalendar;

  /// Callback triggered when the row is tapped.
  final VoidCallback? onTap;
}
