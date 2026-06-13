import 'package:condor_code/ui/widgets/utils/enum.dart';
import 'package:condor_code/ui/widgets/youtube_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ui_kit/widgets/condor_code_network_image_view.dart';

class MediaWidget extends StatelessWidget {
  final String url;

  const MediaWidget({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return switch (getContentType(url)) {
      ContentType.jpg => CCNetworkImageView(imageUrl: url),
      ContentType.png => CCNetworkImageView(imageUrl: url),
      ContentType.svg => SvgPicture.network(url),
      ContentType.youtube => YouTubePlayerWidget(youtubeUrl: url),
    };
  }
}

ContentType getContentType(String url) {
  if (url.contains('.jpg') || url.contains('.jpeg')) {
    return ContentType.jpg;
  }

  if (url.contains('.png')) {
    return ContentType.png;
  }

  if (url.contains('.svg')) {
    return ContentType.svg;
  }

  return ContentType.youtube;
}
