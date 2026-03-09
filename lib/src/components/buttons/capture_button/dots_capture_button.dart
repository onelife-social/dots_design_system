import 'dart:async';
import 'dart:math' as math;

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Diameter of the capture button in logical pixels.
const double _kCaptureButtonDiameter = 80.0;

/// Inner circle diameter in video mode (active state).
const double _kCaptureButtonInnerDiameter = 68.0;

/// Inner circle diameter only when mode is photo and state is recording (both at once).
const double _kCaptureButtonInnerDiameterRecording = 60.0;

/// Stroke width of the ring in logical pixels.
const double _kCaptureButtonRingStroke = 6.0;

class DotsCaptureButton extends StatefulWidget {
  /// The type of capture button to display (photo or video).
  final DotsCaptureButtonType type;

  /// The state of the capture button (active or recording).
  final DotsCaptureButtonState state;

  /// The maximum time of recording in seconds (used for progress when recording).
  final int maxTimeRecording;

  /// Called when the user triggers take picture (photo mode only).
  final VoidCallback? onTakePicture;

  /// Called when the user triggers start recording (video mode only).
  final VoidCallback? onStartRecording;

  /// Called when the user triggers stop recording, or when max time is reached.
  final VoidCallback? onStopRecording;

  const DotsCaptureButton({
    super.key,
    required this.type,
    required this.state,
    required this.maxTimeRecording,
    this.onTakePicture,
    this.onStartRecording,
    this.onStopRecording,
  });

  @override
  State<DotsCaptureButton> createState() => _DotsCaptureButtonState();
}

class _DotsCaptureButtonState extends State<DotsCaptureButton> {
  Timer? timerCircularProgress;
  double recordingProgress = 0.0;

  double get _innerDiameter => (widget.type.isPhoto && widget.state.isRecording)
      ? _kCaptureButtonInnerDiameterRecording
      : _kCaptureButtonInnerDiameter;

  void stopAnimations() {
    setState(() {
      timerCircularProgress?.cancel();
      recordingProgress = 0;
    });
  }

  void startAnimations() {
    setState(() {
      timerCircularProgress?.cancel();
      recordingProgress = 0.0;
      timerCircularProgress = Timer.periodic(
        const Duration(milliseconds: 10),
        (Timer timer) {
          if (!mounted) return;
          setState(() {
            recordingProgress += 0.01 / widget.maxTimeRecording;
            if (recordingProgress >= 1.0) {
              stopAnimations();
              widget.onStopRecording?.call();
            }
          });
        },
      );
    });
  }

  @override
  void didUpdateWidget(covariant DotsCaptureButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.type != widget.type ||
        oldWidget.state.isRecording && !widget.state.isRecording) {
      stopAnimations();
    }
  }

  void _onTapDown() {
    if (widget.type.isPhoto) {
      widget.onTakePicture?.call();
      return;
    }
    final isRecording = widget.state.isRecording || recordingProgress > 0;
    if (isRecording) {
      stopAnimations();
      widget.onStopRecording?.call();
      return;
    }
    startAnimations();
    widget.onStartRecording?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      child: SizedBox(
        width: _kCaptureButtonDiameter,
        height: _kCaptureButtonDiameter,
        child: widget.type.isPhoto || widget.state.isActive
            ? _ActiveButton(
                innerDiameter: _innerDiameter,
                backgroundColor: theme.colors.bgContainerSecondary,
                innerColor: widget.type.isPhoto
                    ? theme.colors.labelAlwaysWhite
                    : theme.colors.labelDestructive,
              )
            : _RecordingButton(
                progress: recordingProgress,
                backgroundColor: theme.colors.bgContainerSecondary,
                progressColor: theme.colors.labelAlwaysWhite,
                stopIconColor: theme.colors.labelDestructive,
              ),
      ),
    );
  }

  @override
  void dispose() {
    timerCircularProgress?.cancel();
    super.dispose();
  }
}

class _ActiveButton extends StatelessWidget {
  const _ActiveButton({
    required this.innerDiameter,
    required this.backgroundColor,
    required this.innerColor,
  });

  final double innerDiameter;
  final Color backgroundColor;
  final Color innerColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _kCaptureButtonDiameter,
          height: _kCaptureButtonDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
        ),
        Container(
          width: innerDiameter,
          height: innerDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: innerColor,
          ),
        ),
      ],
    );
  }
}

class _RecordingButton extends StatelessWidget {
  const _RecordingButton({
    required this.progress,
    required this.backgroundColor,
    required this.progressColor,
    required this.stopIconColor,
  });

  final double progress;
  final Color backgroundColor;
  final Color progressColor;
  final Color stopIconColor;

  static const double _kStopIconSize = 32.0;
  static const double _kStopIconRadius = 8.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: _kCaptureButtonDiameter,
          height: _kCaptureButtonDiameter,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
        ),
        CustomPaint(
          size: const Size(_kCaptureButtonDiameter, _kCaptureButtonDiameter),
          painter: _InnerStrokeProgressPainter(
            progress: progress,
            color: progressColor,
            strokeWidth: _kCaptureButtonRingStroke,
          ),
        ),
        Container(
          width: _kStopIconSize,
          height: _kStopIconSize,
          decoration: BoxDecoration(
            color: stopIconColor,
            borderRadius: BorderRadius.circular(_kStopIconRadius),
          ),
        ),
      ],
    );
  }
}

class _InnerStrokeProgressPainter extends CustomPainter {
  _InnerStrokeProgressPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final double inset = strokeWidth / 2;
    final Rect rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - 2 * inset,
      size.height - 2 * inset,
    );

    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    const double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * progress;
    canvas.drawArc(rect, startAngle, sweepAngle, false, paint);
  }

  @override
  bool shouldRepaint(_InnerStrokeProgressPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
