import 'package:movie_app_task/core/themes/app_colors.dart';
import 'package:movie_app_task/core/utils/app_sizes.dart';
import 'package:movie_app_task/core/widgets/buttons/my_button.dart';
import 'package:movie_app_task/core/widgets/my_background.dart';
import 'package:movie_app_task/core/widgets/shapes/hexagon_shape.dart';
import 'package:movie_app_task/core/widgets/texts/my_text.dart';
import 'package:flutter/material.dart';

enum MyStatus { loading, error, success }

class MyStatusScreen extends StatefulWidget {
  final MyStatus status;
  final String? title;
  final String? subTitle;
  final Widget? hexagonalChild;

  const MyStatusScreen({
    super.key,
    required this.status,
    this.title,
    this.subTitle,
    this.hexagonalChild,
  });

  @override
  State<MyStatusScreen> createState() => _MyStatusScreenState();
}

class _MyStatusScreenState extends State<MyStatusScreen> {
  late MyStatus _status;
  String? title;
  String? subTitle;
  Widget? hexagonalChild;

  @override
  void initState() {
    super.initState();
    _status = widget.status;

    title = widget.title ?? title;
    subTitle = widget.subTitle ?? subTitle;
    hexagonalChild = widget.hexagonalChild ?? hexagonalChild;
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case MyStatus.loading:
        title ??= 'Please wait...';
        subTitle ??= 'We are gitting things ready for you.';
        hexagonalChild ??= const CircularProgressIndicator();
        break;

      case MyStatus.error:
        title ??= "Error";
        subTitle ??= 'Something went wrong. Please try again.';
        hexagonalChild ??= const Icon(
          Icons.error,
          color: Colors.red,
          size: 50,
        );
        break;

      case MyStatus.success:
        title ??= 'Done!';
        subTitle ??= 'You will be redirected in a few seconds.';
        hexagonalChild ??= const Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 50,
        );
        break;
    }

    return Scaffold(
      body: MyBackground(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HexagonalShape(
                size: 130,
                fillColor: AppColors.white,
                borderColor: AppColors.lightGray,
                borderWidth: 2,
                child: hexagonalChild,
              ),
              const SizedBox(height: 10),
              MyText(
                text: title ?? '',
                type: TextType.headline,
                textAlign: TextAlign.center,
              ),
              MyText(
                text: subTitle ?? '',
                type: TextType.semiMedium,
                color: AppColors.gray,
                textAlign: TextAlign.center,
              ),
              if (_status == MyStatus.error) ...[
                SizedBox(height: Sizes.height / 15),
                MyButton(
                  color: AppColors.primary,
                  titleColor: AppColors.white,
                  onPressed: () {
                    setState(() {
                      _status = MyStatus.loading;
                    });
                  },
                  title: 'Retry',
                ),
              ],
            ],
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       if (_status == MyStatus.loading) {
      //         _status = MyStatus.error;
      //       } else if (_status == MyStatus.error) {
      //         _status = MyStatus.success;
      //       } else {
      //         _status = MyStatus.loading;
      //       }
      //     });
      //   },
      //   child: const Icon(Icons.sync),
      // ),
    );
  }
}
// class HexagonalCountdownTimer extends StatefulWidget {
//   final int durationInSeconds;
//   final Color progressColor;
//   final Color backgroundColor;
//   final TextStyle textStyle;
//   final Color hexagonColor;

//   const HexagonalCountdownTimer({
//     required this.durationInSeconds,
//     this.progressColor = Colors.blue,
//     this.backgroundColor = Colors.blueAccent,
//     this.hexagonColor = const Color(0xFFEFEFEF),
//     this.textStyle = const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//     super.key,
//   });

//   @override
//   State<HexagonalCountdownTimer> createState() =>
//       _HexagonalCountdownTimerState();
// }

// class _HexagonalCountdownTimerState extends State<HexagonalCountdownTimer> {
//   late Timer _timer;
//   late double _progress;
//   late int _remainingTime;

//   @override
//   void initState() {
//     super.initState();
//     _remainingTime = widget.durationInSeconds;
//     _progress = 1.0;
//     _startTimer();
//   }

//   void _startTimer() {
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_remainingTime > 0) {
//         setState(() {
//           _remainingTime--;
//           _progress = _remainingTime / widget.durationInSeconds;
//         });
//       } else {
//         timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CustomPaint(
//         painter: HexagonPainter(widget.hexagonColor),
//         child: Container(
//           width: 140,
//           height: 140,
//           alignment: Alignment.center,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox(
//                 width: 100,
//                 height: 100,
//                 child: CircularProgressIndicator(
//                   value: _progress,
//                   strokeWidth: 8,
//                   valueColor: AlwaysStoppedAnimation(widget.progressColor),
//                   backgroundColor: widget.backgroundColor.withOpacity(0.2),
//                 ),
//               ),
//               Text(
//                 _formatTime(_remainingTime),
//                 style: widget.textStyle,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   String _formatTime(int seconds) {
//     final int minutes = seconds ~/ 60;
//     final int remainingSeconds = seconds % 60;
//     return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
//   }
// }

// class HexagonPainter extends CustomPainter {
//   final Color color;

//   HexagonPainter(this.color);

//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint paint = Paint()
//       ..color = color
//       ..style = PaintingStyle.fill;

//     final double width = size.width;
//     final double height = size.height;

//     final Path path = Path();
//     final double hexagonRadius = width / 2;
//     final double angle = (360 / 6) * (3.14 / 180); // 60 degrees in radians

//     for (int i = 0; i < 6; i++) {
//       final double x = width / 2 + hexagonRadius * math.cos(angle * i);
//       final double y = height / 2 + hexagonRadius * math.sin(angle * i);
//       if (i == 0) {
//         path.moveTo(x, y);
//       } else {
//         path.lineTo(x, y);
//       }
//     }
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
