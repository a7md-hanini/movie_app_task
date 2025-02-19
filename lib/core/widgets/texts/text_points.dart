import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class TextNumbersPoints extends StatelessWidget {
  final String text;
  final String number;
  final EdgeInsetsGeometry? padding;

  const TextNumbersPoints({
    required this.text,
    this.padding,
    required this.number,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Row(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              const Icon(
                Icons.brightness_1,
                color: AppColors.primary,
                size: 28,
              ),
              MyText(
                text: number,
                fontWeight: FontWeight.bold,
                color: AppColors.white,
              )
            ],
          ),
          const SizedBox(width: 10),
          MyText(
            type: TextType.semiMedium,
            text: text,
            textAlign: TextAlign.start,
            color: AppColors.gray,
          ),
        ],
      ),
    );
  }
}
