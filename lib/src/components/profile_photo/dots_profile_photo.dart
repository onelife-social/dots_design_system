import 'package:flutter/material.dart';

class DotsProfilePhoto extends StatelessWidget {

  const DotsProfilePhoto({
    super.key,
    required this.imageProvider,
    this.onTap,
    this.width = 32,
    this.height = 32, 
    this.onError,
  });

  /// The image provider to display (NetworkImage, AssetImage, etc).
  final ImageProvider imageProvider;
  
  /// Callback when the profile image is tapped.
  final Function()? onTap;

  /// Width of the profile photo. Defaults to 32.
  final double width;

  /// Height of the profile photo. Defaults to 32.
  final double height;

  /// Callback for image load error.
  /// Called when the image fails to load.
  final void Function(Object exception, StackTrace? stackTrace)? onError;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            onError: (exception, stackTrace) {
              onError?.call(exception, stackTrace);
            },
          ),
          shape: const OvalBorder(),
        ),
      ),
    );
  }
}