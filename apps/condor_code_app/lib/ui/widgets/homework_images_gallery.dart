import 'package:flutter/foundation.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:condor_code/ui/widgets/task_full_screen_image.dart';
import 'package:condor_code/ui/widgets/task_image_item.dart';
import 'package:condor_code/ui/widgets/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

const numberOfCardsThatUserCanSee = 3;

class HomeworkImagesGallery extends StatelessWidget {
  const HomeworkImagesGallery({super.key, required this.listImages});

  final List<String> listImages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.15,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final itemWidth =
                constraints.maxWidth / numberOfCardsThatUserCanSee;
            if (listImages.length < numberOfCardsThatUserCanSee) {
              return _CenterImages(
                itemWidth: itemWidth,
                listImages: listImages,
                onImageTap: (int index) =>
                    showFullScreenImages(context, listImages, index),
              );
            }
            return _ImagesList(
              itemWidth: itemWidth,
              listImages: listImages,
              onImageTap: (int index) =>
                  showFullScreenImages(context, listImages, index),
            );
          },
        ),
      ),
    );
  }

  Future<dynamic> showFullScreenImages(
    BuildContext context,
    List<String> listImages,
    int initialIndex,
  ) {
    return showDialog(
      context: context,
      barrierColor: context.colors.scaffoldBackground.withValues(alpha: 0.7),
      barrierDismissible: true,
      builder: (context) {
        return FullScreenImagesDialog(
          listImages: listImages,
          initialIndex: initialIndex,
        );
      },
    );
  }
}

class FullScreenImagesDialog extends StatefulWidget {
  final List<String> listImages;
  final int initialIndex;

  const FullScreenImagesDialog({
    super.key,
    required this.listImages,
    required this.initialIndex,
  });

  @override
  State<FullScreenImagesDialog> createState() => _FullScreenImagesDialogState();
}

