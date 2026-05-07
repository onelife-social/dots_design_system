import 'package:flutter/material.dart';

import '../../../core/core_lib.dart';

class DotsIconItemSlot extends StatelessWidget {
  /// Type of the icon slot, which determines the image to be displayed.
  final DotsIconItemSlotType type;

  /// Width of the icon slot. Default is 44.
  final double width;

  /// Height of the icon slot. Default is 44.
  final double height;

  const DotsIconItemSlot({
    required this.type,
    this.width = 44,
    this.height = 44,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      '${ImagesPaths.imagesIcons}/icon_${type.name}.webp',
      width: width,
      height: height,
    );
  }
}

enum DotsIconItemSlotType {
  cover,
  dedicatory,
  images,
  milestone,
}
