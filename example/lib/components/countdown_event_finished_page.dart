import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class CountdownEventFinishedDemoPage extends StatefulWidget {
  final CountdownEventFinishedVariant variant;
  final String title;
  final DotsIconData icon;
  final int years;
  final int months;
  final int days;
  final String yearsLabel;
  final String monthsLabel;
  final String daysLabel;

  const CountdownEventFinishedDemoPage(
      {super.key,
      required this.variant,
      required this.title,
      required this.icon,
      required this.years,
      required this.months,
      required this.days,
      required this.yearsLabel,
      required this.monthsLabel,
      required this.daysLabel});
  @override
  State<CountdownEventFinishedDemoPage> createState() => _CountdownEventFinishedDemoPageState();
}

class _CountdownEventFinishedDemoPageState extends State<CountdownEventFinishedDemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.dotsTheme.colors.bgContainerSecondary,
      body: Center(
        child: CountdownEventFinished(
          variant: widget.variant,
          title: widget.title,
          icon: widget.icon,
          years: widget.years,
          months: widget.months,
          days: widget.days,
          yearsLabel: widget.yearsLabel,
          monthsLabel: widget.monthsLabel,
          daysLabel: widget.daysLabel,
          conjunctionText: 'and',
        ),
      ),
    );
  }
}
