import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class RadioCardLabelDemoScreen extends StatefulWidget {
  const RadioCardLabelDemoScreen({super.key, required this.variant, this.value});
  final RadioCardLabelVariant variant;
  final String? value;

  @override
  State<RadioCardLabelDemoScreen> createState() => _RadioCardLabelDemoScreenState();
}

class _RadioCardLabelDemoScreenState extends State<RadioCardLabelDemoScreen> {
  int selectedIndex = 0;

  final List<Map<String, String>> options = [
    {'title': 'Opción 1', 'details': 'Detalles de la opción 1'},
    {
      'title': 'Opción 2 con texto algo largo para 2 lineas',
      'details':
          'Detalles de la opción 2, y con el texto largo para que se pase a varias lineas y poder ver como quedan estas varias lineas'
    },
    {'title': 'Opción 3', 'details': 'Detalles de la opción 3'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Demo RadioCardLabel')),
      backgroundColor: context.dotsTheme.colors.bgBase,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: options.length,
        itemBuilder: (context, index) {
          final option = options[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: RadioCardLabel(
                title: option['title']!,
                details: option['details']!,
                isSelected: selectedIndex == index,
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                variant: widget.variant,
                value: widget.value,
              ),
            ),
          );
        },
      ),
    );
  }
}
