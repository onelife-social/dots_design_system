import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
class DotsColorSelectorRow extends StatelessWidget {
  /// Colors to display
  final List<Color> colors;

  /// Size of each color circle
  final double size;

  /// Spacing between color circles
  final double spacing;

  /// Currently selected color
  final Color? selectedColor;

  /// Callback when a color is selected
  final ValueChanged<Color>? onColorSelected;

  const DotsColorSelectorRow({
    super.key,
    required this.colors,
    this.size = 32,
    this.spacing = 12,
    this.selectedColor,
    this.onColorSelected,
  });

  Widget _colorItem(BuildContext context, Color color, bool isSelected) {
    final theme = context.dotsTheme;
    final outterBorderColor = isSelected
        ? theme.colors.labelHighlight
        : Colors.transparent;
    final innerBorderColor = isSelected
        ? Colors.black.dotsWithOpacity(0.25)
        : Colors.transparent;

    return SizedBox(
      width: size,
      height: size,
      child: Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: outterBorderColor, width: 1.5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2.5),
            child: ClipOval(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: color),
                  Image(
                    image: AssetImage(ImagesPaths.colorSelectorShadow),
                    fit: BoxFit.cover,
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: ShapeDecoration(
                        shape: CircleBorder(
                          side: BorderSide(
                            color: innerBorderColor,
                            width: 1.5,
                            strokeAlign: BorderSide.strokeAlignInside,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (int i = 0; i < colors.length; i++) ...[
            if (i == 0) SizedBox(width: 16),
            GestureDetector(
              onTap: onColorSelected != null
                  ? () => onColorSelected!(colors[i])
                  : null,
              child: _colorItem(context, colors[i], selectedColor == colors[i]),
            ),
            if (i != colors.length - 1) SizedBox(width: spacing),
            if (i == colors.length - 1) SizedBox(width: 16),
          ],
        ],
      ),
    );
  }
}
