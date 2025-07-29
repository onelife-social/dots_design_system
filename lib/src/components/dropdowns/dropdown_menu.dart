import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DropdownMenu extends StatelessWidget {
  //Dropdown menu items.
  final List<DropdownItem> items;

  const DropdownMenu({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24), color: context.dotsTheme.colors.bgBaseContrast),
      child: Column(
        children: items,
      ),
    );
  }
}
