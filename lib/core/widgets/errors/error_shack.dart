// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'dart:math';

class ErrorShake extends StatefulWidget {
  const ErrorShake({
    super.key,
    required this.child,
    this.shakeOffset = 10,
    this.shakeCount = 3,
    this.shakeDuration = const Duration(milliseconds: 400),
  });

  final Widget child;
  final double shakeOffset;
  final int shakeCount;
  final Duration shakeDuration;

  @override
  ShakeWidgetState createState() => ShakeWidgetState(shakeDuration);
}

class ShakeWidgetState extends AnimationControllerState<ErrorShake> {
  ShakeWidgetState(super.duration);

  @override
  void initState() {
    super.initState();
    animationController.addStatusListener(_updateStatus);
  }

  @override
  void dispose() {
    animationController.removeStatusListener(_updateStatus);
    super.dispose();
  }

  void _updateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reset();
    }
  }

  void shake() {
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    /// 1. return an AnimatedBuilder
    return AnimatedBuilder(
      /// 2. pass our custom animation as an argument
      animation: animationController,

      /// 3. optimization: pass the given child as an argument
      child: widget.child,
      builder: (context, child) {
        final sineValue =
            sin(widget.shakeCount * 2 * pi * animationController.value);
        return Transform.translate(
          /// 4. apply a translation as a function of the animation value
          offset: Offset(sineValue * widget.shakeOffset, 0),

          /// 5. use the child widget
          child: child,
        );
      },
    );
  }
}

abstract class AnimationControllerState<T extends StatefulWidget>
    extends State<T> with SingleTickerProviderStateMixin {
  AnimationControllerState(this.animationDuration);
  final Duration animationDuration;
  late final animationController =
      AnimationController(vsync: this, duration: animationDuration);

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
