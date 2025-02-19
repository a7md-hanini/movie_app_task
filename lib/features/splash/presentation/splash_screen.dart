import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/utils/images/app_images.dart';
import 'package:movie_app_task/core/widgets/my_background.dart';
import 'package:movie_app_task/core/widgets/my_image.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:movie_app_task/features/app_navigation/app_navigation.dart';
import 'package:movie_app_task/features/splash/bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(StartTimerEvent()),
      child: Scaffold(
        body: BlocListener<SplashBloc, SplashStateAbstract>(
          listener: (context, state) {
            ///----Navigate To Splash
            if (state is SplashNavigate) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const AppNavigation()),
                (route) => false,
              );
            }
          },
          child: BlocBuilder<SplashBloc, SplashStateAbstract>(
            builder: (context, state) {
              int percentage = 0;
              if (state is SplashLoading) {
                percentage = state.timerPercentage;
              }

              return MyBackground(
                withBackground: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),

                      ///----App Logo
                      MyImage(
                        image: AppImages.logo,
                        borderRadius: BorderRadius.circular(100),
                      ),

                      const Spacer(),

                      ///----Loading Indicator
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            backgroundColor: AppColors.tertiary,
                            value: percentage / 100,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary),
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      ///----Percentage
                      MyText(
                        text: '$percentage%',
                        color: AppColors.primary,
                        type: TextType.medium,
                      ),

                      SizedBox(height: Sizes.navBarHeight()),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
