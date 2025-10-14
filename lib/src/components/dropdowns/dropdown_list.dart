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
  double? _buttonHeight; // <— cache height too

  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _scheduleMeasure();
    if (widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _showOverlay();
      });
    }
  }

  @override
  void didUpdateWidget(covariant DropdownList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.label != widget.label ||
        oldWidget.size != widget.size ||
        oldWidget.variant != widget.variant) {
      _scheduleMeasure();
    }

    if (oldWidget.isActive != widget.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        if (widget.isActive) {
          _showOverlay();
        } else {
          _removeOverlay();
        }
      });
    }
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  void _scheduleMeasure() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = _buttonKey.currentContext;
      if (ctx == null) return;
      final render = ctx.findRenderObject();
      if (render is RenderBox) {
        final w = render.size.width;
        final h = render.size.height;
        final changed = w != _buttonWidth || h != _buttonHeight;
        if (mounted && changed) {
          setState(() {
            _buttonWidth = w;
            _buttonHeight = h;
          });
          _overlayEntry?.markNeedsBuild();
        }
      }
    });
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final buttonHeight = _buttonHeight ?? 0; // <— use cached height
        return Stack(
          children: [
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  widget.onTap?.call();
                },
              ),
            ),
            CompositedTransformFollower(
              link: _layerLink,
              showWhenUnlinked: false,
              offset: Offset(0, buttonHeight + 8),
              child: DropdownMenu(
                items: widget.items,
                width: _buttonWidth,
              ),
            ),
          ],
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _overlayEntry != null) {
        overlay.insert(_overlayEntry!);
      }
    });
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
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

    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: widget.size.isSmall ? 4 : 8,
            children: [
              Text(
                widget.label,
                style: widget.size.isSmall
                    ? theme.typo.main.labelDefaultBold.copyWith(color: textColor)
                    : theme.typo.main.bodyLargeMedium.copyWith(color: textColor),
              ),
              DotsIcon(
                iconData: widget.isActive ? DotsIconData.chevronUp : DotsIconData.chevronDown,
                size: 14,
                color: textColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
