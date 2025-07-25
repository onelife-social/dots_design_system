import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsColorOption {
  grey,
  red,
  lightRed,
  orange,
  lightOrange,
  yellow,
  yellowLight,
  darkGreen,
  lightGreen,
  darkBlue,
  navy,
  darkPurple,
  purple,
  lightPurple,
  rose,
}

extension DotsColorOptionExtension on DotsColorOption {
  Color getColor(BuildContext context) {
    final theme = context.dotsTheme;
    switch (this) {
      case DotsColorOption.grey:
        return theme.colors.textQuarternary;
      case DotsColorOption.red:
        return const Color(0xFFE55451);
      case DotsColorOption.lightRed:
        return const Color(0xFFEE7668);
      case DotsColorOption.orange:
        return const Color(0xFFF37C20);
      case DotsColorOption.lightOrange:
        return const Color(0xFFF7954A);
      case DotsColorOption.yellow:
        return const Color(0xFFF4BC24);
      case DotsColorOption.yellowLight:
        return const Color(0xFFE2C567);
      case DotsColorOption.darkGreen:
        return const Color(0xFF8E9778);
      case DotsColorOption.lightGreen:
        return const Color(0xFF9BC283);
      case DotsColorOption.darkBlue:
        return const Color(0xFF3D99CB);
      case DotsColorOption.navy:
        return const Color(0xFF6898F7);
      case DotsColorOption.darkPurple:
        return const Color(0xFF6C7FCC);
      case DotsColorOption.purple:
        return const Color(0xFFB175B1);
      case DotsColorOption.lightPurple:
        return const Color(0xFFC998C5);
      case DotsColorOption.rose:
        return const Color(0xFFB66678);
    }
  }
}

class DotsColorOptionsRow extends StatelessWidget {
  
  /// Size of each color circle
  final double size;

  /// Spacing between color circles
  final double spacing;

  /// Currently selected color
  final DotsColorOption? selectedColor;

  /// Callback when a color is selected
  final ValueChanged<DotsColorOption> onColorSelected;

  const DotsColorOptionsRow({
    super.key,
    this.size = 32,
    this.spacing = 18,
    this.selectedColor,
    required this.onColorSelected,
  });

  static const List<DotsColorOption> colorOptions = [
    DotsColorOption.grey,
    DotsColorOption.red,
    DotsColorOption.lightRed,
    DotsColorOption.orange,
    DotsColorOption.lightOrange,
    DotsColorOption.yellow,
    DotsColorOption.yellowLight,
    DotsColorOption.darkGreen,
    DotsColorOption.lightGreen,
    DotsColorOption.darkBlue,
    DotsColorOption.navy,
    DotsColorOption.darkPurple,
    DotsColorOption.purple,
    DotsColorOption.lightPurple,
    DotsColorOption.rose,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < colorOptions.length; i++) ...[
            if (i == 0) SizedBox(width: 16), 
            GestureDetector(
              onTap: () => onColorSelected(colorOptions[i]),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: size,
                    height: size,
                    decoration: ShapeDecoration(
                      color: colorOptions[i].getColor(context),
                      shape: OvalBorder(
                        side: BorderSide(
                          width: selectedColor == colorOptions[i] ? 2 : 1.5,
                          color: selectedColor == colorOptions[i]
                              ? Colors.black.withOpacity(0.25)
                              : Colors.black.withOpacity(0.10),
                        ),
                      ),
                    ),
                  ),
                  if (selectedColor == colorOptions[i])
                    DotsIcon(
                      iconData: DotsIconData.checkThick,
                      color: theme.colors.labelAlwaysWhite,
                      size: size * 0.5,
                    ),
                ],
              ),
            ),
            if (i != colorOptions.length - 1)
              SizedBox(width: spacing),
          ],
        ],
      ),
    );
  }
}