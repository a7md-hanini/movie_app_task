import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EnableDisableContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String icon;
  final void Function(bool)? onChanged;

  const EnableDisableContainer({
    required this.title,
    this.subTitle = '',
    required this.icon,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Sizes.width / 1.1,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      decoration: myBoxDecoration(),
      child: Row(
        children: [
          ///----Icon
          MyIcon(
            icon: icon,
            size: 15,
            color: AppColors.blue3,
          ),

          const SizedBox(width: 10),

          ///----Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  text: title,
                  fontWeight: FontWeight.bold,
                ),
                Visibility(
                  visible: subTitle.isNotEmpty,
                  child: MyText(
                    text: subTitle,
                    color: AppColors.gray,
                  ),
                ),
              ],
            ),
          ),

          ///----Switch
          Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: true,
              activeColor: AppColors.primary,
              thumbColor: AppColors.white,
              trackColor: Colors.grey,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}
