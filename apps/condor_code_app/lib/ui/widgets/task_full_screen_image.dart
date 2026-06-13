import 'package:condor_code/ui/widgets/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';

class TaskFullScreenImage extends StatelessWidget {
  final String imageUrl;
  final ImageType imageType;

  const TaskFullScreenImage({
    super.key,
    required this.imageUrl,
    required this.imageType,
  });

  @override
  Widget build(BuildContext context) => switch (imageType) {
    ImageType.jpg => CCNetworkImageView(imageUrl: imageUrl),
    ImageType.png => CCNetworkImageView(imageUrl: imageUrl),
    ImageType.svg => SvgPicture.network(imageUrl),
    ImageType.incorrectUrl => SvgPicture.network(
      'https://upload.wikimedia.org/wikipedia/commons/7/79/Flutter_logo.svg',
    ),
  };
}
