import 'dart:async';

import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class CountdownRecap extends StatefulWidget {
  /// The title to be displayed.
  final String title;

  /// The date it will be unlocked.
  final DateTime countdownDate;

  /// The description to be displayed when countdown is completed.
  final String description;

  /// The label for days.
  final String daysLabel;

  /// The label for hours.
  final String hoursLabel;

  /// The label for minutes.
  final String minutesLabel;

  /// The label for seconds.
  final String secondsLabel;

  final bool isDotbook;

  const CountdownRecap({
    super.key,
    required this.title,
    required this.countdownDate,
    required this.description,
    required this.daysLabel,
    required this.hoursLabel,
    required this.minutesLabel,
    required this.secondsLabel,
    this.isDotbook = false,
  });

  @override
  State<CountdownRecap> createState() => _CountdownRecapState();
}

class _CountdownRecapState extends State<CountdownRecap> {
  Timer? _timer;
  Duration _timeRemaining = Duration.zero;
  bool _isCountdownFinished = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void didUpdateWidget(CountdownRecap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countdownDate != widget.countdownDate) {
      _startCountdown();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateCountdown();
    });
  }

  void _updateCountdown() {
    final now = DateTime.now();
    final difference = widget.countdownDate.difference(now);

    setState(() {
      if (difference.isNegative) {
        _timeRemaining = Duration.zero;
        _isCountdownFinished = true;
        _timer?.cancel();
      } else {
        _timeRemaining = difference;
        _isCountdownFinished = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final decoration = BoxDecoration(
      color: widget.isDotbook 
        ? theme.colors.textDisabled 
        : theme.colors.bgContainerSecondaryOnBackground,
      borderRadius: DotsBorderRadius.r24,
      border: Border.all(
        color: Colors.white.dotsWithOpacity(0.3),
        width: 1,
      ),
    );

    return DotsDecoratedBox(
      styleType: theme.styles.blur20,
      decoration: decoration,
      child: DotsDecoratedBox(
        styleType: theme.styles.toastShadow,
        decoration: decoration,
        child: DotsDecoratedBox(
          styleType: theme.styles.squircle24,
          decoration: decoration,
          child: SizedBox(
            width: 192,
            child: Padding(
              padding: EdgeInsetsGeometry.only(left: 16, right: 16, top: 12, bottom: 16),
              child: _isCountdownFinished
                  ? _CountdownFinishedBody(
                      title: widget.title,
                      description: widget.description,
                    )
                  : _CountdownRecapBody(
                      title: widget.title,
                      timeRemaining: _timeRemaining,
                      daysLabel: widget.daysLabel,
                      hoursLabel: widget.hoursLabel,
                      minutesLabel: widget.minutesLabel,
                      secondsLabel: widget.secondsLabel,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CountdownRecapBody extends StatelessWidget {
  final String title;
  final Duration timeRemaining;
  final String daysLabel;
  final String hoursLabel;
  final String minutesLabel;
  final String secondsLabel;

  const _CountdownRecapBody({
    required this.title,
    required this.timeRemaining,
    required this.daysLabel,
    required this.hoursLabel,
    required this.minutesLabel,
    required this.secondsLabel,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate time components
    final days = timeRemaining.inDays;
    final hours = timeRemaining.inHours % 24;
    final minutes = timeRemaining.inMinutes % 60;
    final seconds = timeRemaining.inSeconds % 60;

    final horizontalSpacing = SizedBox(width: 10.5);

    return _CountdownBaseBody(
      title: title,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CountdownTimeItem(
            value: days.toString().padLeft(2, '0'),
            label: daysLabel,
          ),
          horizontalSpacing,
          _CountdownTimeItem(
            value: hours.toString().padLeft(2, '0'),
            label: hoursLabel,
          ),
          horizontalSpacing,
          _CountdownTimeItem(
            value: minutes.toString().padLeft(2, '0'),
            label: minutesLabel,
          ),
          horizontalSpacing,
          _CountdownTimeItem(
            value: seconds.toString().padLeft(2, '0'),
            label: secondsLabel,
          ),
        ],
      ),
    );
  }
}

class _CountdownTimeItem extends StatelessWidget {
  final String value;
  final String label;

  const _CountdownTimeItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: theme.typo.main.titleH4.copyWith(color: textColor),
        ),
        Text(
          label,
          style: theme.typo.main.labelSmallMedium.copyWith(color: textColor.dotsWithOpacity(0.7)),
        ),
      ],
    );
  }
}

class _CountdownFinishedBody extends StatelessWidget {
  final String title;
  final String description;

  const _CountdownFinishedBody({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;

    return _CountdownBaseBody(
      title: title,
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: theme.typo.main.labelDefaultRegular.copyWith(color: textColor.dotsWithOpacity(0.7)),
      ),
    );
  }
}

class _CountdownBaseBody extends StatelessWidget {
  final String title;
  final Widget child;

  const _CountdownBaseBody({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final Color textColor = theme.colors.labelAlwaysWhite;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        DotsIcon(iconData: DotsIconData.lock, size: 20, color: textColor),
        const SizedBox(height: 4),
        Text(
          title,
          textAlign: TextAlign.center,
          style: theme.typo.main.labelDefaultBold.copyWith(color: textColor),
        ),
        const SizedBox(height: 6),
        child,
      ],
    );
  }
}
