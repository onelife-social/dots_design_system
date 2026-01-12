import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class EmptyStateCardDemo extends StatelessWidget {
  const EmptyStateCardDemo({
    super.key,
    required this.variant,
    this.imageProvider,
    this.icon,
    required this.title,
    this.titleColor,
    required this.description,
    this.descriptionColor,
    this.button,
    this.extraSpaceAfterImage = 0,
  });

  final DotsEmptyStateCardVariant variant;
  final ImageProvider? imageProvider;
  final DotsIcon? icon;
  final String title;
  final Color? titleColor;
  final String description;
  final Color? descriptionColor;
  final DotsMainButton? button;
  final double extraSpaceAfterImage;

  @override
  Widget build(BuildContext context) {
    return DotsEmptyStateCard(
      variant: variant,
      imageProvider: imageProvider,
      icon: icon,
      title: title,
      titleColor: titleColor,
      description: description,
      descriptionColor: descriptionColor,
      button: button,
      extraSpaceAfterImage: extraSpaceAfterImage,
    );
  }
}
