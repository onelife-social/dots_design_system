import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class RadioCardIconsDemoScreen extends StatefulWidget {
  const RadioCardIconsDemoScreen({super.key});

  @override
  State<RadioCardIconsDemoScreen> createState() => _RadioCardIconsDemoScreenState();
}

class _RadioCardIconsDemoScreenState extends State<RadioCardIconsDemoScreen> {
  bool isSelected1 = true, isSelected2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo RadioCardIcons')),
      backgroundColor: context.dotsTheme.colors.bgBase,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => setState(() => isSelected1 = !isSelected1),
              child: RadioCardIcons(
                titleIcon: DotsIconData.gallery,
                title: 'Título',
                detailsIcon1: DotsIconData.star,
                details1:
                    'Detalles 1 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                detailsIcon2: DotsIconData.settings,
                details2: 'Detalles 2',
                variant: RadioCardIconsVariant.toggle,
                isSelected: isSelected1,
                onTap: () {
                  setState(() => isSelected1 = !isSelected1);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Toggle value changed to: $isSelected1')),
                  );
                },
              ),
            ),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () => setState(() => isSelected2 = !isSelected2),
              child: RadioCardIcons(
                titleIcon: null,
                title: 'Título',
                detailsIcon1: DotsIconData.trash,
                details1: 'Detalles 1 ',
                detailsIcon2: null,
                details2: null,
                variant: RadioCardIconsVariant.selector,
                isSelected: isSelected2,
                onTap: () {
                  setState(() => isSelected2 = !isSelected2);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Selector value changed to: $isSelected2')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
