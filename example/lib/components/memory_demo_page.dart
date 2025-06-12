import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class MemoryDemoPage extends StatelessWidget {
  final DecorationImage image;

  const MemoryDemoPage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Memory(
          image: image.image,
          albumName: 'Boda',
          isGeneratedMemory: false,
          onTap: () {},
        ),
      ],
    );
  }
}
