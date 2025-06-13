import 'dart:math';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class Carrousel extends StatelessWidget {
  final List<MemoryCard> memories;
  const Carrousel({super.key, required this.memories});

  static const List<double> rotationPattern = [
    2.1,
    -2.1,
    0,
    -1.5,
    1.3,
    -0.8,
    0,
    2.1,
    -1.8,
    0,
    -2.1,
    1.6,
    -0.4,
    1.9,
    -1.1,
    0,
    2.1,
    -2.0,
    0.7,
    0
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 99.5,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        itemCount: memories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 24),
        itemBuilder: (_, index) {
          final double rotationAngle = rotationPattern[index % rotationPattern.length];

          return Transform.rotate(
            angle: rotationAngle * (pi / 180),
            child: memories[index],
          );
        },
      ),
    );
  }
}
