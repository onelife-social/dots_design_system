import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsIconButtonRightDemoPage extends StatelessWidget {
  final DotsIconButtonRightVariant variant;
  final DotsIconData icon;
  final String label;

  const DotsIconButtonRightDemoPage({
    super.key,
    required this.variant,
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotsIconButtonRight(
          variant: variant,
          label: label,
          icon: icon,
          padding: 20,
          onTap: () =>
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('On tap!'))),
        ),
      ],
    );
  }
}
