import 'package:flutter/material.dart';
import '../../../dots_design_system.dart';

class DotsPlanningItem extends StatefulWidget {

  /// The image to be displayed in the section.
  final ImageProvider sectionImage;
  /// The title of section
  final String mainText;

  /// Icons for the arrow that expands the information (default is chevronDown and chevronUp)
  final DotsIconData? mainIcon;
  final DotsIconData? mainIconActive;

  /// Icon and text for the hour that the event starts
  final DotsIconData? dateTimeIcon; // default is clockOutline
  final String? dateTimeText;
  /// Icon and text for the duration of the event
  final DotsIconData? durationIcon; // default is clockOutline
  final String? durationText;
  /// Icon and text for the location of the event
  final DotsIconData? ubicationIcon; // default is locationPin
  final String? ubicationText;
  /// Icon and text for the description of the event
  final DotsIconData? descriptionIcon; // default is text
  final String? descriptionText;

  const DotsPlanningItem({
    super.key,
    required this.sectionImage,
    required this.mainText,
    this.mainIcon,
    this.mainIconActive,
    this.dateTimeIcon,
    this.dateTimeText,
    this.durationIcon,
    this.durationText,
    this.ubicationIcon,
    this.ubicationText,
    this.descriptionIcon,
    this.descriptionText,
  });

  @override
  State<DotsPlanningItem> createState() => _DotsPlanningItemState();
}

class _DotsPlanningItemState extends State<DotsPlanningItem> with SingleTickerProviderStateMixin {
  bool expanded = false;

  void _toggleExpanded() {
    setState(() {
      expanded = !expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    final mainIcon = widget.mainIcon ?? DotsIconData.chevronDown;
    final mainIconActive = widget.mainIconActive ?? DotsIconData.chevronUp;

    return GestureDetector(
      onTap: _toggleExpanded,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(25),
              borderRadius: DotsBorderRadius.r16,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: DotsBorderRadius.r16,
                  child: SizedBox(
                    width: 52,
                    height: 52,
                    child: Image(
                      image: widget.sectionImage,
                      fit: BoxFit.cover,
                      width: 52,
                      height: 52,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colors.bgBtnImage.withOpacity( 0.6),
                          width: 1,
                        ),
                        borderRadius: DotsBorderRadius.r16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.mainText,
                        style: theme.typo.main.bodyLargeMedium.copyWith(
                          color: theme.colors.textPrimary,
                        ),
                      ),
                    ),
                    DotsIcon(
                      iconData: expanded ? mainIconActive : mainIcon,
                      size: 20,
                      color: theme.colors.textQuarternary,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                DotsPlanningItemRow(
                  icon: widget.dateTimeIcon,
                  text: widget.dateTimeText,
                  defaultIcon: DotsIconData.clockOutline,
                  theme: theme,
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, anim) {
                    final offsetAnim = Tween<Offset>(
                      begin: const Offset(0, -0.1),
                      end: Offset.zero,
                    ).animate(anim);

                    return ClipRect(
                      child: SlideTransition(
                        position: offsetAnim,
                        child: FadeTransition(
                          opacity: anim,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: expanded
                      ? Column(
                          key: const ValueKey("expanded"),
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DotsPlanningItemRow(
                              icon: widget.durationIcon,
                              text: widget.durationText,
                              defaultIcon: DotsIconData.clockTimer,
                              theme: theme,
                            ),
                            DotsPlanningItemRow(
                              icon: widget.ubicationIcon,
                              text: widget.ubicationText,
                              defaultIcon: DotsIconData.locationPin,
                              theme: theme,
                              underline: true,
                            ),
                            DotsPlanningItemRow(
                              icon: widget.descriptionIcon,
                              text: widget.descriptionText,
                              defaultIcon: DotsIconData.text,
                              theme: theme,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(key: ValueKey("collapsed")),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DotsPlanningItemRow extends StatelessWidget {
  final DotsIconData? icon;
  final String? text;
  final DotsIconData defaultIcon;
  final DotsTheme theme;
  final bool underline;

  const DotsPlanningItemRow({
    super.key,
    required this.icon,
    required this.text,
    required this.defaultIcon,
    required this.theme,
    this.underline = false,
  });

  @override
  Widget build(BuildContext context) {
    if (text == null || text?.isEmpty == true) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DotsIcon(
            iconData: icon ?? defaultIcon,
            size: 16,
            color: theme.colors.labelPrimary,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text!,
              style: theme.typo.main.bodyDefaultRegular.copyWith(
                color: theme.colors.textTertiary,
                decoration: underline ? TextDecoration.underline : TextDecoration.none,
                decorationColor: theme.colors.textTertiary,
                decorationThickness: 1.5,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
          ),
        ],
      ),
    );
  }
}