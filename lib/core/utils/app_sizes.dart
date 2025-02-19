import 'dart:io';
import 'responsive.dart';
import 'package:flutter/material.dart';

class Sizes {
  // Static variables to store dimensions
  static double width = 0.0;
  static double height = 0.0;
  static double statusBarHeight = 0.0;

  // Method to initialize sizes (call this once during app startup)
  static void init(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
  }

  static double allSize() {
    return width + height;
  }

  static double navBarHeight() {
    if (Responsive.isMobile()) {
      return Platform.isAndroid ? 70.0 : 80.0;
    } else {
      return Platform.isAndroid ? 90.0 : 100.0;
    }
  }

  static double appBarHeight({bool isBig = false}) {
    if (Responsive.isMobile()) {
      return isBig ? 84.0 : 56.0;
    } else {
      return 112.0;
    }
  }

  static double availableHeight({bool withAppBar = false}) {
    double availableH = height - navBarHeight();
    if (withAppBar) {
      availableH -= appBarHeight();
    }
    return availableH;
  }
}