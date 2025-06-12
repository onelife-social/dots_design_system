import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class CarrouselDemoPage extends StatelessWidget {
  final List<Memory> memories;

  const CarrouselDemoPage({super.key, required this.memories});

  @override
  Widget build(BuildContext context) {
    return Carrousel(memories: memories);
  }
}
