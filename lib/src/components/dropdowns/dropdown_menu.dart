import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DropdownMenu extends StatelessWidget {
  //Dropdown menu items.
  final List<DropdownItem> items;

  // Menu Width. If null, fallback to 250.
  final double? width;

  // Max menu height. If null, menu grows with content.
  final double? maxHeight;

  const DropdownMenu({
    super.key,
    required this.items,
    this.width,
    this.maxHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: context.dotsTheme.colors.bgBaseContrast,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: maxHeight ?? double.infinity,
        ),
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(8),
          itemCount: items.length,
          itemBuilder: (context, index) => items[index],
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}
