import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/cupertino.dart';

class DotsToggle extends StatelessWidget {
  /// Whether the toggle is selected.
  ///
  /// Defaults to `false`.
  final bool isSelected;

  const DotsToggle({
    super.key,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      value: isSelected,
      onChanged: (_) {},
      activeTrackColor: context.dotsTheme.colors.labelHighlight,
      thumbColor: context.dotsTheme.colors.labelAlwaysWhite,
    );
  }
}
