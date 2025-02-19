import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/widgets/buttons/my_button.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';

class MyListBottomSheet extends StatefulWidget {
  final List<String> items;
  // final String title;
  final Function(String) onItemSelected;

  const MyListBottomSheet({
    super.key,
    required this.items,
    // required this.title,
    required this.onItemSelected,
  });

  @override
  State<MyListBottomSheet> createState() => _MyListBottomSheetState();
}

class _MyListBottomSheetState extends State<MyListBottomSheet> {
  late TextEditingController searchController;
  late ValueNotifier<List<String>> filteredItems;
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = ValueNotifier(List.from(widget.items));
  }

  void filterItems(String query) {
    filteredItems.value = widget.items
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    filteredItems.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 1.5,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ///--------------------///
          ///----Sheet Handle----///
          ///--------------------///
          const MyIcon(icon: AppIcons.sheetHandle),

          const SizedBox(height: 15),

          ///------------------///
          ///----Items List----///
          ///------------------///
          Expanded(
            child: ValueListenableBuilder<List<String>>(
              valueListenable: filteredItems,
              builder: (context, filteredItemsValue, child) {
                return ListView.builder(
                  itemCount: filteredItemsValue.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              selectedValue = filteredItemsValue[index];
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            decoration: BoxDecoration(
                              color: selectedValue == filteredItemsValue[index]
                                  ? AppColors.primary
                                  : AppColors.background,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: MyText(
                              text: filteredItemsValue[index],
                              type: TextType.medium,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 15),
                              color: selectedValue == filteredItemsValue[index]
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          const SizedBox(height: 20),

          ///--------------------///
          ///----Apply Button----///
          ///--------------------///
          MyButton(
            onPressed: selectedValue != null
                ? () {
                    widget.onItemSelected(selectedValue!);
                    Navigator.of(context).pop();
                  }
                : null,
            color: selectedValue != null ? AppColors.primary : AppColors.gray,
            titleColor: AppColors.white,
            title: 'Apply',
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
