import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class BlurContainerDemoPage extends StatelessWidget {
  final String text;
  final String imageUrl;
  final double sigma;

  const BlurContainerDemoPage({
    super.key,
    required this.text,
    required this.imageUrl,
    this.sigma = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        BlurContainer(
          sigma: 5.0,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text,
                style: context.dotsTheme.typo.main.bodyDefaultBold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
