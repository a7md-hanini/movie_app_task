import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildValidationRow('At least one lowercase letter', hasLowerCase),
        const SizedBox(height: 5),
        buildValidationRow('At least one uppercase letter', hasUpperCase),
        const SizedBox(height: 5),
        buildValidationRow(
          'At least one special character',
          hasSpecialCharacters,
        ),
        const SizedBox(height: 5),
        buildValidationRow('At least one number', hasNumber),
        const SizedBox(height: 5),
        buildValidationRow('Minimum length of 8 characters', hasMinLength),
        const SizedBox(height: 5),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: hasValidated ? AppColors.primary : Colors.white,
              border: Border.all(color: AppColors.primary, width: 2),
            ),
            child: const Icon(
              Icons.check,
              color: AppColors.white,
              size: 10,
            ),
          ),
          const SizedBox(width: 6),
          MyText(
            text: text,
            color: AppColors.primary,
            fontWeight: FontWeight.w400,
            fontSize: 14,
          )
        ],
      ),
    );
  }
}
