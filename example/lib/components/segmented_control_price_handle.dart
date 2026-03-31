import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SegmentedControlPriceHandle extends StatefulWidget {
  const SegmentedControlPriceHandle({
    super.key,
    this.variant = SegmentedControlPriceVariant.dual,
    required this.leftOptionName,
    required this.leftOptionPrice,
    this.rightOptionName,
    this.rightOptionPrice,
    this.leftOptionTag,
    this.rightOptionTag,
    this.leftOptionDescription,
    this.rightOptionDescription,
    this.leftOptionPriceTrailing,
    this.rightOptionPriceTrailing,
    this.selectedColor,
    this.backgroundColor,
  });

  final SegmentedControlPriceVariant variant;
  final String leftOptionName;
  final String leftOptionPrice;
  final String? leftOptionTag;
  final String? leftOptionDescription;
  final String? leftOptionPriceTrailing;
  final String? rightOptionName;
  final String? rightOptionPrice;
  final String? rightOptionTag;
  final String? rightOptionDescription;
  final String? rightOptionPriceTrailing;
  final Color? selectedColor;
  final Color? backgroundColor;

  @override
  State<SegmentedControlPriceHandle> createState() => _SegmentedControlPriceHandleState();
}

class _SegmentedControlPriceHandleState extends State<SegmentedControlPriceHandle> {
  SegmentedControlOption selectedOption = SegmentedControlOption.left;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 85,
      width: 326,
      child: SegmentedControlPrice(
          variant: widget.variant,
          leftOptionName: widget.leftOptionName,
          leftOptionPrice: widget.leftOptionPrice,
          leftOptionTag: widget.leftOptionTag,
          leftOptionDescription: widget.leftOptionDescription,
          leftOptionPriceTrailing: widget.leftOptionPriceTrailing,
          rightOptionName: widget.rightOptionName,
          rightOptionPrice: widget.rightOptionPrice,
          rightOptionTag: widget.rightOptionTag,
          rightOptionDescription: widget.rightOptionDescription,
          rightOptionPriceTrailing: widget.rightOptionPriceTrailing,
          selectedOption: selectedOption,
          backgroundColor: widget.backgroundColor,
          onTapOption: (option) {
            if (kDebugMode) {
              print('Selected option: $option');
            }
            setState(() {
              selectedOption = option;
            });
          }),
    );
  }
}
