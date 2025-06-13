import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class MemoryCardDemoPage extends StatelessWidget {
  final DecorationImage image;
  final String groupName;
  final MemoryCardVariant variant;

  const MemoryCardDemoPage({
    super.key,
    required this.image,
    required this.variant,
    required this.groupName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MemoryCard(
          image: image.image,
          groupName: groupName,
          variant: variant,
          onTap: () {},
          onError: null,
        ),
      ],
    );
  }
}
