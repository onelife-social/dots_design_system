import 'package:dots_design_system/dots_design_system.dart';
import 'package:flutter/material.dart';

class FeatureItemDemoPage extends StatelessWidget {
  const FeatureItemDemoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 250,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            FeatureItem(
              feature: 'Guests',
              value: '128',
              icon: DotsIconData.family,
            ),
            FeatureItem.image(
              feature: 'Cover',
              value: 'Ready',
              image: Image(
                image: NetworkImage(
                  'https://images.unsplash.com/photo-1519741497674-611481863552?w=64&h=64&fit=crop',
                ),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
