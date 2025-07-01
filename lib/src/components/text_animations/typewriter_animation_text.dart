import 'package:flutter/material.dart';

class TypewriterAnimationText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;

  const TypewriterAnimationText({
    super.key,
    required this.text,
    required this.style,
    required this.duration,
  });

  @override
  State<TypewriterAnimationText> createState() => _TypewriterAnimationTextState();
}

class _TypewriterAnimationTextState extends State<TypewriterAnimationText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final int charCount = (_controller.value * widget.text.length).floor();
        return Text(
          widget.text.substring(0, charCount),
          style: widget.style,
        );
      },
    );
  }
}
