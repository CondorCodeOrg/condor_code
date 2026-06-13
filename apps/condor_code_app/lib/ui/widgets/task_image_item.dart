import 'package:condor_code/ui/widgets/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';
import 'package:flutter_svg/svg.dart';

class TaskImageItem extends StatelessWidget {
  final ImageType imageType;
  final String imageUrl;
  final VoidCallback onTap;

  const TaskImageItem({
    super.key,
    required this.imageUrl,
    required this.onTap,
    required this.imageType,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(6),
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey400, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: switch (imageType) {
          ImageType.jpg => CCNetworkImageView(imageUrl: imageUrl),
          ImageType.png => CCNetworkImageView(imageUrl: imageUrl),
          ImageType.svg => SvgPicture.network(imageUrl),
          ImageType.incorrectUrl => SvgPicture.network(
            'https://upload.wikimedia.org/wikipedia/commons/7/79/Flutter_logo.svg',
          ),
        },
      ),
    ),
  );
}
