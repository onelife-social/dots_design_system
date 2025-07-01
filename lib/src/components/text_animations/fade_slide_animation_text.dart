import 'package:flutter/material.dart';

class FadeSlideAnimationText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration duration;
  final double slideOffset;
  final Curve curve;

  const FadeSlideAnimationText({
    super.key,
    required this.text,
    required this.style,
    required this.duration,
    this.slideOffset = 0.2,
    this.curve = Curves.easeOut,
  });

  @override
  State<FadeSlideAnimationText> createState() => _FadeSlideAnimationTextState();
}

class _FadeSlideAnimationTextState extends State<FadeSlideAnimationText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: widget.curve);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(0, widget.slideOffset),
        end: Offset.zero,
      ).animate(_animation),
      child: FadeTransition(
        opacity: _animation,
        child: Text(widget.text, style: widget.style),
      ),
    );
  }
}
