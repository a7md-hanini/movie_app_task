import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/widgets/dialogs/my_dialog.dart';
import 'package:movie_app_task/core/widgets/loadings/my_loading_screen.dart';
import 'package:flutter/material.dart';

class MyBackground extends StatelessWidget {
  final Widget child;
  final bool withBackground;
  final bool isLoading;
  final String failureMessage;
  final VoidCallback? onFailureMessageDismissed;

  const MyBackground({
    required this.child,
    this.withBackground = true,
    this.isLoading = false,
    this.failureMessage = '',
    this.onFailureMessageDismissed, // New callback to handle dismissal
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Stack(
          fit: StackFit.expand,
          children: [
            // Background SVG or solid color
            // if (withBackground)
            //   SvgPicture.asset(
            //     AppImages.background,
            //     fit: BoxFit.cover,
            //     height: MediaQuery.of(context).size.height,
            //     width: MediaQuery.of(context).size.width,
            //   )
            // else
            Container(
              color: AppColors.background,
            ),
            // The main content
            Positioned.fill(child: child),

            // Loading indicator
            if (isLoading)
              const MyLoadingScreen(status: MyStatus.loading)
            else if (failureMessage.isNotEmpty)
              MyDialoge(
                message: failureMessage,
                onPressed: onFailureMessageDismissed,
              ),
          ],
        ),
      ),
    );
  }
}
