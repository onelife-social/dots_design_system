import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class MemoryHeaderDemoPage extends StatelessWidget {
  final List<Memory> memories;

  const MemoryHeaderDemoPage({super.key, required this.memories});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MemoryHeader(
          titleText: 'Hola Carlos,',
          subtitleText: 'Tienes 6 álbumes con nuevos memories',
          memories: memories,
        ),
      ],
    );
  }
}
