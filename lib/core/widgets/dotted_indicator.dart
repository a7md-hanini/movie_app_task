import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class DottedIndicator extends StatelessWidget {
  final int totalDots;
  final int currentIndex;

  const DottedIndicator({
    required this.totalDots,
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalDots, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: currentIndex == index ? 15 : 5,
          height: 5,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? AppColors.tertiary
                : AppColors.lightGray,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
