import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BtnFolderDemoPage extends StatelessWidget {
  const BtnFolderDemoPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Unselected button'),
        const SizedBox(height: 10),
        BtnFolder(
          icon: DotsIconData.heart,
          text: 'Birthdays',
          onPressed: () {},
          isSelected: false,
          iconSelectedColor: DotsColors.light.gradientInitialLinealPurple,
        ),
        const SizedBox(height: 50),
        Text('Selected button'),
        const SizedBox(height: 10),
        BtnFolder(
          icon: DotsIconData.heart,
          text: 'Birthdays',
          onPressed: () {},
          isSelected: true,
          iconSelectedColor: DotsColors.light.gradientInitialLinealPurple,
        ),
      ],
    );
  }
}
