import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum DotsColorOption {
  textQuarternary,
  couple007,
  friends001,
  friends002,
  friends005,
  friends008,
  friends010,
  class005,
  class009,
  wedding002,
  family001,
  family004,
  family006,
  child001,
  child002,
  child006,
  birthday003,
  birthday007,
  celebration002,
  hobby001,
  hobby002,
  hobby004,
  hobby005,
  hobby009,
  couple005,
  work005;
}

extension DotsColorOptionExtension on DotsColorOption {
  Color getColor(BuildContext context) {
    final theme = context.dotsTheme;
    switch (this) {
      case DotsColorOption.textQuarternary:
        return theme.colors.textQuarternary;
      case DotsColorOption.couple007:
        return theme.colors.couple007;
      case DotsColorOption.friends001:
        return theme.colors.friends001;
      case DotsColorOption.friends002:
        return theme.colors.friends002;
      case DotsColorOption.friends005:
        return theme.colors.friends005;
      case DotsColorOption.friends008:
        return theme.colors.friends008;
      case DotsColorOption.friends010:
        return theme.colors.friends010;
      case DotsColorOption.class005:
        return theme.colors.class005;
      case DotsColorOption.class009:
        return theme.colors.class009;
      case DotsColorOption.wedding002:
        return theme.colors.wedding002;
      case DotsColorOption.family001:
        return theme.colors.family001;
      case DotsColorOption.family004:
        return theme.colors.family004;
      case DotsColorOption.family006:
        return theme.colors.family006;
      case DotsColorOption.child001:
        return theme.colors.child001;
      case DotsColorOption.child002:
        return theme.colors.child002;
      case DotsColorOption.child006:
        return theme.colors.child006;
      case DotsColorOption.birthday003:
        return theme.colors.birthday003;
      case DotsColorOption.birthday007:
        return theme.colors.birthday007;
      case DotsColorOption.celebration002:
        return theme.colors.celebration002;
      case DotsColorOption.hobby001:
        return theme.colors.hobby001;
      case DotsColorOption.hobby002:
        return theme.colors.hobby002;
      case DotsColorOption.hobby004:
        return theme.colors.hobby004;
      case DotsColorOption.hobby005:
        return theme.colors.hobby005;
      case DotsColorOption.hobby009:
        return theme.colors.hobby009;
      case DotsColorOption.couple005:
        return theme.colors.couple005;
      case DotsColorOption.work005:
        return theme.colors.work005;
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
                              ? Colors.black.dotsWithOpacity(0.25)
                              : Colors.black.dotsWithOpacity(0.10),
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
            if (i != colorOptions.length - 1) SizedBox(width: spacing),
            if (i == colorOptions.length - 1) SizedBox(width: 16),
          ],
        ],
      ),
    );
  }
}
