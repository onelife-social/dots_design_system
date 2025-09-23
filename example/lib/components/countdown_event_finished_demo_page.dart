import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class CountdownEventFinishedDemoPage extends StatefulWidget {
  final CountdownEventFinishedVariant variant;
  final String title;
  final DotsIconData icon;
  final String years;
  final String months;
  final String days;
  final String yearsLabel;
  final String monthsLabel;
  final String daysLabel;
  final String conjunctionText;

  const CountdownEventFinishedDemoPage({
    super.key,
    required this.variant,
    required this.title,
    required this.icon,
    required this.years,
    required this.months,
    required this.days,
    required this.yearsLabel,
    required this.monthsLabel,
    required this.daysLabel,
    required this.conjunctionText,
  });
  @override
  State<CountdownEventFinishedDemoPage> createState() => _CountdownEventFinishedDemoPageState();
}

class _CountdownEventFinishedDemoPageState extends State<CountdownEventFinishedDemoPage> {
  @override
  Widget build(BuildContext context) {
    return CountdownEventFinished(
      variant: widget.variant,
      title: widget.title,
      icon: widget.icon,
      years: widget.years,
      months: widget.months,
      days: widget.days,
      yearsLabel: widget.yearsLabel,
      monthsLabel: widget.monthsLabel,
      daysLabel: widget.daysLabel,
      conjunctionText: widget.conjunctionText,
    );
  }
}
