import 'package:cached_network_image/cached_network_image.dart';
import 'package:movie_app_task/core/widgets/my_shimmer.dart';
import 'package:flutter/material.dart';

class MyImage extends StatelessWidget {
  final String? image; // Optional for asset image or network image URL
  final ImageProvider?
      imageProvider; // parameter for ImageProvider (memory, network, etc.)
  final BoxFit? fit;
  final double? width;
  final double? height;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? padding;
  final void Function()? onTap;

  const MyImage({
    this.image,
    this.imageProvider,
    this.fit,
    this.height,
    this.width,
    this.borderRadius,
    this.color,
    this.padding,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: ClipRRect(
            borderRadius: borderRadius ?? BorderRadius.zero,
            child: SizedBox(
              width: width,
              height: height,
              child: image != null
                  ? (image!.startsWith('http') || image!.startsWith('https'))
                      ? CachedNetworkImage(
                          imageUrl: image.toString(),
                          placeholder: (context, url) => pictureLoadingObject(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                          fit: fit,
                        )
                      : Image.asset(
                          image!,
                          fit: fit,
                          color: color,
                        )
                  : imageProvider != null
                      ? Image(
                          image: imageProvider!,
                          fit: fit,
                          color: color,
                        )
                      : const Center(child: Text("No Image")),
            ),
          ),
        ),
      ),
    );
  }
}
