import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum DotsSelectorSize {
  small(height: 22),
  medium(height: 24);

  final double height;

  const DotsSelectorSize({required this.height});

  bool get isSmall => this == DotsSelectorSize.small;
  bool get isMedium => this == DotsSelectorSize.medium;
}

enum DotsSelectorVariant {
  /// Show a check inside when selected.
  check,

  /// Show a number inside when selected.
  num,
  ;

  bool get isCheck => this == DotsSelectorVariant.check;
  bool get isNum => this == DotsSelectorVariant.num;
}

class DotsSelector extends StatelessWidget {
  /// The size of the selector (small or medium).
  final DotsSelectorSize size;

  /// The visual variant of the selector (check or number).
  final DotsSelectorVariant variant;

  /// Whether this selector is currently selected.
  final bool isSelected;

  /// *(Only for numbers variant)* Number inside the selector when it's selected.
  final int number;

  const DotsSelector._({
    super.key,
    this.size = DotsSelectorSize.medium,
    this.variant = DotsSelectorVariant.check,
    required this.isSelected,
    this.number = 1,
  });

  factory DotsSelector.check({
    Key? key,
    DotsSelectorSize? size,
    required bool isSelected,
  }) =>
      DotsSelector._(
        key: key,
        size: size = DotsSelectorSize.medium,
        variant: DotsSelectorVariant.check,
        isSelected: isSelected,
      );

  factory DotsSelector.num({
    Key? key,
    DotsSelectorSize? size,
    required bool isSelected,
    required int number,
  }) =>
      DotsSelector._(
        key: key,
        size: size = DotsSelectorSize.medium,
        variant: DotsSelectorVariant.num,
        isSelected: isSelected,
        number: number,
      );

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return isSelected
        ? Container(
            constraints: BoxConstraints(
              minWidth: size.height,
              maxHeight: size.height,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.height),
              color: theme.colors.labelHighlight,
            ),
            child: IntrinsicWidth(
              child: Center(
                widthFactor: 1,
                child: variant.isCheck
                    ? DotsIcon(
                        iconData: DotsIconData.check,
                        size: 14,
                        color: theme.colors.labelAlwaysWhite,
                      )
                    : Text(
                        number.toString(),
                        style: theme.typo.main.bodyDefaultMedium.copyWith(
                          color: theme.colors.labelAlwaysWhite,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          )
        : Container(
            width: size.height,
            height: size.height,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colors.labelAlwaysWhite.dotsWithOpacity(0.7),
                width: 2,
              ),
            ),
          );
  }
}
