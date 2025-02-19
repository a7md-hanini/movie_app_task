import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_app_bar.dart';
import 'package:movie_app_task/core/widgets/my_background.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class MyImageZoom extends StatelessWidget {
  final List<String> images;
  const MyImageZoom({required this.images, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///--------------///
      ///----AppBar----///
      ///--------------///
      appBar: myAppBar(context, actions: []),

      ///------------///
      ///----Body----///
      ///------------///
      body: images.length == 1

          ///----Single Image
          ? MyBackground(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: SizedBox(
                      height: Sizes.height / 1.5,
                      width: Sizes.width,
                      child: PhotoView(
                        backgroundDecoration:
                            const BoxDecoration(color: AppColors.white),
                        imageProvider: CachedNetworkImageProvider(images[0]),
                      ),
                    ),
                  ),
                ],
              ),
            )

          ///----Multiple Images
          : MyBackground(
              child: Center(
                child: SizedBox(
                  height: Sizes.height / 1.5,
                  width: Sizes.width,
                  child: PhotoViewGallery.builder(
                    scrollPhysics: const BouncingScrollPhysics(),
                    gaplessPlayback: true,
                    backgroundDecoration:
                        const BoxDecoration(color: AppColors.white),
                    itemCount: images.length,
                    builder: (BuildContext context, int imageIndex) {
                      return PhotoViewGalleryPageOptions(
                        controller: PhotoViewController(),
                        imageProvider:
                            CachedNetworkImageProvider(images[imageIndex]),
                        heroAttributes:
                            PhotoViewHeroAttributes(tag: images[imageIndex]),
                      );
                    },
                  ),
                ),
              ),
            ),
    );
  }
}
