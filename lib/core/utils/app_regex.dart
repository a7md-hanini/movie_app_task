import 'package:flutter/services.dart';

class AppRegex {
  final passwordRegex = RegExp(
      r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#\$&*~])[A-Za-z\d!@#\$&*~]{8,}$');

  static bool isEmailValid(String email) {
    return RegExp(
      r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
    ).hasMatch(email);
  }

  static bool isValidLink(String link) {
    final RegExp linkRegex = RegExp(
      r'^(http|https):\/\/[a-zA-Z0-9\-\.]+\.[a-zA-Z]{2,}(\/\S*)?$',
    );
    return linkRegex.hasMatch(link);
  }

  static bool isPasswordValid(String password) {
    return RegExp(
            r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
        .hasMatch(password);
  }

  static bool hasLowerCase(String password) {
    return RegExp(
      r'^(?=.*[a-z])',
    ).hasMatch(
      password,
    );
  }

  static bool hasUpperCase(String password) {
    return RegExp(
      r'^(?=.*[A-Z])',
    ).hasMatch(
      password,
    );
  }

  static bool hasNumber(String password) {
    return RegExp(
      r'^(?=.*?[0-9])',
    ).hasMatch(
      password,
    );
  }

  static bool hasSpecialCharacter(String password) {
    return RegExp(
      r'^(?=.*?[#?!@$%^&*-])',
    ).hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(
      r'^(?=.{8,})',
    ).hasMatch(password);
  }
}

List<TextInputFormatter>? phoneInputFormatter = [
  FilteringTextInputFormatter.digitsOnly,
];

String formatVisaCardNumber(String cardNumber) {
  if (cardNumber.length < 4) {
    return cardNumber;
  }

  return '${'**** **** **** '}${cardNumber.substring(cardNumber.length - 4)}';
}
