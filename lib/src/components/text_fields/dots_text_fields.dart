import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextField extends StatefulWidget {
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

  /// Callback when the text in the TextField changes.
  final ValueChanged<String>? onChanged;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// Creates a DotsTextFields widget.
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

  /// The text for the right button.
  ///
  /// Defaults to null.
  final String? endButtonText;

  /// Callback when the right button text is tapped.
  ///
  /// If null, the right button will not be tappable.
  final Function()? onEndButtonTap;

  const DotsTextField({
    super.key,
    this.iconData,
    this.onTapBtn,
    this.hintText = '',
    this.maxTextLength,
    this.iconDataButton = DotsIconData.cross,
    this.buttonVariant = DotsCloseButtonVariant.inverted,
    this.buttonSize = DotsCloseButtonSize.extraSmall,
    this.onChanged,
    this.isError = false,
    this.errorText,
    this.alignCenter = false,
    this.controller,
    this.focusNode,
    this.background = true,
    this.endButtonText,
    this.onEndButtonTap,
  });

  @override
  State<DotsTextField> createState() => _DotsTextFieldState();
}

class _DotsTextFieldState extends State<DotsTextField> {
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
                      style: theme.typo.main.bodyDefaultMedium.copyWith(
                        color: widget.isError
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
                        suffixIcon: showClear
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
                    ),
                  ),
                  if (widget.endButtonText != null) ...[
                    const SizedBox(width: 12),
                    Container(
                      width: 0.5,
                      height: 24,
                      color: theme.colors.labelSecondary.dotsWithOpacity(0.3),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: widget.onEndButtonTap,
                      child: Container(
                        height: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          widget.endButtonText!,
                          style: theme.typo.main.bodyDefaultBold.copyWith(
                            color: theme.colors.labelHighlight,
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
                  '* ${widget.errorText}',
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
