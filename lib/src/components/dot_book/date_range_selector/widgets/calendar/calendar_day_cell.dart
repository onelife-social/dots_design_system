import 'package:flutter/material.dart';

class DotbookCalendarDayCell extends StatelessWidget {

  final String text;
  final TextStyle textStyle;
  final BoxDecoration? decoration;
  final EdgeInsetsGeometry backgroundMargin;
  const DotbookCalendarDayCell({
    super.key,
    required this.text,
    required this.textStyle,
    this.decoration,
    this.backgroundMargin = const EdgeInsets.symmetric(vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: decoration,
            child: Text(text, style: textStyle),
          ),
        ],
      ),
    );
  }
}
