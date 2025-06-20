import 'dart:math';

import 'package:flutter/material.dart';

class Carrousel extends StatelessWidget {
  final List<Widget> memories;
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
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(memories.length, (index) {
              final double rotationAngle = rotationPattern[index % rotationPattern.length];

              return Padding(
                padding: EdgeInsets.only(right: index < memories.length - 1 ? 24 : 0),
                child: Transform.rotate(
                  angle: -rotationAngle * (pi / 180),
                  child: memories[index],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
