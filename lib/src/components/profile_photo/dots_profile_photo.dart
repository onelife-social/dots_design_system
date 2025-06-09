import 'package:flutter/material.dart';

class DotsProfilePhoto extends StatelessWidget {

  const DotsProfilePhoto({
    super.key,
    required this.imageUrl,
    this.onTap,
  });

  /// The URL of the image to display.
  ///
  /// This image will be shown inside a circular frame.
  final String imageUrl;
  
  /// Callback when the profile image is tapped.
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
          ),
          shape: const OvalBorder(),
        ),
      ),
    );
  }
}