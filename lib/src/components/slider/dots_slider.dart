import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSlider extends StatelessWidget {
  const DotsSlider(
      {super.key,
      required this.value,
      required this.divisions,
      this.max = 1.0,
      this.onChanged,
      this.leftIcon = DotsIconData.user,
      this.rightIcon = DotsIconData.group});

  final DotsIconData leftIcon;
  final DotsIconData rightIcon;
  final double value;
  final int? divisions;

  final double max;

  final ValueChanged<double>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Row(
      spacing: 0,
      children: [
        DotsIcon(
          iconData: leftIcon,
          size: 20,
          color: theme.colors.labelSecondary,
        ),
        Expanded(
          child: SliderTheme(
            data: SliderThemeData(
                trackHeight: 9,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 14),
                trackShape: RoundedRectSliderTrackShape(),
                activeTrackColor: theme.colors.labelHighlight,
                inactiveTrackColor: theme.colors.bgContainerSecondary,
                thumbColor: theme.colors.bgBaseContrast,
                activeTickMarkColor: theme.colors.labelSecondary,
                inactiveTickMarkColor: theme.colors.labelSecondary,
                overlayColor: Colors.transparent,
                overlayShape: RoundSliderThumbShape(
                    enabledThumbRadius: 0, elevation: 1, pressedElevation: 1)),
            child: Slider(
              value: value,
              divisions: divisions,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ),
        DotsIcon(
          iconData: rightIcon,
          size: 20,
          color: theme.colors.labelSecondary,
        ),
      ],
    );
  }
}
