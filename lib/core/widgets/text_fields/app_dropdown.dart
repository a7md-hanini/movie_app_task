import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:flutter/material.dart';

class AppDropdown extends StatelessWidget {
  final List<String> items;
  final void Function(String?)? onChanged;
  final String? value;
  final String? Function(String?)? validator;
  final String? labelText;
  final bool? enabled;
  final InputDecoration? decoration;
  final String? prefixIcon;

  const AppDropdown({
    required this.items,
    required this.onChanged,
    this.value,
    required this.validator,
    required this.labelText,
    this.enabled,
    this.decoration,
    super.key,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: DropdownButtonFormField<String>(
        value: value,
        icon: const Icon(
          Icons.arrow_drop_down,
          size: 25,
          color: AppColors.gray,
        ),
        onChanged: onChanged,
        isExpanded: true,
        validator: validator,
        items: items.map((String item) {
          return DropdownMenuItem<String>(
            value: item,
            enabled: enabled ?? true,
            child: Text(
              item,
              style: const TextStyle(
                color: AppColors.blue1,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          );
        }).toList(),
        dropdownColor: Colors.white,
        decoration: decoration ??
            InputDecoration(
              fillColor: Colors.white,
              filled: true,
              // isDense: true,

              ///----Prefix Icon
              prefixIconConstraints: const BoxConstraints(maxWidth: 50),
              prefixIcon: (prefixIcon != null)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: MyIcon(
                        icon: prefixIcon.toString(),
                      ),
                    )
                  : null,

              ///----Suffix Icon
              suffixIconConstraints: const BoxConstraints(maxWidth: 50),

              ///----Label Text
              labelText: labelText,
              labelStyle: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w500),

              ///----Border
              border: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.lightGray,
                  ),
                  borderRadius: BorderRadius.circular(40)),

              ///----Enabled Border
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.lightGray,
                  ),
                  borderRadius: BorderRadius.circular(40)),

              ///----Focused Border
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.gray,
                  ),
                  borderRadius: BorderRadius.circular(40)),

              ///----Error Border
              errorStyle: const TextStyle(color: AppColors.errorRed),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppColors.errorRed,
                ),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
      ),
    );
  }
}
