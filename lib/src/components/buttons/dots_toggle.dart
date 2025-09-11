import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';

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
    return CupertinoSwitch(
      value: isSelected,
      onChanged: onChanged,
      activeTrackColor: context.dotsTheme.colors.labelHighlight,
      thumbColor: context.dotsTheme.colors.labelAlwaysWhite,
    );
  }
}
