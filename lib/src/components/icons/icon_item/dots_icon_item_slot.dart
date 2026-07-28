import 'package:flutter/material.dart';

import '../dots_icon.dart';
import '../dots_icon_data_enum.dart';

class DotsIconItemSlot extends StatelessWidget {
  /// Type of the icon slot, which determines the glyph and gradient shown.
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
    final _SlotSpec spec = _specFor(type);

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.24),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: spec.colors,
        ),
      ),
      child: Center(
        child: DotsIcon(
          iconData: spec.glyph,
          color: Colors.white,
          size: width * 0.55,
        ),
      ),
    );
  }

  /// Each slot is a soft-rectangle with the type's brand gradient and glyph, so
  /// the family stays crisp at any size (no raster assets).
  _SlotSpec _specFor(DotsIconItemSlotType type) {
    switch (type) {
      case DotsIconItemSlotType.cover:
        return const _SlotSpec([Color(0xFFFAA25E), Color(0xFFF37C20)], DotsIconData.book2);
      case DotsIconItemSlotType.dedicatory:
        return const _SlotSpec([Color(0xFFFF5B69), Color(0xFFFF3F51)], DotsIconData.heart);
      case DotsIconItemSlotType.images:
        return const _SlotSpec([Color(0xFF61ED82), Color(0xFF32B74B)], DotsIconData.photoFrame);
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
