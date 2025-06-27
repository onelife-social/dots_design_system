import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class EmptyStateCardDemo extends StatelessWidget {
  const EmptyStateCardDemo({
    super.key,
    required this.imageProvider,
    required this.title,
    required this.description,
    this.button,
  });

  final ImageProvider imageProvider;
  final String title;
  final String description;
  final DotsMainButton? button;

  @override
  Widget build(BuildContext context) {
    return DotsEmptyStateCard(
      imageProvider: imageProvider,
      title: title,
      description: description,
      button: button,
    );
  }
}
