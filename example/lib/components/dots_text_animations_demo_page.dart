import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextAnimationsDemoPage extends StatelessWidget {
  final String text;
  final TextStyle style;

  const DotsTextAnimationsDemoPage({
    super.key,
    required this.text,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Typewriter Animation'),
        TypewriterAnimationText(
          text: text,
          style: style,
          duration: Duration(seconds: 1),
        ),
        SizedBox(height: 20),
        Text('Fade Slide In Animation'),
        FadeSlideAnimationText(
          text: text,
          style: style,
          duration: Duration(milliseconds: 800),
        ),
      ],
    );
  }
}
