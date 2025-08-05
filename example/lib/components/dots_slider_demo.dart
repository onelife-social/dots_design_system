import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsSliderDemo extends StatefulWidget {
  const DotsSliderDemo({super.key, required this.divisions});
  final int divisions;

  @override
  State<DotsSliderDemo> createState() => _DotsSliderDemoState();
}

class _DotsSliderDemoState extends State<DotsSliderDemo> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DotsSlider(
        value: value.toDouble(),
        divisions: widget.divisions,
        max: widget.divisions.toDouble() + 1,
        onChanged: (newValue) {
          if (context.mounted) {
            setState(() {
              value = newValue.round();
            });
          }
        },
      ),
    );
  }
}
