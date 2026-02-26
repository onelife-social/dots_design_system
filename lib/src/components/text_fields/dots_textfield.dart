import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DotsTextField extends StatefulWidget {
  /// The controller for the TextField.
  /// Used to manage the text input.
  final TextEditingController controller;

  /// The focus node for the TextField.
  /// Used to manage the focus.
  final FocusNode focusNode;

  /// The icon data for the TextField.
  ///
  /// If null, no icon will be displayed.
  final DotsIconData? iconData;

  /// Optional leading widget (e.g. country selector for phone).
  /// When set, it is shown on the left of the input.
  final Widget? leading;

  /// The hint text to display in the TextField.
  final String? hintText;

  /// Callback when the text in the TextField changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the user submits the TextField (e.g., by pressing the enter key on the keyboard).
  final ValueChanged<String>? onSubmitted;

  /// The maximum length of text that can be entered in the TextField.
  final int? maxTextLength;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// The error text to display below the TextField.
  final String? errorText;

  /// Whether the TextField is enabled.
  ///
  /// Defaults to `true`.
  final bool enabled;

  /// Whether to display a background color.
  ///
  /// Defaults to `true`.
  final bool background;

  /// Whether to show the underline when [background] is false.
  ///
  /// Defaults to `true`.
  final bool showUnderline;

  /// Whether to align the text in the center.
  ///
  /// Defaults to `false`.
  final bool alignCenter;

  /// Custom text style for the input text.
  ///
  /// Defaults to `theme.typo.main.bodyDefaultMedium`.
  final TextStyle? textStyle;

  /// The type of keyboard to show for the TextField.
  final TextInputType? keyboardType;

  /// Optional list of input formatters (e.g. to restrict to digits only).
  final List<TextInputFormatter>? inputFormatters;

  const DotsTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.iconData,
    this.leading,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.maxTextLength,
    this.isError = false,
    this.errorText,
    this.enabled = true,
    this.background = true,
    this.showUnderline = false,
    this.alignCenter = false,
    this.textStyle,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  State<DotsTextField> createState() => _DotsTextFieldState();
}

class _DotsTextFieldState extends State<DotsTextField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = widget.focusNode;
    _controller.addListener(_handleTextOrFocusChange);
    _focusNode.addListener(_handleTextOrFocusChange);
  }

  @override
  void didUpdateWidget(covariant DotsTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      _controller.removeListener(_handleTextOrFocusChange);
      _controller = widget.controller;
      _controller.addListener(_handleTextOrFocusChange);
    }
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.removeListener(_handleTextOrFocusChange);
      _focusNode = widget.focusNode;
      _focusNode.addListener(_handleTextOrFocusChange);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleTextOrFocusChange);
    _focusNode.removeListener(_handleTextOrFocusChange);
    super.dispose();
  }

  void _handleTextOrFocusChange() {
    if (mounted) {
      setState(() {});
    }
  }

  bool get _showClearButton {
    return widget.enabled && _focusNode.hasFocus && _controller.text.isNotEmpty;
  }

  void _clearText() {
    _controller.clear();
    widget.onChanged?.call('');
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final textAlign = widget.alignCenter ? TextAlign.center : TextAlign.left;
    final inputTextStyle = widget.textStyle ?? theme.typo.main.bodyDefaultMedium;

    final decoration = widget.background
        ? ShapeDecoration(
            color: theme.colors.bgContainerSecondaryOnBackground,
            shape: RoundedRectangleBorder(borderRadius: DotsBorderRadius.r1000),
          )
        : widget.showUnderline
        ? BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: theme.colors.labelSecondary.dotsWithOpacity(0.3, multiplyWithExisting: true),
                width: 0.5,
              ),
            ),
          )
        : null;

    Widget buildTextField() {
      return TextField(
        controller: _controller,
        focusNode: _focusNode,
        maxLength: widget.maxTextLength,
        minLines: 1,
        maxLines: 1,
        textAlign: textAlign,
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        style: inputTextStyle.copyWith(
          color: widget.isError && !widget.background
              ? theme.colors.labelDestructive
              : theme.colors.textPrimary,
        ),
        cursorColor: theme.colors.labelHighlight,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: widget.hintText,
          hintStyle: TextStyle(color: theme.colors.textQuarternary),
          isDense: true,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        enabled: widget.enabled,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
          child: Container(
            height: 44,
            clipBehavior: decoration != null ? Clip.antiAlias : Clip.none,
            decoration: decoration,
            padding: widget.background
                ? const EdgeInsets.symmetric(horizontal: 16)
                : EdgeInsets.zero,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Align(
                    alignment: widget.alignCenter ? Alignment.center : Alignment.centerLeft,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if (widget.leading != null) widget.leading!,
                        if (widget.iconData != null) ...[
                          DotsIcon(
                            iconData: widget.iconData!,
                            color: !widget.background && widget.isError
                                ? theme.colors.labelDestructive
                                : theme.colors.textTertiary,
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Expanded(child: buildTextField()),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: _showClearButton
                      ? GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: _clearText,
                          child: Center(
                            child: DotsCloseButton(
                              size: DotsCloseButtonSize.extraSmall,
                              variant: widget.background
                                  ? DotsCloseButtonVariant.inverted
                                  : DotsCloseButtonVariant.softContrast,
                              onTap: _clearText,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
        if (widget.background && widget.isError && widget.errorText?.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 4),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                widget.errorText!,
                textAlign: textAlign,
                style: theme.typo.main.labelDefaultRegular.copyWith(
                  color: theme.colors.labelDestructive,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
