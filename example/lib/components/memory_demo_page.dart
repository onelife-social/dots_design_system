import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class MemoryCardDemoPage extends StatelessWidget {
  final DecorationImage image;

  const MemoryCardDemoPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MemoryCard(
          image: image.image,
          groupName: 'Boda',
          isGeneratedMemory: false,
          onTap: () {},
          onError: null,
        ),
      ],
    );
  }
}
