import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class TextFieldsDemo extends StatelessWidget {

  /// The icon data for the TextField.
  final DotsIconData iconData;

  /// The hint text to display in the TextField.
  final String hintText;

  /// Callback when the text changes.
  final ValueChanged<String>? onChanged;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// Creates a DotsTextFields widget.
  final String? errorText;

  /// The icon data for the close button.
  final DotsIconData iconDataButton;

  /// The variant of the close button.
  final DotsCloseButtonVariant buttonVariant;

  /// The size of the close button.
  final DotsCloseButtonSize buttonSize;

  const TextFieldsDemo({
    super.key,
    required this.iconData,
    required this.hintText,
    required this.iconDataButton,
    required this.buttonVariant,
    required this.buttonSize,
    this.onChanged,
    this.isError = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotsTextField(
          iconData: iconData,
          hintText: hintText,
          iconDataButton: iconDataButton,
          buttonVariant: buttonVariant,
          buttonSize: buttonSize,
          onChanged: onChanged,
          isError: isError,
          errorText: errorText,
        ),
      ],
    );
  }
}
