import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class MyButtonText extends StatelessWidget {
  final void Function()? onPressed;
  final String title;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final TextDecoration? decoration;
  final FontWeight? fontWeight;
  final TextType type;

  const MyButtonText({
    required this.title,
    required this.onPressed,
    this.textColor,
    this.padding,
    this.decoration,
    this.fontWeight,
    this.type = TextType.normal,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(padding: WidgetStatePropertyAll(padding)),
      child: MyText(
        text: title,
        type: type,
        fontWeight: FontWeight.bold,
        decoration: decoration,
        color: textColor ?? AppColors.primary,
      ),
    );
  }
}
