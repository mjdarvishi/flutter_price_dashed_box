
import 'dart:ui';
import './dash_line.dart';
import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: DashLinePainter(),
          child:SizedBox(
            width: 200,
            height: 40,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مبلغ',
                    style: context.textTheme.titleLarge,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DashLineView(
                      fillRate: .95,
                      dashColor: Colors.grey[700]!,
                      direction: Axis.vertical,
                    ),
                  ),
                  Text(
                    '200 هزار تومان',
                    style: context.textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DashLinePainter extends CustomPainter {

  DashLinePainter();

  final Paint _paint = Paint()
    ..color = Colors.black
    ..strokeWidth = 1.0
    ..style = PaintingStyle.stroke
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(0,size.height*.3);
    path.quadraticBezierTo(10, size.height/2, 0,size.height*.7);
    path.lineTo(0,size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height*.7);
    path.quadraticBezierTo( size.width-10, size.height/2,size.width,size.height*.3);
    path.lineTo(size.width,0);
    path.lineTo(0, 0.0);

    Path dashPath = Path();

    double dashWidth = 6.0;
    double dashSpace = 3.0;
    double distance = 0.0;
    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, _paint);
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) {
    return true;
  }
}
