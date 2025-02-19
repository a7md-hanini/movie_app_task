import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/features/discover/presentation/screens/discover_screen.dart';
import 'package:movie_app_task/features/favorites/bloc/favorite_bloc.dart';
import 'package:movie_app_task/features/favorites/presentation/screen/favorite_view.dart';
import 'package:movie_app_task/features/top_rated/presentation/screens/top_rated_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  int _selectedIndex = 1;

  static final List<Widget> _pages = [
    const FavoriteView(),
    const DiscoverView(),
    const TopRatedView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///------------///
      ///----Body----///
      ///------------///
      body: PageTransitionSwitcher(
        transitionBuilder: (child, animation, secondaryAnimation) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: _pages[_selectedIndex],
      ),

      ///----------------------///
      ///----Bottom Nav Bar----///
      ///----------------------///
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(0.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: GNav(
              gap: 8,
              activeColor: AppColors.primary,
              backgroundColor: AppColors.background,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 300),
              tabBackgroundColor: AppColors.tertiary.withOpacity(0.1),
              selectedIndex: _selectedIndex,
              iconSize: 24,
              onTabChange: (index) {
                if (index == 0) {
                  context.read<FavoriteBloc>().add(GetFavoriteEvent());
                }
                setState(() {
                  _selectedIndex = index;
                });
              },

              ///------------///
              ///----Tabs----///
              ///------------///
              tabs: const [
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorites',
                  iconColor: AppColors.gray,
                  iconActiveColor: AppColors.primary,
                ),
                GButton(
                  icon: Icons.home,
                  text: 'Discover',
                  iconColor: AppColors.gray,
                  iconActiveColor: AppColors.primary,
                ),
                GButton(
                  icon: Icons.star_border,
                  text: 'Top Rated',
                  iconColor: AppColors.gray,
                  iconActiveColor: AppColors.primary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
