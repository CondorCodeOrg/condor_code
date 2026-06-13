import 'package:flutter/material.dart';

class CCNetworkImageView extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget Function(BuildContext, Object, StackTrace?)? errorBuilder;
  final Widget Function(BuildContext, Widget, ImageChunkEvent?)? loadingBuilder;
  final String imageUrl;

  const CCNetworkImageView({
    super.key,
    required this.imageUrl,
    this.fit,
    this.width,
    this.height,
    this.errorBuilder,
    this.loadingBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final corsFixUrl = 'https://proxy.corsfix.com/?';
    return Image.network(
      corsFixUrl + imageUrl,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: errorBuilder,
    );
  }
}
