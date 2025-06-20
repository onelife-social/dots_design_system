import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SegmentedControlHandle extends StatefulWidget {
  const SegmentedControlHandle(
      {super.key, required this.leftOptionName, required this.rightOptionName});

  final String leftOptionName;
  final String rightOptionName;
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
