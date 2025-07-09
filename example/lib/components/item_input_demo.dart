import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class ItemInputDemo extends StatelessWidget {
  const ItemInputDemo(
      {super.key,
      required this.count,
      required this.label,
      required this.value,
      required this.iconData});

  final int count;
  final String label;
  final String value;

  final DotsIconData iconData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < count; i++)
          DotsItemInput(
              label: label,
              value: value,
              icon: iconData,
              position: count == 1
                  ? DotsItemInputPosition.onlyOne
                  : i == 0
                      ? DotsItemInputPosition.first
                      : i == count - 1
                          ? DotsItemInputPosition.last
                          : DotsItemInputPosition.middle)
      ],
    );
  }
}
