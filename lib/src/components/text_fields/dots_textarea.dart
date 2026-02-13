import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextArea extends StatelessWidget {
  /// The controller for the TextField.
  /// Used to manage the text input.
  final TextEditingController controller;

  /// The focus node for the TextField.
  /// Used to manage the focus.
  final FocusNode focusNode;

  /// The label text to display above the TextField.
  final String? label;

  /// The icon data for the TextField.
  ///
  /// If null, no icon will be displayed.
  final DotsIconData? iconData;

  /// The hint text to display in the TextField.
  final String? hintText;

  /// The maximum length of text that can be entered in the TextField.
  final int? maxTextLength;

  /// The minimum height of the TextField. If null, the TextField minHeight will be maxHeight.
  final int? minHeight;

  /// The maximum height of the TextField. If null, the TextField will expand to fit its content.
  final int? maxHeight;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// Creates a DotsTextFieldButton widget.
  final String? errorText;

  const DotsTextArea({
    super.key,
    required this.controller,
    required this.focusNode,
    this.label,
    this.iconData,
    this.hintText,
    this.maxTextLength,
    this.minHeight,
    this.maxHeight,
    this.isError = false,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final hasLabel = label?.isNotEmpty == true;
    final hasIcon = iconData != null;

    List<Widget> buildLeadingIcon() {
      if (!hasIcon) return const [];

      return [
        DotsIcon(
          iconData: iconData!,
          color: theme.colors.textTertiary,
          size: 20,
        ),
        const SizedBox(width: 8),
      ];
    }

    Widget buildTextField() {
      return TextField(
        controller: controller,
        focusNode: focusNode,
        maxLength: maxTextLength,
        keyboardType: TextInputType.multiline,
        minLines: 1,
        maxLines: null,
        textAlign: TextAlign.justify,
        style: theme.typo.main.bodyLargeRegular.copyWith(
          color: theme.colors.textPrimary,
        ),
        cursorColor: theme.colors.labelHighlight,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: hintText,
          hintStyle: theme.typo.main.bodyLargeRegular.copyWith(
            color: theme.colors.textQuarternary,
          ),
          isDense: true,
          contentPadding: EdgeInsets.zero,
        ),
      );
    }

    Widget buildBody() {
      if (hasLabel) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ...buildLeadingIcon(),
                Text(
                  label!,
                  style: theme.typo.main.bodyLargeMedium.copyWith(
                    color: theme.colors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Padding(
              padding: EdgeInsets.only(
                left: hasIcon ? 28 : 0,
              ),
              child: buildTextField(),
            ),
          ],
        );
      }

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...buildLeadingIcon(),
          Expanded(
            child: buildTextField(),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          constraints: BoxConstraints(
            minHeight: minHeight?.toDouble() ?? maxHeight?.toDouble() ?? double.infinity,
            maxHeight: maxHeight?.toDouble() ?? double.infinity,
          ),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: theme.colors.bgContainerSecondaryOnBackground,
            shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r24),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                child: buildBody(),
              ),
              if (maxTextLength != null)
                Positioned(
                  right: 16,
                  bottom: 10,
                  child: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      final remaining = (maxTextLength! - value.text.length).clamp(
                        0,
                        maxTextLength!,
                      );
                      return Text(
                        '$remaining',
                        style: theme.typo.main.labelSmallRegular.copyWith(
                          color:  theme.colors.textQuarternary,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
        if (isError && errorText?.isNotEmpty == true) ...[
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              errorText!,
              style: theme.typo.main.labelDefaultRegular.copyWith(
                color: theme.colors.labelDestructive,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
