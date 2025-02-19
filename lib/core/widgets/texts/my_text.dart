import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/widgets.dart';

enum TextType {
  normal,
  medium,
  big,
  small,
  semiMedium,
  semiHeadline,
  headline,
  extraBig,
  extraSmall,
}

class MyText extends StatelessWidget {
  final String text;
  final TextType type;
  final double? fontSize;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final TextOverflow? overflow;

  const MyText({
    required this.text,
    this.type = TextType.normal,
    this.fontSize,
    this.color,
    this.padding,
    this.fontWeight,
    this.textAlign,
    this.decoration,
    this.maxLines,
    this.overflow,
    super.key,
  });

  double _getFontSize() {
    switch (type) {
      case TextType.extraSmall:
        return fontSize ?? 8;
      case TextType.small:
        return fontSize ?? 10;
      case TextType.normal:
        return fontSize ?? 12;
      case TextType.semiMedium:
        return fontSize ?? 15;
      case TextType.medium:
        return fontSize ?? 18;
      case TextType.semiHeadline:
        return fontSize ?? 21;
      case TextType.headline:
        return fontSize ?? 24;
      case TextType.big:
        return fontSize ?? 28;
      case TextType.extraBig:
        return fontSize ?? 36;
      default:
        return fontSize ?? 12;
    }
  }

  FontWeight _getFontWeight() {
    switch (type) {
      case TextType.medium:
        return fontWeight ?? FontWeight.w600;
      case TextType.big:
        return fontWeight ?? FontWeight.bold;
      case TextType.extraBig:
        return fontWeight ?? FontWeight.w800;
      case TextType.headline:
        return fontWeight ?? FontWeight.w700;
      case TextType.small:
      case TextType.extraSmall:
      case TextType.normal:
      case TextType.semiMedium:
      case TextType.semiHeadline:
      default:
        return fontWeight ?? FontWeight.normal;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
        style: TextStyle(
          decoration: decoration,
          decorationColor: color ?? AppColors.primary,
          fontSize: _getFontSize(),
          color: color ?? AppColors.primary,
          fontWeight: _getFontWeight(),
        ),
      ),
    );
  }
}
