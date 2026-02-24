import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsInputStepper extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final VoidCallback onIncrement;
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
              color: theme.colors.textTertiary,
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
              color: theme.colors.textTertiary,
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
