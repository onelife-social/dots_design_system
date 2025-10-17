import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DropdownMenu extends StatelessWidget {
  //Dropdown menu items.
  final List<DropdownItem> items;

  // Menu Width. If null, fallback to 250.
  final double? width;

  const DropdownMenu({
    super.key,
    required this.items,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.dotsTheme.colors.bgBaseContrast,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items,
      ),
    );
  }
}
