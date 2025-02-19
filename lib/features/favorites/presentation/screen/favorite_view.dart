import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:movie_app_task/core/widgets/my_app_bar.dart';
import 'package:movie_app_task/features/favorites/presentation/screen/favorites_content.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.darkBlue,

        ///--------------///
        ///----AppBar----///
        ///--------------///
        appBar: myAppBar(context,
            title: 'Favorites Movies', isBack: false, actions: []),

        ///------------///
        ///----Body----///
        ///------------///
        body: const FavoriteContant(),
      ),
    );
  }
}
