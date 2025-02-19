import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:flutter/material.dart';

class MyButtonIcon extends StatelessWidget {
  final void Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? elevation;
  final String? icon;
  final EdgeInsetsGeometry? padding;
  final double? iconSize;
  final int quarterTurns;

  const MyButtonIcon({
    required this.onPressed,
    this.color,
    this.borderColor,
    this.width,
    this.height,
    this.elevation = 0,
    this.icon,
    this.padding,
    this.iconSize,
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
          width: width ?? Sizes.width / 1.2,
          height: height ?? Sizes.height / 20,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              side: WidgetStateProperty.all(
                BorderSide(color: borderColor ?? Colors.transparent),
              ),
              backgroundColor:
                  WidgetStateProperty.all(color ?? Colors.transparent),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
              elevation: WidgetStateProperty.all(elevation),
            ),
            child: icon == null
                ? const SizedBox.shrink()
                : MyIcon(
                    icon: icon.toString(),
                    size: iconSize,
                  ),
          ),
        ),
      ),
    );
  }
}
