import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

void showMyToast(BuildContext context, String message,
    {int durationInSeconds = 5}) {
  // Set a minimum duration of 3 seconds
  final displayDuration = durationInSeconds < 3 ? 3 : durationInSeconds;

  final overlay = Overlay.of(context);
  final overlayEntry = OverlayEntry(
    builder: (context) =>
        MyToastWidget(message: message, durationInSeconds: displayDuration),
  );
  overlay.insert(overlayEntry);

  // Hide the toast after the given display duration
  Future.delayed(Duration(seconds: displayDuration), () {
    overlayEntry.remove();
  });
}

class MyToastWidget extends StatefulWidget {
  final String message;
  final int durationInSeconds;
  final double borderRadius;
  const MyToastWidget({
    super.key,
    this.borderRadius = 15,
    required this.message,
    required this.durationInSeconds,
  });

  @override
  MyToastWidgetState createState() => MyToastWidgetState();
}

class MyToastWidgetState extends State<MyToastWidget> {
  double _topPosition = -80.0; // Initially above the screen

  @override
  void initState() {
    super.initState();
    _showToast();
  }

  void _showToast() {
    // Start animation to move down and then back up
    Future.delayed(const Duration(milliseconds: 100), () {
      setState(() {
        _topPosition = 100.0; // Toast moves down
      });

      // Toast stays for the specified duration before moving up
      Future.delayed(Duration(seconds: widget.durationInSeconds - 2), () {
        setState(() {
          _topPosition = -80.0; // Toast moves up (offscreen)
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      top: _topPosition,
      left: 20.0,
      right: 20.0,
      child: Material(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                AppColors.tertiary,
                AppColors.primary,
                AppColors.primary,
              ],
              stops: [0, 0.51, 0.88],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          child: Text(
            widget.message,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
