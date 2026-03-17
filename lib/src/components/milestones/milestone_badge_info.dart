import 'dart:ui';

import 'package:dots_design_system/dots_design_system.dart';

class MilestoneBadgeInfo {
  final MilestoneBadgeType type;
  final VoidCallback? onTap;

  const MilestoneBadgeInfo({required this.type, this.onTap});
}