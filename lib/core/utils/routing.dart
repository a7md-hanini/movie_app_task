import 'package:flutter/material.dart';

// Navigation extension for help me => context.push/pushReplacement...()
extension Routing on BuildContext {
  //----Push
  Future<dynamic> push(screen) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  ///----PushReplacement
  Future<dynamic> pushReplacement(screen) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  ///----PushAndRemoveUntil
  Future<dynamic> pushAndRemoveUntil(screen) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  ///----Pop
  pop() => Navigator.of(this).pop();
}
