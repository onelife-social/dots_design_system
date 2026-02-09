import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/widgets.dart';

class DotsMediaPreviewPage extends StatelessWidget {
  final Widget image;
  final String label;
  final DotsMediaPreviewVariant variant;

  const DotsMediaPreviewPage({
    super.key,
    required this.image,
    required this.variant,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DotsMediaPreview(
          image: image,
          label: label,
          variant: variant,
          onTap: () {},
          onError: null,
        ),
      ],
    );
  }
}
