import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../dots_design_system.dart';

enum DropdownListVariant {
  defaultVariant,
  onBackgroundVariant;

  bool get isDefault => this == DropdownListVariant.defaultVariant;
  bool get isOnBackground => this == DropdownListVariant.onBackgroundVariant;
}

enum DropdownListSize {
  small,
  medium;

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

  /// The subtitle to display on the button.
  final String? subtitle;

  /// The list of items to show in the dropdown menu.
  final List<DropdownItem> items;

  /// The max width of the dropdown menu. If null, menu uses button width.
  final double? maxWidthMenu;

  /// Fixed max height for the dropdown menu.
  ///
  /// If null, max height is calculated dynamically based on available space.
  final double? maxMenuHeight;

  /// If true, the button shrinks to fit its content instead of using max width.
  ///
  /// Defaults to `true`.
  final bool minSize;

  /// Callback when the button is tapped.
  final VoidCallback? onTap;

  const DropdownList({
    super.key,
    this.variant = DropdownListVariant.defaultVariant,
    this.size = DropdownListSize.small,
    this.isActive = false,
    required this.label,
    this.subtitle,
    required this.items,
    this.maxWidthMenu,
    this.maxMenuHeight,
    this.minSize = true,
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
        oldWidget.subtitle != widget.subtitle ||
        oldWidget.size != widget.size ||
        oldWidget.variant != widget.variant ||
        oldWidget.maxWidthMenu != widget.maxWidthMenu ||
        oldWidget.maxMenuHeight != widget.maxMenuHeight) {
      _scheduleMeasure();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        _overlayEntry?.markNeedsBuild();
      });
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

  double _calculateMaxMenuHeight(BuildContext context, double gapButtonMenu) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final bottomSafeArea = mediaQuery.viewPadding.bottom;
    double maxMenuHeight = screenHeight;
    final buttonContext = _buttonKey.currentContext;
    if (buttonContext != null) {
      final renderObject = buttonContext.findRenderObject();
      if (renderObject is RenderBox) {
        final buttonTop = renderObject.localToGlobal(Offset.zero).dy;
        final buttonBottom = buttonTop + renderObject.size.height;
        maxMenuHeight = math.max(
          0,
          screenHeight - buttonBottom - gapButtonMenu - bottomSafeArea - 16,
        );
      }
    }
    return maxMenuHeight;
  }

  void _showOverlay() {
    if (_overlayEntry != null) return;
    final overlay = Overlay.of(context);

    _overlayEntry = OverlayEntry(
      builder: (context) {
        const double gapButtonMenu = 8;
        final buttonHeight = _buttonHeight ?? 0;
        final maxMenuHeight =
            widget.maxMenuHeight ?? _calculateMaxMenuHeight(context, gapButtonMenu);

        final menuWidth = (_buttonWidth != null && widget.maxWidthMenu != null)
            ? math.min(_buttonWidth!, widget.maxWidthMenu!)
            : _buttonWidth ?? widget.maxWidthMenu;
        final horizontalOffset = (_buttonWidth != null && menuWidth != null)
            ? (_buttonWidth! - menuWidth) / 2
            : 0.0;
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
              offset: Offset(horizontalOffset, buttonHeight + gapButtonMenu),
              child: DropdownMenu(
                items: widget.items,
                width: menuWidth,
                maxHeight: maxMenuHeight,
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

    final titleColor = widget.isActive
        ? theme.colors.textPrimary
        : widget.variant.isDefault
        ? theme.colors.textPrimary
        : theme.colors.labelAlwaysWhite;
    final subtitleColor = widget.isActive
        ? theme.colors.textTertiary
        : widget.variant.isDefault
        ? theme.colors.textTertiary
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
            mainAxisSize: widget.minSize ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: widget.label,
                        style: theme.typo.main.bodyDefaultRegular.copyWith(color: titleColor),
                      ),
                      if ((widget.subtitle != null && widget.subtitle!.isNotEmpty))
                        TextSpan(
                          text: ' ${widget.subtitle!}',
                          style: theme.typo.main.bodyDefaultRegular.copyWith(color: subtitleColor),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: widget.size.isSmall ? 4 : 8),
              DotsIcon(
                iconData: widget.isActive ? DotsIconData.chevronUp : DotsIconData.chevronDown,
                size: 14,
                color: titleColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
