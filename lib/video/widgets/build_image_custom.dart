import 'package:flutter/material.dart';

class BuildImageCustom extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final double? radius;
  final BoxFit? fit;
  final bool isNetworkImage;
  final Color? color;
  final Widget? loadingWidget;
  const BuildImageCustom({
    super.key,
    this.fit,
    this.width,
    this.color,
    this.radius,
    this.height,
    this.loadingWidget,
    required this.imageUrl,
    required this.isNetworkImage,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 0.0),
      child: _buildImage(),
    );
  }

  Widget _buildImage() {
    if (isNetworkImage) {
      return Image.network(
        imageUrl,
        width: width ?? 50.0,
        height: height ?? 50.0,
        fit: fit ?? BoxFit.cover,
        color: color,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return loadingWidget ??
              Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
        },
      );
    }
    return Image.asset(
      imageUrl,
      width: width ?? 50.0,
      height: height ?? 50.0,
      fit: fit ?? BoxFit.cover,
      color: color,
    );
  }
}
