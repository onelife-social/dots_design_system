import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SegmentedControlHandle extends StatefulWidget {
  const SegmentedControlHandle({
    super.key,
    required this.leftOptionName,
    required this.rightOptionName,
    this.selectedColor,
    this.backgroundColor,
    this.rightOptionTag,
  });

  final String leftOptionName;
  final String rightOptionName;
  final Color? selectedColor;
  final Color? backgroundColor;
  final String? rightOptionTag;

  @override
  State<SegmentedControlHandle> createState() => _SegmentedControlHandleState();
}

class _SegmentedControlHandleState extends State<SegmentedControlHandle> {
  SegmentedControlOption selectedOption = SegmentedControlOption.left;

  @override
  Widget build(BuildContext context) {
    return SegmentedControl(
        leftOptionName: widget.leftOptionName,
        rightOptionName: widget.rightOptionName,
        selectedOption: selectedOption,
        selectedColor: widget.selectedColor,
        backgroundColor: widget.backgroundColor,
        rightOptionTag: widget.rightOptionTag,
        onTapOption: (option) {
          if (kDebugMode) {
            print('Selected option: $option');
          }
          setState(() {
            selectedOption = option;
          });
        });
  }
}
