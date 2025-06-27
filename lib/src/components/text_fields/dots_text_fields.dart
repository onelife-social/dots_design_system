import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';


class DotsTextFields extends StatefulWidget {

  /// The icon data for the TextField.
  final DotsIconData iconData;

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

  DotsTextFields({
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
  State<DotsTextFields> createState() => _DotsTextFieldsState();
}

class _DotsTextFieldsState extends State<DotsTextFields> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 44,
            clipBehavior: Clip.antiAlias,
            decoration: ShapeDecoration(
              color: theme.colors.bgContainerSecondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(1000),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                DotsIcon(
                  iconData: widget.iconData,
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
                      color: widget.isError ? theme.colors.labelDestructive : theme.colors.textPrimary,
                    ),
                    cursorColor: theme.colors.labelHighlight,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: TextStyle(
                        color: theme.colors.textTertiary,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (value) {
                      setState(() {});
                      if (widget.onChanged != null) widget.onChanged!(value);
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
                      _controller.clear();
                      setState(() {});
                      if (widget.onChanged != null) widget.onChanged!('');
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
      ),
    );
  }
}