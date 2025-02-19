import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/images/app_icons.dart';
import 'package:movie_app_task/core/widgets/my_icon.dart';
import 'package:movie_app_task/core/widgets/my_box_decoration.dart';
import 'package:movie_app_task/core/widgets/my_image.dart';
import 'package:movie_app_task/core/widgets/text_fields/app_textfield.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';

class MySearchBottomSheetWithImage extends StatefulWidget {
  final List<SearchItemModel> items;
  final String title;
  final Function(SearchItemModel) onItemSelected;
  final bool withSearch;

  const MySearchBottomSheetWithImage({
    required this.items,
    required this.title,
    required this.onItemSelected,
    this.withSearch = true,
    super.key,
  });

  @override
  State<MySearchBottomSheetWithImage> createState() =>
      _MySearchBottomSheetWithImageState();
}

class _MySearchBottomSheetWithImageState
    extends State<MySearchBottomSheetWithImage> {
  late TextEditingController searchController;
  late ValueNotifier<List<SearchItemModel>> filteredItems;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    filteredItems = ValueNotifier(List.from(widget.items));
  }

  void filterItems(String query) {
    filteredItems.value = widget.items
        .where((item) => item.title.toLowerCase().contains(query.toLowerCase()))
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
          ValueListenableBuilder<List<SearchItemModel>>(
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
                            final item = filteredItemsValue[index];
                            return InkWell(
                              onTap: () {
                                widget.onItemSelected(item);
                                Navigator.of(context).pop();
                              },
                              child: Row(
                                children: [
                                  Visibility(
                                    visible:
                                        item.image != null && item.image != '',
                                    replacement: const SizedBox(width: 30),
                                    child: MyImage(
                                      width: 30,
                                      height: 30,
                                      borderRadius: BorderRadius.circular(100),
                                      image: item.image ??
                                          '', // Fallback if no image
                                    ),
                                  ),
                                  MyText(
                                    padding: const EdgeInsets.all(8),
                                    text: item.title,
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

class SearchItemModel {
  final String title;
  final String? image;

  SearchItemModel({required this.title, this.image});
}
