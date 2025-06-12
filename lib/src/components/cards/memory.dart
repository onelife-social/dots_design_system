import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class Memory extends StatelessWidget {
  final ImageProvider image;
  final String albumName;
  final bool isGeneratedMemory;
  final VoidCallback onTap;

  const Memory({
    super.key,
    required this.image,
    required this.albumName,
    required this.isGeneratedMemory,
    required this.onTap,
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
                _Card(image: image),
                !isGeneratedMemory ? const _BorderPendingMemory() : _BorderGeneratedMemory(),
              ],
            ),
            _NameAlbum(albumName: albumName),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final ImageProvider image;
  const _Card({required this.image});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 77,
        width: 58,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: image,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class _NameAlbum extends StatelessWidget {
  final String albumName;
  const _NameAlbum({required this.albumName});

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
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1.5,
          color: Colors.green,
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
