import 'package:dots_design_system/dots_design_system.dart';
import 'package:dots_design_system/src/core/borders/gradient_box_border.dart';
import 'package:flutter/material.dart';

enum MemoryCardVariant {
  memory,
  recap;

  bool get isMemory => this == MemoryCardVariant.memory;
  bool get isRecap => this == MemoryCardVariant.recap;
}

class MemoryCard extends StatelessWidget {
  final Widget image;
  final String groupName;
  final MemoryCardVariant variant;
  final VoidCallback onTap;
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const MemoryCard({
    super.key,
    required this.image,
    required this.groupName,
    required this.variant,
    required this.onTap,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 68,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                variant == MemoryCardVariant.memory ? const _MemoryBorder() : const _RecapBorder(),
                _Card(image: image, onError: onError),
              ],
            ),
            const SizedBox(height: 8),
            _GroupName(groupName: groupName),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final Widget image;
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  const _Card({
    required this.image,
    required this.onError,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 80.0,
        width: 60.39,
        child: ClipRRect(
          borderRadius: DotsBorderRadius.r15,
          child: image,
        ),
      ),
    );
  }
}

class _GroupName extends StatelessWidget {
  final String groupName;
  const _GroupName({required this.groupName});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Text(
      groupName,
      style: theme.typo.main.labelDefaultMedium.copyWith(color: theme.colors.textSecondary),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.center,
    );
  }
}

class _MemoryBorder extends StatelessWidget {
  const _MemoryBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 67.53,
      height: 87.39,
      decoration: BoxDecoration(
        borderRadius: DotsBorderRadius.r18,
        border: GradientBoxBorder(
          width: 1.45,
          gradient: LinearGradient(
            colors: [
              DotsColors.light.gradientInitialLinealGreen,
              DotsColors.light.gradientFinalLinealGreen,
            ],
            stops: const [0.0, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
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

class _RecapBorder extends StatelessWidget {
  const _RecapBorder();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
