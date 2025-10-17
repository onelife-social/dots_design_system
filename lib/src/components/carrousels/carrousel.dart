import 'package:flutter/material.dart';

class Carrousel extends StatelessWidget {
  final List<Widget> memories;
  const Carrousel({super.key, required this.memories});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(memories.length, (index) {
                return Padding(
                  padding: EdgeInsets.only(right: index < memories.length - 1 ? 24 : 0),
                  child: memories[index],
                );
              }),
            ),
          ),
        ),
      ]
    );
  }
}
