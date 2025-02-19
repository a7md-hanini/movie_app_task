import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

BoxDecoration myBoxDecoration(
    {Color? color, Color? borderColor, double? radius}) {
  return BoxDecoration(
    color: color ?? AppColors.white,
    borderRadius: BorderRadius.circular(radius ?? 15),
    border: Border.all(color: borderColor ?? AppColors.lightGray),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.05),
        blurRadius: 10,
        offset: const Offset(0, 5),
      ),
    ],
  );
}
