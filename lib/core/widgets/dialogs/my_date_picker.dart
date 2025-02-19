import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

Future<void> myDatePicker(
  BuildContext context,
  TextEditingController dateCrl, {
  DateTime? initDate,
  int yearsBefore = 100,
  int yearsAfter = 100,
}) async {
  initDate ??= DateTime.now();

  final firstDate =
      DateTime(initDate.year - yearsBefore, initDate.month, initDate.day);

  final lastDate =
      DateTime(initDate.year + yearsAfter, initDate.month, initDate.day);

  final date = await showDatePicker(
    context: context,
    cancelText: 'Cancel',
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          primaryColor: AppColors.primary,
        ),
        child: child!,
      );
    },
    initialDate: initDate,
    firstDate: firstDate,
    lastDate: lastDate,
  );

  if (date != null) {
    dateCrl.text = date.toString().split(' ')[0];
  }
}
