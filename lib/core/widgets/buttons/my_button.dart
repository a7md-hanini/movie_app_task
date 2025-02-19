import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? title;
  final Color? color;
  final Color? borderColor;
  final Color? titleColor;
  final double? width;
  final double? height;
  final double? elevation;
  final double? fontSize;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final BoxFit fit;
  final BorderRadiusGeometry? borderRadius;

  const MyButton({
    required this.onPressed,
    required this.title,
    this.color,
    this.borderColor,
    this.width,
    this.titleColor,
    this.height,
    this.elevation = 0,
    this.fontSize,
    this.icon,
    this.padding,
    this.iconSize,
    this.fit = BoxFit.contain,
    this.borderRadius,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: SizedBox(
        width: width,
        height: height ?? Sizes.height / 20,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          style: ButtonStyle(
            side: WidgetStatePropertyAll(
              BorderSide(color: borderColor ?? Colors.transparent),
            ),
            backgroundColor:
                WidgetStateProperty.all(color ?? Colors.transparent),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: borderRadius ?? BorderRadius.circular(40),
              ),
            ),
            elevation: WidgetStatePropertyAll(elevation),
          ),
          label: FittedBox(
            fit: fit,
            child: MyText(
              text: title ?? '',
              color: titleColor ?? AppColors.primary,
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: icon == null
              ? null
              : MyIcon(
                  icon: icon.toString(),
                  size: iconSize,
                ),
        ),
      ),
    );
  }
}

// class MyLoadingButton extends StatelessWidget {
//   final Color? color;
//   final double? width;
//   final double? height;
//   final double? elevation;

//   const MyLoadingButton({
//     this.color,
//     this.width = double.infinity,
//     this.height,
//     this.elevation = 0,
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height ?? Sizes.height / 20,
//       child: ElevatedButton(
//         onPressed: null,
//         style: ButtonStyle(
//           side: WidgetStatePropertyAll(
//             BorderSide(
//               color: color ?? AppColors.primary,
//             ),
//           ),
//           backgroundColor: WidgetStateProperty.all(color ?? Colors.transparent),
//           shape: WidgetStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(40),
//             ),
//           ),
//           elevation: WidgetStatePropertyAll(elevation),
//         ),
//         child: const Center(
//           child: CircularProgressIndicator(
//             color: AppColors.white,
//           ),
//         ),
//       ),
//     );
//   }
// }
