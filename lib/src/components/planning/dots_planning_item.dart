import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

class DotsPlanningItem extends StatefulWidget {
  /// The image to be displayed in the section.
  final ImageProvider sectionImage;

  /// Callback for image load errors.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  /// Main title of the section.
  final String mainText;

  /// Icons for the arrow that expands the information.
  final DotsIconData? mainIcon;
  final DotsIconData? mainIconActive;

  /// Optional main item (always visible).
  final DotsPlanningInfoItem? mainItem;

  /// Items displayed only when expanded.
  final List<DotsPlanningInfoItem> subItems;

  const DotsPlanningItem({
    super.key,
    required this.sectionImage,
    this.onError,
    required this.mainText,
    this.mainIcon,
    this.mainIconActive,
    this.mainItem,
    this.subItems = const [],
  });

  @override
  State<DotsPlanningItem> createState() => _DotsPlanningItemState();
}

class _DotsPlanningItemState extends State<DotsPlanningItem> {
  bool expanded = false;

  void _toggleExpanded() {
    if (!mounted) return;
    setState(() => expanded = !expanded);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final mainIcon = widget.mainIcon ?? DotsIconData.chevronDown;
    final mainIconActive = widget.mainIconActive ?? DotsIconData.chevronUp;

    return GestureDetector(
      onTap: _toggleExpanded,
      child: Container(
        color: Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PlanningImage(
              image: widget.sectionImage,
              onError: widget.onError,
              theme: theme,
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _PlanningTitle(
                    text: widget.mainText,
                    icon: expanded ? mainIconActive : mainIcon,
                    theme: theme,
                  ),
                  const SizedBox(height: 4),
                  if (widget.mainItem != null)
                    DotsPlanningItemRow(
                      item: widget.mainItem!,
                    ),
                  _PlanningAnimatedSwitcher(
                    expanded: expanded,
                    subItems: widget.subItems,
                    theme: theme,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanningImage extends StatelessWidget {
  final ImageProvider image;
  final void Function(Object exception, StackTrace? stackTrace)? onError;
  final DotsTheme theme;

  const _PlanningImage({
    required this.image,
    required this.onError,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return DotsDecoratedBox(
      styleType: context.dotsTheme.styles.squircle16,
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(25),
        border: Border.all(
          color: theme.colors.bgBtnImage.withOpacity(0.6),
          width: 1,
        ),
      ),
      child: Stack(
        children: [
          SizedBox(
            width: 52,
            height: 52,
            child: ClipRRect(
              borderRadius: DotsBorderRadius.r16,
              child: Image(
                image: image,
                fit: BoxFit.cover,
                width: 52,
                height: 52,
                errorBuilder: (context, err, trace) {
                  onError?.call(err, trace);
                  return Image.asset(
                    ImagesPaths.defaultSectionPlanning,
                    fit: BoxFit.cover,
                    width: 52,
                    height: 52,
                  );
                },
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colors.bgBtnImage.withOpacity(0.6),
                    width: 1,
                  ),
                  borderRadius: DotsBorderRadius.r16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlanningTitle extends StatelessWidget {
  final String text;
  final DotsIconData icon;
  final DotsTheme theme;

  const _PlanningTitle({
    required this.text,
    required this.icon,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            text,
            style: theme.typo.main.bodyLargeMedium.copyWith(
              color: theme.colors.textPrimary,
            ),
          ),
        ),
        DotsIcon(
          iconData: icon,
          size: 20,
          color: theme.colors.textQuarternary,
        ),
      ],
    );
  }
}

class _PlanningAnimatedSwitcher extends StatelessWidget {
  final bool expanded;
  final List<DotsPlanningInfoItem> subItems;
  final DotsTheme theme;

  const _PlanningAnimatedSwitcher({
    required this.expanded,
    required this.subItems,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      switchInCurve: Curves.easeOut,
      switchOutCurve: Curves.easeIn,
      transitionBuilder: _animatedTransition,
      child: expanded
          ? Column(
              key: const ValueKey("expanded"),
              children: subItems
                  .map((item) => DotsPlanningItemRow(item: item))
                  .toList(),
            )
          : const SizedBox.shrink(key: ValueKey("collapsed")),
    );
  }

  Widget _animatedTransition(Widget child, Animation<double> anim) {
    return ClipRect(
      child: SlideTransition(
        position: Tween(begin: const Offset(0, -0.1), end: Offset.zero)
            .animate(anim),
        child: FadeTransition(opacity: anim, child: child),
      ),
    );
  }
}