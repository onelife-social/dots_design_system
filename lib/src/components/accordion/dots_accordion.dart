import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

/// Accordion component for Dots Design System.
class DotsAccordionSection {
  final String title;
  final Widget content;
  final DotsIconData? leadingIcon;
  final bool expanded;

  DotsAccordionSection({
    required this.title,
    required this.content,
    this.leadingIcon,
    this.expanded = false,
  });
}

class DotsAccordion extends StatefulWidget {
  /// Accordion sections.
  final List<DotsAccordionSection> sections;

  /// If true, only one section can be open at a time.
  final bool singleOpen;

  /// Duration of expand/collapse animation.
  final Duration animationDuration;

  /// Animation curve for expand/collapse.
  final Curve animationCurve;

  const DotsAccordion({
    super.key,
    required this.sections,
    this.singleOpen = true,
    this.animationDuration = const Duration(milliseconds: 180),
    this.animationCurve = Curves.easeInOut,
  });

  @override
  State<DotsAccordion> createState() => _DotsAccordionState();
}

class _DotsAccordionState extends State<DotsAccordion> with TickerProviderStateMixin {
  late List<bool> _expanded;

  @override
  void initState() {
    super.initState();
    _expanded = widget.sections.map((s) => s.expanded).toList();
  }

  @override
  void didUpdateWidget(covariant DotsAccordion oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.sections != widget.sections ||
        oldWidget.sections.length != widget.sections.length) {
      _expanded = widget.sections.map((s) => s.expanded).toList();
    }
  }

  void _toggle(int index) {
    if (mounted) {
      setState(() {
        if (widget.singleOpen) {
          for (int i = 0; i < _expanded.length; i++) {
            _expanded[i] = i == index ? !_expanded[i] : false;
          }
        } else {
          _expanded[index] = !_expanded[index];
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < widget.sections.length; i++) ...[
          Divider(
            height: 3,
            color: theme.colors.labelSecondary.dotsWithOpacity(0.5),
            thickness: 0.2,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _SectionHeader(
              title: widget.sections[i].title,
              leadingIcon: widget.sections[i].leadingIcon,
              isExpanded: _expanded[i],
              duration: widget.animationDuration,
              curve: widget.animationCurve,
              onTap: () => _toggle(i),
            ),
          ),
          AnimatedSize(
            duration: widget.animationDuration,
            curve: widget.animationCurve,
            alignment: Alignment.topCenter,
            clipBehavior: Clip.hardEdge,
            child: _expanded[i]
                ? Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 36),
                    child: widget.sections[i].content,
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ],
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final DotsIconData? leadingIcon;
  final bool isExpanded;
  final Duration duration;
  final Curve curve;
  final VoidCallback onTap;

  const _SectionHeader({
    required this.title,
    required this.leadingIcon,
    required this.isExpanded,
    required this.duration,
    required this.curve,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (leadingIcon != null) ...[
              DotsIcon(iconData: leadingIcon!, size: 20, color: theme.colors.textTertiary),
              const SizedBox(width: 8),
            ],
            Expanded(
              child: Text(
                title,
                style: theme.typo.main.bodyLargeMedium.copyWith(color: theme.colors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            AnimatedRotation(
              turns: isExpanded ? 0.5 : 0.0,
              duration: duration,
              curve: curve,
              child: DotsIcon(
                iconData: DotsIconData.chevronDown,
                size: 16,
                color: theme.colors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
