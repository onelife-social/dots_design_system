import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DotsIcon extends StatelessWidget {
  const DotsIcon({super.key, required this.iconData, this.color, this.size = 32});

  final DotsIconData iconData;
  final Color? color;

  final double size;

  @override
  Widget build(BuildContext context) {
    final color = this.color;

    return SvgPicture.asset(
      _getPathByDotsIcons(iconData),
      colorFilter: color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      height: size,
      width: size,
    );
  }
}

String _getPathByDotsIcons(DotsIconData icon) {
  final package = dotsDesignSystemPackage;
  final group = icon.iconGroup.folderName;
  final assetName = icon.asset;

  return 'packages/$package/assets/icons/$group/$assetName';
}
