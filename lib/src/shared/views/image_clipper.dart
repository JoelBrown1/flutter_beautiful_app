import 'package:flutter/material.dart';

class ClippedImage extends StatelessWidget {
  const ClippedImage(
    this.image, {
    super.key,
    this.fit,
    this.height,
    this.width,
  });

  final String image;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        image,
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
      ),
    );
  }
}
