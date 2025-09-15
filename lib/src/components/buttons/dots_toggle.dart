import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

class DotsToggle extends StatelessWidget {
  /// Whether the toggle is selected.
  ///
  /// Defaults to `false`.
  final bool isSelected;

  /// Function to execute when the toggle is tapped
  final Function(bool) onChanged;

  const DotsToggle({
    super.key,
    this.isSelected = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final double width = 44.42;
    final double height = 27;
    const double knobPadding = 1.74;
    final double knobSize = height - (knobPadding * 2);

    const List<BoxShadow> knobShadows = [
      BoxShadow(
        color: Color(0x0F000000),
        blurRadius: 0.87,
        offset: Offset(0, 2.61),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x26000000),
        blurRadius: 6.97,
        offset: Offset(0, 2.61),
        spreadRadius: 0,
      ),
      BoxShadow(
        color: Color(0x0A000000),
        blurRadius: 0,
        offset: Offset(0, 0),
        spreadRadius: 0.87,
      ),
    ];

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => onChanged(!isSelected),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: width,
          minHeight: 44,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: width,
            height: height,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeInOut,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: isSelected ? theme.colors.labelHighlight : theme.colors.fillSecondary,
                borderRadius: BorderRadius.circular(height / 2),
              ),
              padding: const EdgeInsets.all(knobPadding),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeInOut,
                alignment: isSelected ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: knobSize,
                  height: knobSize,
                  decoration: BoxDecoration(
                    color: theme.colors.labelAlwaysWhite,
                    shape: BoxShape.circle,
                    boxShadow: knobShadows,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
