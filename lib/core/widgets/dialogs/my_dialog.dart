import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

import 'package:movie_app_task/core/themes/app_colors.dart';

class MyDialoge extends StatelessWidget {
  final String message;
  final VoidCallback? onPressed;

  const MyDialoge({
    required this.message,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ignore: prefer_const_constructors
              Icon(
                Icons.error_outline, // Error icon
                color: AppColors.red,
                size: 40,
              ),
              const SizedBox(height: 15),
              MyText(
                text: message,
                type: TextType.small,
                color: AppColors.black,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (onPressed != null) {
                    onPressed!();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
