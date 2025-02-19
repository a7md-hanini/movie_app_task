import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcon extends StatelessWidget {
  final String icon;
  final double? size;
  final void Function()? onTap;
  final Color? color;
  final int quarterTurns;
  final String? text;
  final BoxFit fit;
  final FontWeight? fontWeight;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final bool withDecoration;

  const MyIcon({
    this.onTap,
    required this.icon,
    this.size,
    this.fit = BoxFit.contain,
    this.text,
    this.color,
    this.quarterTurns = 0,
    this.fontWeight,
    this.padding,
    this.margin,
    this.withDecoration = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ///------------///
        ///----Icon----///
        ///------------///
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(100),
          child: Container(
            decoration: withDecoration
                ? BoxDecoration(
                    color: AppColors.lightGray,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.lightGray),
                  )
                : null,
            margin: margin ?? EdgeInsets.zero,
            constraints: const BoxConstraints(),
            padding: withDecoration
                ? const EdgeInsets.symmetric(horizontal: 15, vertical: 10)
                : padding ?? EdgeInsets.zero,
            child: RotatedBox(
              quarterTurns: quarterTurns,
              child: icon.toLowerCase().endsWith('.svg')
                  ? SvgPicture.asset(
                      icon,
                      fit: fit,
                      width: size ?? size,
                      height: size ?? size,
                      colorFilter: color == null
                          ? null
                          : ColorFilter.mode(
                              color!,
                              BlendMode.srcIn,
                            ),
                    )
                  : Image.asset(icon, color: color),

              //  IconButton(
              //   padding: EdgeInsets.zero,
              //   constraints: const BoxConstraints(),
              //   iconSize: size,
              //   icon:
              //   onPressed: onTap,
              // ),
            ),
          ),
        ),

        ///------------///
        ///----Text----///
        ///------------///
        text == null
            ? const SizedBox()
            : MyText(
                text: text ?? '',
                color: color ?? AppColors.gray,
                fontWeight: fontWeight,
              ),
      ],
    );
  }
}
