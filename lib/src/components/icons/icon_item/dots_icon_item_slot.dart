import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

import '../dots_icon.dart';
import '../dots_icon_data_enum.dart';

class DotsIconItemSlot extends StatelessWidget {
  /// Type of the icon slot, which determines the glyph and gradient shown.
  final DotsIconItemSlotType type;

  /// Width of the icon slot. Default is 32.
  final double width;

  /// Height of the icon slot. Default is 32.
  final double height;

  const DotsIconItemSlot({
    required this.type,
    this.width = 32,
    this.height = 32,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _SlotSpec spec = _specFor(type);
    // Derive the corner radius and glyph size from the smaller side so a
    // non-square slot never overflows its shorter dimension.
    final double side = width < height ? width : height;

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(side * 0.25),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: spec.colors,
        ),
      ),
      child: Center(
        child: DotsIcon(
          iconData: spec.glyph,
          color: Colors.white.dotsWithOpacity(0.8),
          size: side * 0.76,
        ),
      ),
    );
  }

  /// Each slot is a soft-rectangle with the type's brand gradient and glyph, so
  /// the family stays crisp at any size (no raster assets).
  _SlotSpec _specFor(DotsIconItemSlotType type) {
    switch (type) {
      case DotsIconItemSlotType.cover:
        return const _SlotSpec([Color(0xFFFAA25E), Color(0xFFF37C20)], DotsIconData.album);
      case DotsIconItemSlotType.dedicatory:
        return const _SlotSpec([Color(0xFFFF5B69), Color(0xFFFF3F51)], DotsIconData.dedicatory);
      case DotsIconItemSlotType.images:
        return const _SlotSpec([Color(0xFF61ED82), Color(0xFF32B74B)], DotsIconData.pics);
      case DotsIconItemSlotType.milestone:
        return const _SlotSpec([Color(0xFFFFCD66), Color(0xFFFF9E11)], DotsIconData.star);
      case DotsIconItemSlotType.qr:
        return const _SlotSpec([Color(0xFF82C8E5), Color(0xFF4FAEF8)], DotsIconData.qr);
    }
  }
}

class _SlotSpec {
  final List<Color> colors;
  final DotsIconData glyph;

  const _SlotSpec(this.colors, this.glyph);
}

enum DotsIconItemSlotType {
  cover,
  dedicatory,
  images,
  milestone,
  qr,
}
