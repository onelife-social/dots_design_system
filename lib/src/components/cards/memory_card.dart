import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

enum MemoryCardVariant {
  update,
  dotsIntelligence;

  bool get isUpdate => this == MemoryCardVariant.update;
  bool get isDotsIntelligence => this == MemoryCardVariant.dotsIntelligence;
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
        height: 99.5,
        width: 66,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                _Card(image: image, onError: onError),
                variant == MemoryCardVariant.update
                    ? const _BorderPendingMemory()
                    : _BorderGeneratedMemory(),
              ],
            ),
            _GroupName(albumName: groupName),
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
        height: 77,
        width: 58,
        child: ClipRRect(
          borderRadius: DotsBorderRadius.r16,
          child: image,
        ),
      ),
    );
  }
}

class _GroupName extends StatelessWidget {
  final String albumName;
  const _GroupName({required this.albumName});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Text(
      albumName,
      style: theme.typo.main.labelSmallRegular
          .copyWith(fontWeight: FontWeight.w500, color: theme.colors.textTertiary),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      textAlign: TextAlign.center,
    );
  }
}

class _BorderPendingMemory extends StatelessWidget {
  const _BorderPendingMemory();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.53,
      height: 83.36,
      decoration: BoxDecoration(
        borderRadius: DotsBorderRadius.r16,
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
      child: Container(
        margin: const EdgeInsets.all(1.5),
        decoration: BoxDecoration(
          borderRadius: DotsBorderRadius.r14h,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _BorderGeneratedMemory extends StatelessWidget {
  const _BorderGeneratedMemory();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 77,
      width: 58,
      child: Image.asset(
        'assets/images/filter_generated_memory.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
