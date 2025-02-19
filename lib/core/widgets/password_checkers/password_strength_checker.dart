import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/responsive.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

enum PasswordStrength { veryWeak, weak, medium, strong, veryStrong }

class PasswordStrengthChecker extends StatefulWidget {
  final PasswordStrength strength;

  const PasswordStrengthChecker({required this.strength, super.key});

  @override
  PasswordStrengthCheckerState createState() => PasswordStrengthCheckerState();
}

class PasswordStrengthCheckerState extends State<PasswordStrengthChecker> {
  Color _getColor(int index) {
    switch (widget.strength) {
      case PasswordStrength.veryWeak:
        return index == 0 ? Colors.red : Colors.grey;
      case PasswordStrength.weak:
        return index <= 1 ? Colors.orange : Colors.grey;
      case PasswordStrength.medium:
        return index <= 2 ? Colors.yellow : Colors.grey;
      case PasswordStrength.strong:
        return index <= 3 ? Colors.lightGreen : Colors.grey;
      case PasswordStrength.veryStrong:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(
            5,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 5,
              width: Responsive.isSmallMobile()
                  ? Sizes.width / 7
                  : Sizes.width / 6,
              decoration: BoxDecoration(
                color: _getColor(index),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            MyText(
              text:
                  'Password Strength: ${widget.strength.toString().split('.').last}',
            ),
          ],
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

///-------------------------------///
///----Check Password Strength----///
///-------------------------------///
PasswordStrength checkPasswordStrength(String password) {
  int score = 0;

  // Check for password length
  if (password.length >= 8) score++;
  if (password.length >= 12) score++;

  // Check for uppercase letters (more than 3)
  int uppercaseCount = RegExp(r'[A-Z]').allMatches(password).length;
  if (uppercaseCount > 0) score++;
  if (uppercaseCount > 3) score++;

  // Check for lowercase letters (more than 3)
  int lowercaseCount = RegExp(r'[a-z]').allMatches(password).length;
  if (lowercaseCount > 0) score++;
  if (lowercaseCount > 3) score++;

  // Check for digits (more than 3)
  int digitCount = RegExp(r'[0-9]').allMatches(password).length;
  if (digitCount > 0) score++;
  if (digitCount > 3) score++;

  // Check for special characters (more than 3)
  int specialCharCount =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]').allMatches(password).length;
  if (specialCharCount > 0) score++;
  if (specialCharCount > 3) score++;

  // Evaluate password strength based on score
  if (score <= 3) {
    return PasswordStrength.veryWeak;
  } else if (score == 4) {
    return PasswordStrength.weak;
  } else if (score == 5) {
    return PasswordStrength.medium;
  } else if (score == 6) {
    return PasswordStrength.strong;
  } else {
    return PasswordStrength.veryStrong;
  }
}
