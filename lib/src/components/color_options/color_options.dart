import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsColorOption {
  textQuarternary,
  couple007,
  friends002,
  friends010,
  friends005,
  class005,
  wedding002,
  family006,
  family004,
  child006,
  child002,
  celebration002,
  hobby009,
  hobby004,
  couple005;
}

extension DotsColorOptionExtension on DotsColorOption {
  Color getColor(BuildContext context) {
    final theme = context.dotsTheme;
    switch (this) {
      case DotsColorOption.textQuarternary:
        return theme.colors.textQuarternary;
      case DotsColorOption.couple007:
        return theme.colors.couple007;
      case DotsColorOption.friends002:
        return theme.colors.friends002;
      case DotsColorOption.friends010:
        return theme.colors.friends010;
      case DotsColorOption.friends005:
        return theme.colors.friends005;
      case DotsColorOption.class005:
        return theme.colors.class005;
      case DotsColorOption.wedding002:
        return theme.colors.wedding002;
      case DotsColorOption.family006:
        return theme.colors.family006;
      case DotsColorOption.family004:
        return theme.colors.family004;
      case DotsColorOption.child006:
        return theme.colors.child006;
      case DotsColorOption.child002:
        return theme.colors.child002;
      case DotsColorOption.celebration002:
        return theme.colors.celebration002;
      case DotsColorOption.hobby009:
        return theme.colors.hobby009;
      case DotsColorOption.hobby004:
        return theme.colors.hobby004;
      case DotsColorOption.couple005:
        return theme.colors.couple005;
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
    DotsColorOption.textQuarternary,
    DotsColorOption.couple007,
    DotsColorOption.friends002,
    DotsColorOption.friends010,
    DotsColorOption.friends005,
    DotsColorOption.class005,
    DotsColorOption.wedding002,
    DotsColorOption.family006,
    DotsColorOption.family004,
    DotsColorOption.child006,
    DotsColorOption.child002,
    DotsColorOption.celebration002,
    DotsColorOption.hobby009,
    DotsColorOption.hobby004,
    DotsColorOption.couple005,
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