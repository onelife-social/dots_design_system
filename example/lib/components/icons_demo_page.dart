import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class IconsDemoPage extends StatelessWidget {
  const IconsDemoPage({super.key, required this.color, required this.size});

  final Color color;
  final double size;
  @override
  Widget build(BuildContext context) {
    final Map<DotsIconGroup, List<DotsIconData>> groupedIcons = {};

    for (var icon in DotsIconData.values) {
      groupedIcons.putIfAbsent(icon.iconGroup, () => []).add(icon);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Icon Gallery'),
      ),
      body: ListView.builder(
        itemCount: groupedIcons.length,
        itemBuilder: (context, index) {
          final group = groupedIcons.keys.elementAt(index);
          final icons = groupedIcons[group]!;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    group.name.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const SizedBox(height: 8),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: icons.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, i) {
                    final icon = icons[i];
                    return Center(
                      child: DotsIcon(
                        iconData: icon,
                        size: size,
                        color: color,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
