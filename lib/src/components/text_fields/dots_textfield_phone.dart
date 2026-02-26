import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Represents a country code for phone input (dial code + flag).
class PhoneCountryCode {
  const PhoneCountryCode({
    required this.dialCode,
    required this.flagEmoji,
  });

  /// International dial code, e.g. "+34".
  final String dialCode;

  /// Flag emoji for the country, e.g. "🇪🇸".
  final String flagEmoji;
}

/// Text field for phone numbers with a leading country code selector
/// (flag + dial code + chevron). Uses [DotsTextField] with [leading].
class TextFieldPhone extends StatelessWidget {
  /// The controller for the phone number input.
  final TextEditingController controller;

  /// The focus node for the TextField.
  final FocusNode focusNode;

  /// Currently selected country code (flag + dial code).
  final PhoneCountryCode countryCode;

  /// Called when the user taps the country code selector.
  final VoidCallback onCountryTap;

  /// The hint text to display in the TextField.
  final String? hintText;

  /// Callback when the text in the TextField changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the user submits the TextField.
  final ValueChanged<String>? onSubmitted;

  /// The maximum length of the phone number (digits only).
  final int? maxTextLength;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// The error text to display below the TextField.
  final String? errorText;

  /// Whether the TextField is enabled.
  final bool enabled;

  /// Whether to display a background color.
  final bool background;

  /// Whether to show the underline when [background] is false.
  ///
  /// Defaults to `false`.
  final bool showUnderline;

  const TextFieldPhone({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.countryCode,
    required this.onCountryTap,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.maxTextLength,
    this.isError = false,
    this.errorText,
    this.enabled = true,
    this.background = true,
    this.showUnderline = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final leading = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onCountryTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${countryCode.flagEmoji} (${countryCode.dialCode})',
              style: theme.typo.main.bodyDefaultMedium.copyWith(
                color: theme.colors.textSecondary,
              ),
            ),
            const SizedBox(width: 12),
            Container(width: 0.5, color: theme.colors.labelSecondary),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );

    return DotsTextField(
      controller: controller,
      focusNode: focusNode,
      leading: leading,
      hintText: hintText,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      maxTextLength: maxTextLength,
      isError: isError,
      errorText: errorText,
      enabled: enabled,
      background: background,
      showUnderline: showUnderline,
      keyboardType: TextInputType.phone,
    );
  }
}
