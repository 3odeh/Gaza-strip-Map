import 'package:flutter/material.dart';

class ImageHandle extends StatelessWidget {
  final String path;
  final Color? color;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  const ImageHandle({
    super.key,
    required this.path,
    this.color,
    this.width,
    this.height,
    this.boxFit,
  });

  @override
  Widget build(BuildContext context) {
    return getImage();
  }

  Widget getImage() {
    if (path.toLowerCase().contains('http')) {
      return Image.network(
        path,
        width: width,
        height: height,
        color: color,
        fit: boxFit,
      );
    }

    return Image.asset(
      path,
      width: width,
      height: height,
      color: color,
      fit: boxFit,
    );
  }
}
