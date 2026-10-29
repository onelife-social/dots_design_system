import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Height of [DotsTextField], as the `Container` property of Figma's textField.
enum DotsTextFieldContainer {
  defaultContainer(44),
  big(52);

  const DotsTextFieldContainer(this.height);

  final double height;
}

/// Type style of the [DotsTextField] input and hint, as the text size of Figma's textField.
enum DotsTextFieldTextSize {
  bodyDefault,
  bodyLarge,
  titleH6,
  titleH5;

  TextStyle style(DotsTypoModel typo) => switch (this) {
    DotsTextFieldTextSize.bodyDefault => typo.main.bodyDefaultMedium,
    DotsTextFieldTextSize.bodyLarge => typo.main.bodyLargeMedium,
    DotsTextFieldTextSize.titleH6 => typo.main.titleH6,
    DotsTextFieldTextSize.titleH5 => typo.main.titleH5,
  };
}

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

  /// Whether to add hint text color error.
  final bool? addHintTextColorError;

  /// Callback when the text in the TextField changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the user submits the TextField (e.g., by pressing the enter key on the keyboard).
  final ValueChanged<String>? onSubmitted;

  /// Callback when the TextField loses focus.
  final ValueChanged<String>? onFocusLost;

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
  /// Defaults to `false`.
  final bool showUnderline;

  /// Whether to align the text in the center.
  ///
  /// Defaults to `false`.
  final bool alignCenter;

  /// The height of the TextField.
  ///
  /// Defaults to [DotsTextFieldContainer.defaultContainer] (44 px).
  final DotsTextFieldContainer container;

  /// The type style of the input and hint text.
  ///
  /// Defaults to [DotsTextFieldTextSize.bodyDefault]. [textStyle], when set, replaces it.
  final DotsTextFieldTextSize textSize;

  /// Custom text style for the input text.
  ///
  /// Defaults to the style of [textSize].
  final TextStyle? textStyle;

  /// The type of keyboard to show for the TextField.
  final TextInputType? keyboardType;

  /// How the platform keyboard should capitalize text while typing.
  ///
  /// Defaults to [TextCapitalization.none].
  final TextCapitalization textCapitalization;

  /// Optional list of input formatters (e.g. to restrict to digits only).
  final List<TextInputFormatter>? inputFormatters;

  /// The accessible name of the TextField, read before the hint.
  final String? semanticsLabel;

  /// The accessible name of the clear button.
  ///
  /// There is no fallback: pass it translated, or the button is announced without a name.
  final String? clearSemanticsLabel;

  /// Whether the keyboard autocorrects the text.
  ///
  /// Defaults to `true`.
  final bool autocorrect;

  /// Whether the keyboard shows suggestions while typing.
  ///
  /// Defaults to `true`.
  final bool enableSuggestions;

  /// The autofill hints of the TextField. `null` turns autofill off.
  ///
  /// Defaults to an empty list, as [TextField].
  final Iterable<String>? autofillHints;

  /// The action of the keyboard's action key (e.g. [TextInputAction.search]).
  final TextInputAction? textInputAction;

  const DotsTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    this.iconData,
    this.leading,
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.onFocusLost,
    this.maxTextLength,
    this.isError = false,
    this.errorText,
    this.enabled = true,
    this.background = true,
    this.showUnderline = false,
    this.alignCenter = false,
    this.container = DotsTextFieldContainer.defaultContainer,
    this.textSize = DotsTextFieldTextSize.bodyDefault,
    this.textStyle,
    this.keyboardType,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.addHintTextColorError,
    this.semanticsLabel,
    this.clearSemanticsLabel,
    this.autocorrect = true,
    this.enableSuggestions = true,
    this.autofillHints = const <String>[],
    this.textInputAction,
  });

  @override
  State<DotsTextField> createState() => _DotsTextFieldState();
}

class _DotsTextFieldState extends State<DotsTextField> {
  static const _clearButtonSize = DotsCloseButtonSize.extraSmall;
  static const double _clearTapTarget = 44;

  late TextEditingController _controller;
  late FocusNode _focusNode;
  late bool _hasFocus;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _focusNode = widget.focusNode;
    _hasFocus = _focusNode.hasFocus;
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
      _hasFocus = _focusNode.hasFocus;
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
    final hasLostFocus = _hasFocus && !_focusNode.hasFocus;
    _hasFocus = _focusNode.hasFocus;

    if (hasLostFocus) {
      widget.onFocusLost?.call(_controller.text);
    }

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
    final inputTextStyle = widget.textStyle ?? widget.textSize.style(theme.typo);
    final horizontalPadding = widget.background ? 16.0 : 0.0;
    final clearSlot = SizedBox(width: _clearButtonSize.size);

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
        textCapitalization: widget.textCapitalization,
        inputFormatters: widget.inputFormatters,
        autocorrect: widget.autocorrect,
        enableSuggestions: widget.enableSuggestions,
        autofillHints: widget.autofillHints,
        textInputAction: widget.textInputAction,
        style: inputTextStyle.copyWith(
          color: widget.isError && !widget.background && !_focusNode.hasFocus
              ? theme.colors.labelDestructive
              : theme.colors.textPrimary,
        ),
        cursorColor: theme.colors.labelHighlight,
        decoration: InputDecoration(
          border: InputBorder.none,
          counterText: '',
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: widget.addHintTextColorError == true && widget.isError && !_focusNode.hasFocus
                ? theme.colors.labelDestructive
                : theme.colors.textQuarternary,
          ),
          isDense: true,
        ),
        onChanged: widget.onChanged,
        onSubmitted: widget.onSubmitted,
        enabled: widget.enabled,
      );
    }

    Widget buildClearButton() {
      return Semantics(
        container: true,
        button: true,
        label: widget.clearSemanticsLabel,
        onTap: _clearText,
        excludeSemantics: true,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _clearText,
          child: SizedBox.square(
            dimension: _clearTapTarget,
            child: Align(
              alignment: widget.background ? Alignment.center : Alignment.centerRight,
              child: DotsCloseButton(
                size: _clearButtonSize,
                variant: widget.background
                    ? DotsCloseButtonVariant.inverted
                    : DotsCloseButtonVariant.softContrast,
                onTap: _clearText,
              ),
            ),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: widget.enabled ? () => _focusNode.requestFocus() : null,
          child: Stack(
            children: [
              Container(
                height: widget.container.height,
                clipBehavior: decoration != null ? Clip.antiAlias : Clip.none,
                decoration: decoration,
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Row(
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
                    if (widget.alignCenter) clearSlot,
                    Expanded(
                      child: Semantics(label: widget.semanticsLabel, child: buildTextField()),
                    ),
                    if (widget.alignCenter || _showClearButton) clearSlot,
                  ],
                ),
              ),
              if (_showClearButton)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: widget.background
                      ? horizontalPadding - (_clearTapTarget - _clearButtonSize.size) / 2
                      : 0,
                  child: Center(child: TextFieldTapRegion(child: buildClearButton())),
                ),
            ],
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
