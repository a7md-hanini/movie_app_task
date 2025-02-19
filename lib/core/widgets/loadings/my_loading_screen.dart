import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/buttons/my_button.dart';
import 'package:movie_app_task/core/widgets/shapes/hexagon_shape.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

enum MyStatus { loading, error, success }

class MyLoadingScreen extends StatefulWidget {
  final MyStatus status;
  final String? title;
  final String? subTitle;
  final Widget? hexagonalChild;

  const MyLoadingScreen({
    super.key,
    required this.status,
    this.title,
    this.subTitle,
    this.hexagonalChild,
  });

  @override
  State<MyLoadingScreen> createState() => _MyLoadingScreenState();
}

class _MyLoadingScreenState extends State<MyLoadingScreen> {
  late MyStatus _status;
  String? title;
  // String? subTitle;
  Widget? hexagonalChild;

  @override
  void initState() {
    super.initState();
    _status = widget.status;

    title = widget.title ?? title;
    // subTitle = widget.subTitle ?? subTitle;
    hexagonalChild = widget.hexagonalChild ?? hexagonalChild;
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case MyStatus.loading:
        title ??= 'Please wait...';
        // subTitle ??= 'We are gitting things ready for you.';
        hexagonalChild ??= const CircularProgressIndicator();
        break;

      case MyStatus.error:
        title ??= "Error";
        // subTitle ??= 'Something went wrong. Please try again.';
        hexagonalChild ??= const Icon(
          Icons.error,
          color: AppColors.red,
          size: 50,
        );
        break;

      case MyStatus.success:
        title ??= 'Done!';
        // subTitle ??= 'You will be redirected in a few seconds.';
        hexagonalChild ??= const Icon(
          Icons.check_circle,
          color: AppColors.okGreen,
          size: 50,
        );
        break;
    }

    return Container(
      color: AppColors.background.withOpacity(0.7),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HexagonalShape(
            size: 130,
            fillColor: AppColors.white,
            borderColor: AppColors.lightGray,
            borderWidth: 2,
            child: hexagonalChild,
          ),
          const SizedBox(height: 10),
          MyText(
            text: title ?? '',
            type: TextType.headline,
            textAlign: TextAlign.center,
          ),
          // MyText(
          //   // text: subTitle ?? '',
          //   type: TextType.semiMedium,
          //   color: AppColors.gray,
          //   textAlign: TextAlign.center,
          // ),
          if (_status == MyStatus.error) ...[
            SizedBox(height: Sizes.height / 15),
            MyButton(
              color: AppColors.primary,
              titleColor: AppColors.white,
              onPressed: () {
                setState(() {
                  _status = MyStatus.loading;
                });
              },
              title: 'Retry',
            ),
          ],
        ],
      ),
    );
  }
}
