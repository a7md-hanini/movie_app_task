import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class SettingOptionContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final void Function()? onTap;
  final String icon;
  final double? iconSize;
  final bool withDecoration;
  final bool iconDecoration;
  final String trailingIcon;

  const SettingOptionContainer({
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onTap,
    this.withDecoration = true,
    this.iconDecoration = true,
    this.trailingIcon = AppIcons.arrowRight,
    this.iconSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizes.width / 1.1,
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: withDecoration ? myBoxDecoration() : null,
        padding: withDecoration
            ? const EdgeInsets.symmetric(horizontal: 20, vertical: 10)
            : const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            ///------------///
            ///----Icon----///
            ///------------///
            iconDecoration
                ? Container(
                    width: Sizes.width / 9,
                    height: Sizes.width / 9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    child: MyIcon(
                      icon: icon,
                      size: iconSize,
                      color: AppColors.blue3,
                    ),
                  )
                : MyIcon(
                    icon: icon,
                    size: iconSize,
                    color: AppColors.blue3,
                  ),

            const SizedBox(width: 10),

            ///------------------///
            ///----Card Title----///
            ///------------------///
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: title,
                    type: TextType.normal,
                    fontWeight: FontWeight.bold,
                  ),
                  Visibility(
                    visible: subTitle.isNotEmpty,
                    child: MyText(
                      text: subTitle,
                      type: TextType.small,
                      color: AppColors.gray,
                    ),
                  ),
                ],
              ),
            ),

            ///------------------///
            ///----Arrow Icon----///
            ///------------------///
            MyIcon(
              icon: trailingIcon,
              color: AppColors.tertiary,
            ),
          ],
        ),
      ),
    );
  }
}
