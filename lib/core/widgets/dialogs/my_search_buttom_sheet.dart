import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:movie_app_task/core/widgets/my_image.dart';
import 'package:movie_app_task/core/widgets/text_fields/app_textfield.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';

class MySearchBottomSheet extends StatefulWidget {
  final List<String> items;
  final String title;
  final Function(String) onItemSelected;
  final bool withSearch;
  final List<String?>? imagesList;

  const MySearchBottomSheet({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.withSearch = true,
    this.imagesList,
    super.key,
  });

  @override
  State<MySearchBottomSheet> createState() => _MySearchBottomSheetState();
}

class _MySearchBottomSheetState extends State<MySearchBottomSheet> {
  late TextEditingController searchController;
  late ValueNotifier<List<String>> filteredItems;

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
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///-------------------------///
          ///----Sheet Handle Icon----///
          ///-------------------------///
          const MyIcon(icon: AppIcons.sheetHandle),

          ///------------------///
          ///----Title Text----///
          ///------------------///
          MyText(
            padding: const EdgeInsets.symmetric(vertical: 15),
            text: widget.title,
            color: AppColors.gray,
            type: TextType.semiMedium,
            fontWeight: FontWeight.bold,
          ),

          ///------------------///
          ///----Search Bar----///
          ///------------------///
          Visibility(
            visible: widget.withSearch,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: AppTextfield(
                labelText: 'Search',
                controller: searchController,
                suffixIcon: AppIcons.close,
                prefixIcon: AppIcons.search,
                onChanged: (value) => filterItems(value),
                onFieldSubmitted: (value) {
                  searchController.text = value;
                  filterItems(value);
                },
                onTapSuffix: () {
                  searchController.clear();
                  filterItems('');
                },
              ),
            ),
          ),

          ///------------------///
          ///----Items List----///
          ///------------------///
          ValueListenableBuilder<List<String>>(
            valueListenable: filteredItems,
            builder: (context, filteredItemsValue, child) {
              return Visibility(
                visible: filteredItemsValue.isNotEmpty,
                replacement: Container(
                  decoration: myBoxDecoration(),
                  height: Sizes.height / 3,
                  child: const Center(
                    child: MyText(text: 'No items found'),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: Sizes.height / 3,
                      decoration: myBoxDecoration(),
                      padding: const EdgeInsets.all(10),
                      child: Scrollbar(
                        thumbVisibility: true,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: filteredItemsValue.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                widget.onItemSelected(
                                  filteredItemsValue[index],
                                );

                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  // Check if image exists for the current index
                                  Visibility(
                                    visible: widget.imagesList != null &&
                                        widget.imagesList!.length > index &&
                                        widget.imagesList![index] != null &&
                                        widget.imagesList![index] != '',
                                    replacement: const SizedBox(width: 30),
                                    child: MyImage(
                                      width: 30,
                                      height: 30,
                                      borderRadius: BorderRadius.circular(100),
                                      image: widget.imagesList?[index] ??
                                          '', // Fallback to empty if no image
                                    ),
                                  ),
                                  MyText(
                                    padding: const EdgeInsets.all(8),
                                    text: filteredItemsValue[index],
                                    color: AppColors.gray,
                                    type: TextType.semiMedium,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
