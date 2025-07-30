import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DropdownItemDemoPage extends StatelessWidget {
  final String text;
  final DotsIconData? icon;
  final VoidCallback onTap;
  final Color? itemColor;

  const DropdownItemDemoPage({
    super.key,
    required this.text,
    this.icon,
    required this.onTap,
    this.itemColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DropdownItem(
          onTap: () {},
          text: text,
          icon: icon,
          itemColor: itemColor,
        ),
      ],
    );
  }
}
