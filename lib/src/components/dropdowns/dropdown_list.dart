import 'package:flutter/widgets.dart';

import '../../../dots_design_system.dart';

enum DropdownListVariant {
  defaultVariant,
  onBackgroundVariant,
  ;

  bool get isDefault => this == DropdownListVariant.defaultVariant;
  bool get isOnBackground => this == DropdownListVariant.onBackgroundVariant;
}

enum DropdownListSize {
  small,
  medium,
  ;

  bool get isSmall => this == DropdownListSize.small;
  bool get isMedium => this == DropdownListSize.medium;
}

class DropdownList extends StatefulWidget {
  /// Visual variant of the dropdown.
  final DropdownListVariant variant;

  /// Size of the dropdown button.
  final DropdownListSize size;

  /// Whether the dropdown is currently active (menu open).
  final bool isActive;

  /// The label to display on the button.
  final String label;

  /// The list of items to show in the dropdown menu.
  final List<DropdownItem> items;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  const DropdownList({
    super.key,
    this.variant = DropdownListVariant.defaultVariant,
    this.size = DropdownListSize.small,
    this.isActive = false,
    required this.label,
    required this.items,
    this.onTap,
  });

  @override
  State<DropdownList> createState() => _DropdownListState();
}

class _DropdownListState extends State<DropdownList> {
  final GlobalKey _buttonKey = GlobalKey();
  double? _buttonWidth;

  @override
  void initState() {
    super.initState();
    _scheduleMeasure();
  }

  @override
  void didUpdateWidget(covariant DropdownList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.label != widget.label ||
        oldWidget.size != widget.size ||
        oldWidget.variant != widget.variant) {
      _scheduleMeasure();
    } else if (widget.isActive && _buttonWidth == null) {
      _scheduleMeasure();
    }
  }

  void _scheduleMeasure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _buttonKey.currentContext;
      if (ctx == null) return;
      final render = ctx.findRenderObject();
      if (render is RenderBox) {
        final w = render.size.width;
        if (mounted && w != _buttonWidth) {
          setState(() => _buttonWidth = w);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final bgColor = widget.isActive
        ? theme.colors.bgFloatingActive
        : widget.variant.isDefault
            ? theme.colors.bgContainerSecondaryOnBackground
            : theme.colors.bgChip;

    final textColor = widget.isActive
        ? theme.colors.textPrimary
        : widget.variant.isDefault
            ? theme.colors.textPrimary
            : theme.colors.labelAlwaysWhite;

    final Widget button = GestureDetector(
      onTap: () {
        widget.onTap?.call();
        _scheduleMeasure();
      },
      child: Container(
        key: _buttonKey,
        padding: EdgeInsets.symmetric(
          vertical: widget.size.isSmall ? 8 : 12,
          horizontal: widget.size.isSmall ? 12 : 16,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: bgColor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: widget.size.isSmall ? 4 : 8,
          children: [
            Text(
              widget.label,
              style: theme.typo.main.bodyLargeMedium.copyWith(color: textColor),
            ),
            DotsIcon(
              iconData: widget.isActive ? DotsIconData.chevronUp : DotsIconData.chevronDown,
              size: 14,
              color: textColor,
            ),
          ],
        ),
      ),
    );

    return widget.isActive
        ? Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 10,
            children: [
              button,
              DropdownMenu(
                items: widget.items,
                width: _buttonWidth,
              ),
            ],
          )
        : button;
  }
}
