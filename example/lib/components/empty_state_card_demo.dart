import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class EmptyStateCardDemo extends StatelessWidget {
  const EmptyStateCardDemo({
    super.key,
    required this.variant,
    this.imageProvider,
    this.icon,
    required this.title,
    required this.description,
    this.button,
  });

  final DotsEmptyStateCardVariant variant;
  final ImageProvider? imageProvider;
  final DotsIcon? icon;
  final String title;
  final String description;
  final DotsMainButton? button;

  @override
  Widget build(BuildContext context) {
    return DotsEmptyStateCard(
      variant: variant,
      imageProvider: imageProvider,
      icon: icon,
      title: title,
      description: description,
      button: button,
    );
  }
}
