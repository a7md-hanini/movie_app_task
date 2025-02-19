import 'package:flutter/material.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';

class SearchTextField extends StatelessWidget {
  final String? hintText;
  final void Function(String)? onChanged;
  final TextEditingController searchController;

  const SearchTextField({
    required this.searchController,
    required this.hintText,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
