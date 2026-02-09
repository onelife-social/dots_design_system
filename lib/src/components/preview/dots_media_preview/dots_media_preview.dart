import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/core/borders/gradient_box_border.dart';
import 'package:flutter/material.dart';

enum DotsMediaPreviewVariant {
  active,
  viewed;

  bool get isActive => this == DotsMediaPreviewVariant.active;
  bool get isViewed => this == DotsMediaPreviewVariant.viewed;
}

class DotsMediaPreview extends StatelessWidget {
  final Widget image;
  final String label;
  final DotsMediaPreviewVariant variant;
  final VoidCallback onTap;
  final double width;
  final double boxWidth;

  const DotsMediaPreview({
    super.key,
    required this.image,
    required this.label,
    required this.variant,
    required this.onTap,
    this.width = 68,
    this.boxWidth = 100,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: boxWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _MemoryCardBorder(variant: variant, width: width),
                _Card(image: image, width: width),
              ],
            ),
            const SizedBox(height: 8),
            _Label(label: label),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget image;
  final double width;

  const _Card({
    required this.image,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: width - 8,
        width: width - 8,
        child: ClipOval(
          child: image,
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;
  const _Label({required this.label});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Text(
      label,
      style: theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.textSecondary),
      textAlign: TextAlign.center,
    );
  }
}

class _MemoryCardBorder extends StatelessWidget {
  final DotsMediaPreviewVariant variant;
  final double width;

  const _MemoryCardBorder({required this.variant, required this.width});

  @override
  Widget build(BuildContext context) {
    Gradient gradient;
    final theme = context.dotsTheme;

    if (variant.isActive) {
      gradient = LinearGradient(
        colors: [
          DotsColors.light.gradientInitialLinealGreen,
          DotsColors.light.gradientFinalLinealGreen,
        ],
        stops: const [0.0, 1.0],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );
    } else {
      gradient = LinearGradient(
        colors: [
          theme.colors.labelSecondary,
          theme.colors.labelSecondary,
        ],
      );
    }
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: GradientBoxBorder(
          width: 1.45,
          gradient: gradient,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: DotsBorderRadius.r18,
        ),
      ),
    );
  }
}
