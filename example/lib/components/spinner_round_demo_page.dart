import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class SpinnerRoundDemoPage extends StatefulWidget {
  const SpinnerRoundDemoPage({super.key});

  @override
  State<SpinnerRoundDemoPage> createState() => _SpinnerRoundDemoPageState();
}

class _SpinnerRoundDemoPageState extends State<SpinnerRoundDemoPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.dotsTheme.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _demo(colors.bgContainerTertiary, SpinnerRoundTone.onPhoto),
        const SizedBox(height: 16),
        _demo(colors.bgBase, SpinnerRoundTone.accent),
      ],
    );
  }

  Widget _demo(Color background, SpinnerRoundTone tone) {
    return DotsMainContainer(
      height: 100,
      width: 175,
      backgroundColor: background,
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (_, __) => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SpinnerRound(
                progress: _controller.value,
                showPercentage: true,
                tone: tone,
              ),
              const SizedBox(width: 16),
              SpinnerRound(
                progress: _controller.value,
                size: 17,
                strokeWidth: 2.27,
                showPercentage: false,
                tone: tone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
