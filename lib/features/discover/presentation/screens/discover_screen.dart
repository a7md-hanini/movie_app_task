import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/features/discover/bloc/discover_bloc.dart';
import 'package:movie_app_task/features/discover/presentation/screens/descover_content.dart';
import 'package:movie_app_task/features/discover/repository/discover_repository.dart';

class DiscoverView extends StatelessWidget {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DiscoverBloc(context, repository: DiscoverRepository())

            ///----Load movies on init
            ..add(MoviesStartProcessEvent()),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: const Scaffold(
          backgroundColor: AppColors.darkBlue,
          body: DiscoverContent(),
        ),
      ),
    );
  }
}