class _FullScreenImagesDialogState extends State<FullScreenImagesDialog> {
  late PageController pageController;
  late ValueNotifier<int> currentIndex;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
    currentIndex = ValueNotifier(widget.initialIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final containerWidth = kIsWeb ? width * 0.96 : width * 0.9;
    final containerHeight = kIsWeb ? height * 0.94 : height * 0.7;

    final photoWidth = kIsWeb ? width * 0.74 : width * 0.9;
    final photoHeight = kIsWeb ? height * 0.88 : height * 0.7;

    final horizontalMargin = ((containerWidth - photoWidth) / 2)
        .floorToDouble();

    return Center(
      child: Material(
        color: Colors.transparent,
        child: SizedBox(
          width: containerWidth,
          height: containerHeight,
          child: Stack(
            children: [
              _Photo(
                photoWidth: photoWidth,
                photoHeight: photoHeight,
                currentIndex: currentIndex,
                pageController: pageController,
                listImages: widget.listImages,
              ),
              if (kIsWeb) const _CloseIcon(),
              if (kIsWeb)
                _LeftArrow(
                  horizontalMargin: horizontalMargin,
                  onTap: () {
                    if (pageController.page! > 0) {
                      pageController.previousPage(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              if (kIsWeb)
                _RightArrow(
                  horizontalMargin: horizontalMargin,
                  onTap: () {
                    if (pageController.page! < widget.listImages.length - 1) {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CenterImages extends StatelessWidget {
  const _CenterImages({
    required this.listImages,
    required this.itemWidth,
    required this.onImageTap,
  });

  final List<String> listImages;
  final double itemWidth;
  final Function(int tapIndex) onImageTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: listImages.asMap().entries.map((entry) {
        final index = entry.key;
        final url = entry.value;
        return SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: itemWidth,
          child: TaskImageItem(
            imageUrl: url,
            onTap: () {
              onImageTap(index);
            },
            imageType: _getImageType(url),
          ),
        );
      }).toList(),
    );
  }
}

class _ImagesList extends StatelessWidget {
  const _ImagesList({
    required this.listImages,
    required this.itemWidth,
    required this.onImageTap,
  });

  final List<String> listImages;
  final double itemWidth;
  final Function(int tapIndex) onImageTap;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) => SizedBox(
        width: itemWidth,
        child: TaskImageItem(
          imageUrl: listImages[index],
          onTap: () {
            onImageTap(index);
          },
          imageType: _getImageType(listImages[index]),
        ),
      ),
      itemCount: listImages.length,
    );
  }
}

class _RightArrow extends StatelessWidget {
  const _RightArrow({required this.horizontalMargin, required this.onTap});

  final double horizontalMargin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: horizontalMargin - 52,
      top: 0,
      bottom: 0,
      child: Center(child: _GalleryArrowButton(onTap: onTap, isLeft: false)),
    );
  }
}

class _LeftArrow extends StatelessWidget {
  const _LeftArrow({required this.horizontalMargin, required this.onTap});

  final double horizontalMargin;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: horizontalMargin - 52,
      top: 0,
      bottom: 0,
      child: Center(child: _GalleryArrowButton(onTap: onTap, isLeft: true)),
    );
  }
}

class _CloseIcon extends StatelessWidget {
  const _CloseIcon();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      right: 56,
      child: IconButton(
        icon: Icon(Icons.close, color: context.colors.textPrimary, size: 50),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class _Photo extends StatelessWidget {
  const _Photo({
    required this.photoWidth,
    required this.photoHeight,
    required this.currentIndex,
    required this.pageController,
    required this.listImages,
  });

  final double photoWidth;
  final double photoHeight;
  final ValueNotifier<int> currentIndex;
  final PageController pageController;
  final List<String> listImages;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: photoWidth,
        height: photoHeight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ValueListenableBuilder<int>(
                valueListenable: currentIndex,
                builder: (context, value, _) {
                  return Text(
                    '${value + 1} / ${listImages.length}',
                    style: AppTextStyles.h1,
                  );
                },
              ),
            ),
            Expanded(
              child: PhotoViewGallery.builder(
                pageController: pageController,
                backgroundDecoration: const BoxDecoration(),
                itemCount: listImages.length,
                onPageChanged: (index) {
                  currentIndex.value = index;
                },
                builder: (BuildContext context, int index) {
                  final imageUrl = listImages[index];
                  return PhotoViewGalleryPageOptions.customChild(
                    child: kIsWeb
                        ? _WebPhoto(imageUrl: imageUrl)
                        : _MobilePhoto(imageUrl: imageUrl),
                    disableGestures: false,
                    initialScale: PhotoViewComputedScale.contained,
                    minScale: PhotoViewComputedScale.contained,
                    maxScale: PhotoViewComputedScale.contained * 4,
                    scaleStateCycle: (actual) => actual,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MobilePhoto extends StatelessWidget {
  const _MobilePhoto({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 1),
        color: context.colors.scaffoldBackground,
      ),
      child: TaskFullScreenImage(
        imageUrl: imageUrl,
        imageType: _getImageType(imageUrl),
      ),
    );
  }
}

class _WebPhoto extends StatelessWidget {
  const _WebPhoto({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.colors.border, width: 1),
        color: context.colors.scaffoldBackground,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: InteractiveViewer(
          minScale: 1,
          maxScale: 4,
          trackpadScrollCausesScale: true,
          child: TaskFullScreenImage(
            imageUrl: imageUrl,
            imageType: _getImageType(imageUrl),
          ),
        ),
      ),
    );
  }
}

class _GalleryArrowButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isLeft;

  const _GalleryArrowButton({required this.onTap, required this.isLeft});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 140,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Center(
            child: Icon(
              isLeft ? Icons.arrow_back_ios_new : Icons.arrow_forward_ios,
              color: context.colors.textPrimary,
              size: 36,
            ),
          ),
        ),
      ),
    );
  }
}

ImageType _getImageType(String url) {
  if (url.contains('.jpg') || url.contains('.jpeg')) {
    return ImageType.jpg;
  }

  if (url.contains('.png')) {
    return ImageType.png;
  }

  if (url.contains('.svg')) {
    return ImageType.svg;
  }

  return ImageType.incorrectUrl;
}
