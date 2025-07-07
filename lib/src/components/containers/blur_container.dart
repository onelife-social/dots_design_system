import 'dart:ui' as ui;

import 'package:dots_design_system/src/core/core_lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class BlurContainer extends StatefulWidget {
  final double sigma;
  final Widget child;

  const BlurContainer({required this.sigma, required this.child, super.key})
      : assert(
          sigma >= 0 && sigma <= 5.0,
          'Sigma must be between 0 and 5',
        );

  @override
  State<BlurContainer> createState() => _BlurContainerState();
}

class _BlurContainerState extends State<BlurContainer> {
  ui.Image? _backgroundImage;
  late ui.FragmentProgram _program;
  final GlobalKey repaintBoundaryKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _program = ShadersLoader.getShader(ShaderType.blur);
    WidgetsBinding.instance.addPostFrameCallback((_) => _capture());
  }

  Future<void> _capture() async {
    final boundary =
        repaintBoundaryKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary != null) {
      final image = await boundary.toImage(pixelRatio: MediaQuery.of(context).devicePixelRatio);
      setState(() {
        _backgroundImage = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: repaintBoundaryKey,
      child: CustomPaint(
        painter: BlurPainter(
          image: _backgroundImage,
          program: _program,
          sigma: widget.sigma,
        ),
        child: widget.child,
      ),
    );
  }
}
