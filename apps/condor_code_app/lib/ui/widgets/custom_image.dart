import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    super.key,
    required this.firstPar,
    required this.secondPar,
    required this.image,
  });

  final double firstPar;
  final double secondPar;
  final String image;

  @override
  Widget build(BuildContext context) => Positioned(
    right: firstPar,
    top: secondPar,
    child: Image.asset(image, width: 130),
  );
}
