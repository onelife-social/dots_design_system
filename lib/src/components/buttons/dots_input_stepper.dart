import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsInputStepper extends StatelessWidget {
  /// Current value displayed by the stepper.
  final int value;

  /// Minimum allowed value.
  final int minValue;

  /// Maximum allowed value.
  final int maxValue;

  /// Callback triggered when the increment button is tapped.
  final VoidCallback onIncrement;

  /// Callback triggered when the decrement button is tapped.
  final VoidCallback onDecrement;

  const DotsInputStepper({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onIncrement,
    required this.onDecrement,
  });

  bool get _canIncrement => value < maxValue;
  bool get _canDecrement => value > minValue;

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.colors.bgContainerSecondaryOnBackground,
        borderRadius: BorderRadius.circular(1000),
      ),
      width: 116,
      height: 41,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            DotsIconButton(
              icon: DotsIconData.rest,
              size: DotsIconButtonSize.small,
              // Enabled uses the muted textTertiary (differs from the theme's
              // default textPrimary); disabled falls through to null so the
              // button theme resolves the disabled foreground.
              color: _canDecrement ? theme.colors.textTertiary : null,
              backgroundColor: Colors.transparent,
              state: _canDecrement
                  ? DotsIconButtonState.defaultState
                  : DotsIconButtonState.disabled,
              onTap: _canDecrement ? onDecrement : null,
              shouldApplyBlur: false,
            ),
            Text(
              value.toString(),
              style: theme.typo.main.bodyLargeMedium.copyWith(
                color: theme.colors.textPrimary,
              ),
            ),
            DotsIconButton(
              icon: DotsIconData.add,
              size: DotsIconButtonSize.small,
              color: _canIncrement ? theme.colors.textTertiary : null,
              backgroundColor: Colors.transparent,
              state: _canIncrement
                  ? DotsIconButtonState.defaultState
                  : DotsIconButtonState.disabled,
              onTap: _canIncrement ? onIncrement : null,
              shouldApplyBlur: false,
            ),
          ],
        ),
      ),
    );
  }
}
