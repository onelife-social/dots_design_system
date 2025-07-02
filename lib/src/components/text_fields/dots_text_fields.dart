import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class DotsTextField extends StatefulWidget {
  /// The icon data for the TextField.
  ///
  /// If null, no icon will be displayed.
  final DotsIconData? iconData;

  /// The icon data for the close button.
  final DotsIconData iconDataButton;

  /// The variant of the close button.
  final DotsCloseButtonVariant buttonVariant;

  /// The size of the close button.
  final DotsCloseButtonSize buttonSize;

  /// The hint text to display in the TextField.
  final String hintText;

  /// Callback when the text changes.
  final ValueChanged<String>? onChanged;

  /// Whether the TextField is in an error state.
  final bool isError;

  /// Creates a DotsTextFields widget.
  final String? errorText;

  const DotsTextField({
    super.key,
    this.iconData,
    this.hintText = '',
    this.iconDataButton = DotsIconData.cross,
    this.buttonVariant = DotsCloseButtonVariant.inverted,
    this.buttonSize = DotsCloseButtonSize.extraSmall,
    this.onChanged,
    this.isError = false,
    this.errorText,
  });

  @override
  State<DotsTextField> createState() => _DotsTextFieldState();
}

class _DotsTextFieldState extends State<DotsTextField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    final icon = widget.iconData;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 44,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: theme.colors.bgContainerSecondary,
            shape: RoundedRectangleBorder(
              borderRadius: DotsBorderRadius.r1000,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
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
                  controller: _controller,
                  style: theme.typo.main.bodyDefaultMedium.copyWith(
                    color: widget.isError
                        ? theme.colors.labelDestructive
                        : theme.colors.textPrimary,
                  ),
                  cursorColor: theme.colors.labelHighlight,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: widget.isError
                          ? theme.colors.labelDestructive
                          : theme.colors.textTertiary,
                    ),
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                  onChanged: (value) {
                    if (mounted) setState(() {});
                    widget.onChanged?.call(value);
                  },
                ),
              ),
              if (_controller.text.isNotEmpty) ...[
                const SizedBox(width: 6),
                DotsCloseButton(
                  icon: widget.iconDataButton,
                  variant: widget.buttonVariant,
                  size: widget.buttonSize,
                  onTap: () {
                    if (mounted) {
                      _controller.clear();
                      setState(() {});
                    }
                    widget.onChanged?.call('');
                  },
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
  }
}
