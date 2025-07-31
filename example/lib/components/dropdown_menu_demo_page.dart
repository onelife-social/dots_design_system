import 'package:dots_design_system/dots_design_system.dart' as dc;
import 'package:flutter/material.dart';

class DropdownMenuDemoPage extends StatelessWidget {
  final List<dc.DropdownItem> items;

  const DropdownMenuDemoPage({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dc.DropdownMenu(
          items: items,
        ),
      ],
    );
  }
}
