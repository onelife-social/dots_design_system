import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextFieldButton extends StatefulWidget {
  /// The icon data for the TextField.
  ///
  /// If null, no icon will be displayed.
  final DotsIconData? iconData;

  /// The icon data for the close button.
  final DotsIconData iconDataButton;

  /// Callback when the close button is tapped.
  /// This is typically used to clear the text field.
  final Function()? onTapBtn;

  /// The variant of the close button.
  ///
  /// - [DotsCloseButtonVariant.inverted]
  final DotsCloseButtonVariant buttonVariant;

  /// The size of the close button.
  ///
  /// Defaults to [DotsCloseButtonSize.extraSmall].
  final DotsCloseButtonSize buttonSize;

  /// The hint text to display in the TextField.
  final String? hintText;

  /// The maximum length of text that can be entered in the TextField.
  final int? maxTextLength;

  /// How the platform keyboard should capitalize text while typing.
  ///
  /// Defaults to [TextCapitalization.none].
  final TextCapitalization textCapitalization;

  /// Callback when the text in the TextField changes.
  final ValueChanged<String>? onChanged;

  /// Callback when the user submits the TextField (e.g., by pressing the enter key on the keyboard).
  final ValueChanged<String>? onSubmitted;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// Text displayed as error.
  final String? errorText;

  /// Whether to align the text in the center.
  ///
  /// Defaults to false.
  final bool alignCenter;

  /// The controller for the TextField.
  /// Used to manage the text input. A default one is provided if non is passed as a parameter
  final TextEditingController? controller;

  /// The focus node for the TextField.
  /// Used to manage the focus. A default one is provided if non is passed as a parameter
  final FocusNode? focusNode;

  /// Whether to display a background color.
  ///
  /// Defaults to `true`.
  final bool background;

  /// The text for the end button.
  ///
  /// Defaults to null.
  final String? endButtonText;

  /// The text color of the end button.
  ///
  /// Defaults to [DotsColorsModel.labelHighlight].
  final Color? endButtonTextColor;

  /// Callback when the right button text is tapped.
  ///
  /// If null, the right button will not be tappable.
  final VoidCallback? onEndButtonTap;

  /// Whether to show a check icon after the text.
  ///
  /// Defaults to false.
  final DotsIconData? suffixIcon;

  /// The color of the suffix icon.
  ///
  /// Defaults to null.
  final Color? suffixIconColor;

  /// Whether the TextField is enabled.
  ///
  /// Defaults to true.
  final bool enabled;

  /// Whether to apply the error color to the TextField.
  ///
  /// Defaults to true.
  final bool applyErrorColor;

  /// Whether to apply the error asterisk to the error text.
  ///
  /// Defaults to true.
  final bool applyErrorAsterisk;

  const DotsTextFieldButton({
    super.key,
    this.iconData,
    this.onTapBtn,
    this.hintText = '',
    this.maxTextLength,
    this.textCapitalization = TextCapitalization.none,
    this.iconDataButton = DotsIconData.cross,
    this.buttonVariant = DotsCloseButtonVariant.inverted,
    this.buttonSize = DotsCloseButtonSize.extraSmall,
    this.onChanged,
    this.onSubmitted,
    this.isError = false,
    this.errorText,
    this.alignCenter = false,
    this.controller,
    this.focusNode,
    this.background = true,
    this.endButtonText,
    this.endButtonTextColor,
    this.onEndButtonTap,
    this.suffixIcon,
    this.suffixIconColor,
    this.enabled = true,
    this.applyErrorColor = true,
    this.applyErrorAsterisk = true,
  });

  @override
  State<DotsTextFieldButton> createState() => _DotsTextFieldButtonState();
}

class _DotsTextFieldButtonState extends State<DotsTextFieldButton> {
  late final TextEditingController _controller = widget.controller ?? TextEditingController();
  late final FocusNode _focusNode = widget.focusNode ?? FocusNode();
  final ValueNotifier<bool> _showClearButton = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _controller.addListener(_updateClearButton);
    _focusNode.addListener(_updateClearButton);
    _updateClearButton();
  }

  void _updateClearButton() {
    final show = _controller.text.isNotEmpty && _focusNode.hasFocus;
    if (_showClearButton.value != show) {
      _showClearButton.value = show;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateClearButton);
    _focusNode.removeListener(_updateClearButton);
    _showClearButton.dispose();
    if (widget.controller == null) _controller.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _defaultClear() {
    _controller.clear();
    widget.onChanged?.call('');
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final icon = widget.iconData;
    final TextAlign textAlign = widget.alignCenter ? TextAlign.center : TextAlign.left;

    return ValueListenableBuilder<bool>(
      valueListenable: _showClearButton,
      builder: (context, showClear, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 44,
              clipBehavior: Clip.antiAlias,
              decoration: ShapeDecoration(
                color: widget.background == true
                    ? theme.colors.bgContainerSecondaryOnBackground
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: DotsBorderRadius.r1000,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (icon != null)
                    DotsIcon(
                      iconData: icon,
                      color: widget.isError
                          ? theme.colors.labelDestructive
                          : theme.colors.textTertiary,
                      size: 20,
                    ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: TextField(
                      focusNode: _focusNode,
                      controller: _controller,
                      maxLength: widget.maxTextLength,
                      textAlign: textAlign,
                      textCapitalization: widget.textCapitalization,
                      style: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: widget.applyErrorColor && widget.isError
                            ? theme.colors.labelDestructive
                            : theme.colors.textPrimary,
                      ),
                      cursorColor: theme.colors.labelHighlight,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        counterText: '',
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: widget.isError
                              ? theme.colors.labelDestructive
                              : theme.colors.textTertiary,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        suffixIcon: widget.suffixIcon != null
                            ? DotsIcon(
                                iconData: widget.suffixIcon!,
                                color: widget.suffixIconColor ?? theme.colors.labelHighlight,
                                size: 16,
                              )
                            : showClear
                            ? DotsCloseButton(
                                icon: widget.iconDataButton,
                                variant: widget.buttonVariant,
                                size: widget.buttonSize,
                                onTap: widget.onTapBtn ?? _defaultClear,
                              )
                            : null,
                        suffixIconConstraints: const BoxConstraints(
                          minWidth: 0,
                          minHeight: 0,
                        ),
                      ),
                      onChanged: widget.onChanged,
                      onSubmitted: widget.onSubmitted,
                      enabled: widget.enabled,
                    ),
                  ),
                  if (widget.endButtonText != null) ...[
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 8,
                        left: 12,
                        right: 16,
                      ),
                      child: Container(
                        width: 0.5,
                        color: theme.colors.textDisabled,
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: widget.onEndButtonTap,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          widget.endButtonText!,
                          style: theme.typo.main.bodyDefaultMedium.copyWith(
                            color: widget.endButtonTextColor ?? theme.colors.labelHighlight,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (widget.isError && widget.errorText != null) ...[
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  widget.applyErrorAsterisk ? '* ${widget.errorText}' : widget.errorText ?? '',
                  style: theme.typo.main.labelDefaultRegular.copyWith(
                    color: theme.colors.labelDestructive,
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
