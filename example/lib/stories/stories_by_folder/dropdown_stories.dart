import 'package:dots_design_system/dots_design_system.dart';
import 'package:example/components/dropdown_item_demo_page.dart';
import 'package:example/components/dropdown_menu_demo_page.dart';
import 'package:example/stories/helpers/color_knob_options.dart';
import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

List<Story> get dropdownStories => [
      Story(
        name: 'Dropdowns/Dropdown Item',
        description: 'Demo page for Dropdown Item',
        builder: (context) {
          return DropdownItemDemoPage(
            text: context.knobs.text(label: 'Title', initial: 'Dropdown Item'),
            onTap: () {},
            icon: context.knobs.options<DotsIconData>(
              label: 'Item icon',
              initial: DotsIconData.home,
              options:
                  DotsIconData.values.map((item) => Option(label: item.name, value: item)).toList(),
            ),
            itemColor:
                knobColorSelector(context, 'Item Color') ?? context.dotsTheme.colors.textPrimary,
          );
        },
      ),
      Story(
        name: 'Dropdowns/Dropdown Menu',
        description: 'Demo page for Dropdown Menu',
        builder: (context) {
          final itemCount =
              context.knobs.sliderInt(label: 'Item count', initial: 3, min: 1, max: 5);

          final iconOptions = DotsIconData.values.map((item) {
            return Option<DotsIconData>(label: item.name, value: item);
          }).toList();

          final items = List.generate(
            itemCount,
            (index) {
              return DropdownItem(
                text: 'Item ${index + 1}',
                icon: context.knobs.options<DotsIconData>(
                  label: 'Icon for item ${index + 1}',
                  initial: DotsIconData.home,
                  options: iconOptions,
                ),
                onTap: () {},
                itemColor: knobColorSelector(context, 'Item Color') ??
                    context.dotsTheme.colors.textPrimary,
              );
            },
          );

          return DropdownMenuDemoPage(items: items);
        },
      ),
      Story(
        name: 'Dropdowns/Dropdown List',
        description: 'Demo page for Dropdown List',
        builder: (context) {
          bool isActive = false;

          final List<DropdownItem> items = List.generate(
            5,
            (index) => DropdownItem(
              text: 'Label ${index + 1}',
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Pressed: Label ${index + 1}')),
              ),
              minSize: true,
            ),
          );

          return StatefulBuilder(
            builder: (context, setState) {
              return DropdownList(
                variant: context.knobs.options<DropdownListVariant>(
                  label: 'Variant',
                  initial: DropdownListVariant.defaultVariant,
                  options: const [
                    Option(label: 'Default', value: DropdownListVariant.defaultVariant),
                    Option(label: 'On Background', value: DropdownListVariant.onBackgroundVariant),
                  ],
                ),
                size: context.knobs.options<DropdownListSize>(
                  label: 'Size',
                  initial: DropdownListSize.small,
                  options: const [
                    Option(label: 'Small', value: DropdownListSize.small),
                    Option(label: 'Medium', value: DropdownListSize.medium),
                  ],
                ),
                isActive: isActive,
                label: context.knobs.text(label: 'Label', initial: 'Label'),
                items: items,
                onTap: () => setState(() => isActive = !isActive),
              );
            },
          );
        },
      ),
    ];
