import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

/// Every slot type the design system ships, in declaration order, so adding a
/// new enum value surfaces in every story below without touching them.
const List<DotsIconItemSlotType> _slotTypes = DotsIconItemSlotType.values;

List<Option<DotsIconItemSlotType>> get _slotTypeOptions => _slotTypes
    .map((type) => Option(label: _slotTypeLabel(type), value: type))
    .toList();

String _slotTypeLabel(DotsIconItemSlotType type) {
  switch (type) {
    case DotsIconItemSlotType.cover:
      return 'Cover';
    case DotsIconItemSlotType.dedicatory:
      return 'Dedicatory';
    case DotsIconItemSlotType.images:
      return 'Images';
    case DotsIconItemSlotType.milestone:
      return 'Milestone';
    case DotsIconItemSlotType.qr:
      return 'QR';
  }
}

String _slotTypeSubtitle(DotsIconItemSlotType type) {
  switch (type) {
    case DotsIconItemSlotType.cover:
      return 'Choose a cover image';
    case DotsIconItemSlotType.dedicatory:
      return 'Write a few words';
    case DotsIconItemSlotType.images:
      return '12 photos selected';
    case DotsIconItemSlotType.milestone:
      return '3 milestones added';
    case DotsIconItemSlotType.qr:
      return 'Share with a QR code';
  }
}

List<Story> get iconStories => [
      Story(
        name: 'Icons/Icon Item',
        description:
            'Playground for a single Icon Item: type, label, optional subtitle and tap handling',
        builder: (context) {
          final type = context.knobs.options(
            label: 'Icon Type',
            initial: DotsIconItemSlotType.cover,
            options: _slotTypeOptions,
          );
          final subtitle = context.knobs.nullable.text(
            label: 'Subtitle',
            initial: _slotTypeSubtitle(type),
            enabled: false,
          );
          final tappable = context.knobs.boolean(
            label: 'Tappable',
            initial: true,
          );

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DotsIconItem(
              type: type,
              label: context.knobs.text(label: 'Label', initial: 'Icon Label'),
              subtitle: subtitle,
              onTap: tappable
                  ? () => ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Icon Item tapped!')),
                      )
                  : null,
            ),
          );
        },
      ),
      Story(
        name: 'Icons/Icon Item - All Types',
        description: 'Every Icon Item type at once, with and without subtitle',
        builder: (context) {
          final withSubtitle = context.knobs.boolean(
            label: 'Show subtitle',
            initial: true,
          );
          final tappable = context.knobs.boolean(
            label: 'Tappable',
            initial: true,
          );

          return _StorySection(
            children: _slotTypes
                .map(
                  (type) => DotsIconItem(
                    type: type,
                    label: _slotTypeLabel(type),
                    subtitle: withSubtitle ? _slotTypeSubtitle(type) : null,
                    onTap: tappable
                        ? () => ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('${_slotTypeLabel(type)} tapped!'),
                              ),
                            )
                        : null,
                  ),
                )
                .toList(),
          );
        },
      ),
      Story(
        name: 'Icons/Icon Item Slot',
        description:
            'Playground for the standalone slot: type plus custom width and height',
        builder: (context) {
          return DotsIconItemSlot(
            type: context.knobs.options(
              label: 'Icon Type',
              initial: DotsIconItemSlotType.cover,
              options: _slotTypeOptions,
            ),
            width: context.knobs.slider(
              label: 'Width',
              initial: 32,
              min: 16,
              max: 160,
            ),
            height: context.knobs.slider(
              label: 'Height',
              initial: 32,
              min: 16,
              max: 160,
            ),
          );
        },
      ),
      Story(
        name: 'Icons/Icon Item Slot - All Types',
        description:
            'Every slot type rendered at a shared size, to compare gradients and glyphs',
        builder: (context) {
          final size = context.knobs.slider(
            label: 'Size',
            initial: 48,
            min: 16,
            max: 120,
          );

          return _StorySection(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                children: _slotTypes
                    .map(
                      (type) => _LabeledSlot(
                        label: _slotTypeLabel(type),
                        child: DotsIconItemSlot(
                          type: type,
                          width: size,
                          height: size,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
      Story(
        name: 'Icons/Icon Item Slot - Sizes',
        description:
            'One slot type across square and non-square sizes, to check radius and glyph scaling',
        builder: (context) {
          final type = context.knobs.options(
            label: 'Icon Type',
            initial: DotsIconItemSlotType.images,
            options: _slotTypeOptions,
          );

          const sizes = <_SlotSize>[
            _SlotSize('16 x 16', 16, 16),
            _SlotSize('24 x 24', 24, 24),
            _SlotSize('32 x 32 (default)', 32, 32),
            _SlotSize('48 x 48', 48, 48),
            _SlotSize('64 x 64', 64, 64),
            _SlotSize('96 x 48 (wide)', 96, 48),
            _SlotSize('48 x 96 (tall)', 48, 96),
          ];

          return _StorySection(
            children: [
              Wrap(
                spacing: 20,
                runSpacing: 20,
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: sizes
                    .map(
                      (size) => _LabeledSlot(
                        label: size.label,
                        child: DotsIconItemSlot(
                          type: type,
                          width: size.width,
                          height: size.height,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          );
        },
      ),
    ];

class _SlotSize {
  final String label;
  final double width;
  final double height;

  const _SlotSize(this.label, this.width, this.height);
}

/// Scrollable, padded shell shared by the gallery stories.
class _StorySection extends StatelessWidget {
  final List<Widget> children;

  const _StorySection({required this.children});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }
}

class _LabeledSlot extends StatelessWidget {
  final String label;
  final Widget child;

  const _LabeledSlot({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = context.dotsTheme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: 8),
        Text(
          label,
          style: theme.typo.main.labelDefaultRegular.copyWith(
            color: theme.colors.textSecondary,
          ),
        ),
      ],
    );
  }
}
