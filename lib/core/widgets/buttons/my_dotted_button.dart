import 'package:dotted_border/dotted_border.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class MyDottedButton extends StatelessWidget {
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
  final int quarterTurns;

  const MyDottedButton({
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
    this.quarterTurns = 0,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: SizedBox(
          width: width,
          height: height ?? Sizes.height / 20,
          child: DottedBorder(
            borderType: BorderType.RRect,
            radius: const Radius.circular(40),
            color: AppColors.primary,
            child: ElevatedButton(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyText(
                    text: title ?? '',
                    color: titleColor ?? AppColors.primary,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold,
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 10),
                    MyIcon(
                      icon: icon.toString(),
                      size: iconSize,
                    ),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
