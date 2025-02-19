import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class HexagonalShape extends StatelessWidget {
  final double size;
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;
  final Widget? child;

  const HexagonalShape({
    this.size = 100,
    this.fillColor = const Color(0xFFF7FAFF),
    this.borderColor = const Color(0xFFB0BEC5),
    this.borderWidth = 2.0,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            CustomPaint(
              size: Size(size, size),
              painter: HexagonPainter(
                fillColor: fillColor,
                borderColor: borderColor,
                borderWidth: borderWidth,
              ),
            ),
            // if (child != null)
            //   RotatedBox(quarterTurns: 3, child: child!)
            // else
            const CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color fillColor;
  final Color borderColor;
  final double borderWidth;

  HexagonPainter({
    required this.fillColor,
    required this.borderColor,
    required this.borderWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final Paint borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final Path hexagonPath = _createHexagonPath(size);

    // Draw filled hexagon
    canvas.drawPath(hexagonPath, fillPaint);

    // Draw hexagon border
    canvas.drawPath(hexagonPath, borderPaint);
  }

  Path _createHexagonPath(Size size) {
    final double width = size.width;
    final double height = size.height;

    final double hexagonRadius = width / 2;
    const double angle = (360 / 6) * (3.14 / 180); // 60 degrees in radians
    final Path path = Path();

    for (int i = 0; i < 6; i++) {
      final double x = width / 2 + hexagonRadius * math.cos(angle * i);
      final double y = height / 2 + hexagonRadius * math.sin(angle * i);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
