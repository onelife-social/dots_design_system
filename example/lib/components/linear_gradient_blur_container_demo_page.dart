import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class LinearGradientBlurContainerDemoPage extends StatelessWidget {
  final String imageUrl;
  final double sigma;
  final LinearGradientBlur linearGradientBlur;
  final Color tintColor;

  const LinearGradientBlurContainerDemoPage({
    super.key,
    required this.imageUrl,
    this.sigma = 5.0,
    this.linearGradientBlur = const LinearGradientBlur(
      values: [0, 1],
      stops: [0.5, 0.8],
      start: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    this.tintColor = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        DotsLinearGradientBlur(
          sigma: sigma,
          linearGradientBlur: linearGradientBlur,
          tintColor: tintColor,
          child: Container(
            width: 300,
            height: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
        ),
      ],
    );
  }
}
