import 'package:flutter/material.dart';
import 'package:movie_app_task/core/apis/api_base.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_image.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';

class TopRatedItem extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String overview;
  final String posterPath;

  const TopRatedItem({
    required this.onTap,
    required this.title,
    required this.overview,
    required this.posterPath,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.black54,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///----Movie Image
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: MyImage(
                width: Sizes.width / 3.5,
                height: Sizes.width / 2.8,
                fit: BoxFit.cover,
                image: Environment.baseImageUrl + posterPath,
              ),
            ),

            ///----Title & Overview
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///----Title
                    MyText(
                      text: title,
                      color: Colors.white,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    ///----Overview
                    MyText(
                      text: overview,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      color: Colors.grey[400]!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
