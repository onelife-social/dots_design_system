import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

enum MilestoneBadgeType {
  video,
  description,
  audio;

  bool get isVideo => this == MilestoneBadgeType.video;
  bool get isAudio => this == MilestoneBadgeType.audio;
  bool get isDescription => this == MilestoneBadgeType.description;

  DotsIconData get icon => switch (this) {
    MilestoneBadgeType.video => DotsIconData.video,
    MilestoneBadgeType.audio => DotsIconData.mic,
    MilestoneBadgeType.description => DotsIconData.pages,
  };

  Color color(DotsTheme theme) => switch (this) {
    MilestoneBadgeType.video => theme.colors.child010,
    MilestoneBadgeType.audio => theme.colors.couple001,
    MilestoneBadgeType.description => theme.colors.friends005,
  };
}