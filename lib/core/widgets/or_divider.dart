import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class OrDivider extends StatelessWidget {
  final double? endIndent;
  final double? indent;
  final double? topPadding;
  final double? bottomPadding;
  final String? text;

  const OrDivider({
    this.endIndent,
    this.indent,
    this.topPadding,
    this.bottomPadding,
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: topPadding),
        Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 1,
                indent: indent,
                color: AppColors.gray,
              ),
            ),
            MyText(
              text: text ?? 'Or',
              padding: const EdgeInsets.symmetric(horizontal: 8),
              color: AppColors.primary,
            ),
            Expanded(
              child: Divider(
                thickness: 1,
                endIndent: endIndent,
                color: AppColors.gray,
              ),
            ),
          ],
        ),
        SizedBox(height: bottomPadding),
      ],
    );
  }
}
