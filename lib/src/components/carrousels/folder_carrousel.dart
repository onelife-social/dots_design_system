import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FolderCarrousel extends StatelessWidget {
  final List<BtnFolder> buttons;

  const FolderCarrousel({super.key, required this.buttons});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (int i = 0; i < buttons.length; i++) ...[
              buttons[i],
              if (i != buttons.length - 1) const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }
}
