import 'package:flutter/material.dart';

import '../../../core/core_lib.dart';
import '../dots_icon.dart';
import '../dots_icon_data_enum.dart';

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
    if (type == DotsIconItemSlotType.qr) {
      return _QrSlot(width: width, height: height);
    }

    return Image.asset(
      '${ImagesPaths.imagesIcons}/icon_${type.name}.webp',
      width: width,
      height: height,
    );
  }
}

/// The `qr` slot has no raster illustration in the asset set; it is composed
/// from the QR glyph over the brand blue gradient so it stays crisp at any size
/// and matches the rest of the icon family.
class _QrSlot extends StatelessWidget {
  final double width;
  final double height;

  const _QrSlot({required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF82C8E5), Color(0xFF4FAEF8)],
        ),
      ),
      child: Center(
        child: DotsIcon(
          iconData: DotsIconData.qr,
          color: Colors.white,
          size: width * 0.55,
        ),
      ),
    );
  }
}

enum DotsIconItemSlotType {
  cover,
  dedicatory,
  images,
  milestone,
  qr,
}
