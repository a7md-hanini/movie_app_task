import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/widgets/buttons/my_button.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';

class ItemButtomSheetModel {
  final int id;
  final String? title;
  final String? subTitle;
  final String? suffixText;
  final String? icon;

  final void Function()? onTap;

  ItemButtomSheetModel({
    required this.id,
    required this.title,
    this.subTitle,
    this.suffixText,
    this.icon,
    this.onTap,
  });
}

class ItemButtomSheet extends StatelessWidget {
  final String title;
  final List<ItemButtomSheetModel> itemsList;
  final void Function(ItemButtomSheetModel item)? onItemSelected;

  const ItemButtomSheet({
    required this.title,
    this.onItemSelected,
    required this.itemsList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const MyIcon(icon: AppIcons.sheetHandle),

          const SizedBox(height: 15),

          ///--------------------------///
          ///----Transfer From Text----///
          ///--------------------------///
          MyText(
            text: title,
            fontWeight: FontWeight.bold,
            type: TextType.medium,
          ),

          const SizedBox(height: 15),

          ///--------------------------///
          ///----Payment Types List----///
          ///--------------------------///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: itemsList.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    typesContainer(
                      title: itemsList[index].title!,
                      subTitle: itemsList[index].subTitle,
                      suffixText: itemsList[index].suffixText,
                      icon: itemsList[index].icon,
                      onTap: () {
                        onItemSelected!(itemsList[index]);
                      },
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          Row(
            children: [
              ///---------------------///
              ///----Cancel Button----///
              ///---------------------///
              Expanded(
                child: MyButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: AppColors.white,
                  titleColor: AppColors.primary,
                  borderColor: AppColors.tertiary,
                  title: 'Cancel',
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget typesContainer({
    required String title,
    String? subTitle,
    String? suffixText,
    String? icon,
    final void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Sizes.width / 1.1,
        padding: const EdgeInsets.all(16),
        decoration: myBoxDecoration(),
        child: Row(
          children: [
            // Icon
            icon != null ? MyIcon(icon: icon) : Container(),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  MyText(
                    text: title,
                    type: TextType.semiMedium,
                    fontWeight: FontWeight.bold,
                  ),

                  // Sub Title
                  subTitle != null
                      ? MyText(
                          text: subTitle,
                          type: TextType.small,
                          fontWeight: FontWeight.bold,
                        )
                      : Container(),
                ],
              ),
            ),

            // Suffix Text
            MyText(
              text: suffixText ?? '',
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ),
    );
  }
}
