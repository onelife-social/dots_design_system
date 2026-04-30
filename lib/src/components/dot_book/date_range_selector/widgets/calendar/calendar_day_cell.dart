import 'package:flutter/material.dart';

class DotbookCalendarDayCell extends StatelessWidget {
  const DotbookCalendarDayCell({
    super.key,
    required this.text,
    required this.textStyle,
    this.decoration,
  });

  final String text;
  final TextStyle textStyle;
  final BoxDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 32,
        height: 32,
        alignment: Alignment.center,
        decoration: decoration,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
