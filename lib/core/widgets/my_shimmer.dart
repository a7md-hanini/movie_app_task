import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget pictureLoadingObject() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.5),
    highlightColor: Colors.white,
    child: Container(
      color: Colors.grey.withOpacity(0.5),
    ),
  );
}
