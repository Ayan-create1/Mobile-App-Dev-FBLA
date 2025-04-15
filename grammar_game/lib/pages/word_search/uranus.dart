// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AuroraEffect extends StatefulWidget {
  @override
  _AuroraEffectState createState() => _AuroraEffectState();
}

class _AuroraEffectState extends State<AuroraEffect>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat(reverse: true); // Loop animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          children: [
            // Aurora Background
            Positioned.fill(
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    colors: [
                      Colors.cyan.withOpacity(0.5 + 0.5 * _controller.value),
                      Colors.greenAccent
                          .withOpacity(0.3 + 0.3 * (1 - _controller.value)),
                      Colors.blueAccent
                          .withOpacity(0.2 + 0.2 * _controller.value),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(rect);
                },
                blendMode: BlendMode.srcATop,
                child: Container(color: Colors.black),
              ),
            ),

            // Clouds Layer (Using CustomPainter)
            Positioned.fill(
              child: CustomPaint(
                painter:
                    CloudPainter(_controller.value), // Pass animation value
              ),
            ),
          ],
        );
      },
    );
  }
}

// Cloud Painter Class
class CloudPainter extends CustomPainter {
  final double animationValue;

  CloudPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    Paint cloudPaint = Paint()
      ..color = Colors.white
          .withOpacity(0.2 + 0.2 * (1 - animationValue)) // Opacity Animation
      ..style = PaintingStyle.fill;

    // Cloud Positions (Move them horizontally using animationValue)
    //First Cloud

    double cloudX = size.width * (0.8 * animationValue);
    double cloudY = size.height * 0.67;

    Path cloudPath = Path()
      ..moveTo(cloudX, cloudY)
      ..quadraticBezierTo(cloudX + 50, cloudY - 20, cloudX + 100, cloudY)
      ..quadraticBezierTo(cloudX + 150, cloudY + 20, cloudX + 200, cloudY)
      ..quadraticBezierTo(cloudX + 250, cloudY - 20, cloudX + 300, cloudY)
      ..close();

    canvas.drawPath(cloudPath, cloudPaint);

    double cloudX2 = size.width * (-100 + size.width * animationValue);
    double cloudY2 = size.height * 0.5;

    Path cloudPath2 = Path()
      ..moveTo(cloudX2, cloudY2)
      ..quadraticBezierTo(cloudX2 + 50, cloudY2 - 20, cloudX2 + 100, cloudY2)
      ..quadraticBezierTo(cloudX2 + 150, cloudY + 20, cloudX2 + 200, cloudY2)
      ..quadraticBezierTo(cloudX2 + 250, cloudY2 - 20, cloudX2 + 300, cloudY2)
      ..close();

    canvas.drawPath(cloudPath2, cloudPaint);
  }

  @override
  bool shouldRepaint(CloudPainter oldDelegate) => true;
}
