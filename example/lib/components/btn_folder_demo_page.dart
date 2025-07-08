import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolderDemoPage extends StatelessWidget {
  final String text;
  final Color? iconColor;
  final DotsIcon icon;
  final bool isSelected;

  const BtnFolderDemoPage({
    super.key,
    required this.text,
    required this.iconColor,
    required this.icon,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BtnFolder(
          icon: icon.iconData,
          text: text,
          onPressed: () {},
          isSelected: isSelected,
          iconSelectedColor: iconColor ?? DotsColors.light.gradientInitialLinealPurple,
        ),
      ],
    );
  }
}
