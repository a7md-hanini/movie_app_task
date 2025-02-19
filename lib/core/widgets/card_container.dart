import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final double? width;
  final String cardTypeName;
  final String cardNumber;
  final String cardExpirationDate;
  final void Function()? onTap;
  final bool withCheck;

  const CardContainer({
    this.width,
    required this.cardTypeName,
    required this.cardNumber,
    required this.cardExpirationDate,
    required this.onTap,
    this.withCheck = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: width ?? Sizes.width / 1.2,
            height: Sizes.height / 5,
            decoration: myBoxDecoration(
              color: AppColors.blue2,
            ),
            child: Align(
              alignment: Alignment.centerRight,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: const MyIcon(
                  icon: AppIcons.cardElipse,
                  size: 160,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          SizedBox(
            width: width ?? Sizes.width / 1.2,
            height: Sizes.height / 5,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ///----Card Type Text----///
                      MyText(
                        text: cardTypeName,
                        type: TextType.headline,
                        color: AppColors.white,
                      ),

                      ///----Check Icon----///
                      Visibility(
                        visible: withCheck,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: const MyIcon(
                            padding: EdgeInsets.all(10),
                            icon: AppIcons.check,
                            color: AppColors.tertiary,
                            size: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ///----Card Number----///
                      MyText(
                        text: cardNumber,
                        type: TextType.semiMedium,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      ///----Card Expiration Date----///
                      MyText(
                        text: cardExpirationDate,
                        type: TextType.semiMedium,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
