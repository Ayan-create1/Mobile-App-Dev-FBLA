import 'dart:math';

import 'package:flutter/material.dart';

class VenusBackground extends StatefulWidget {
  const VenusBackground({super.key});

  @override
  State<VenusBackground> createState() => _VenusBackgroundState();
}

class _VenusBackgroundState extends State<VenusBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
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
      builder: (context, _) => CustomPaint(
        painter: VenusPainter(_controller.value),
        child: Container(),
      ),
    );
  }
}

class VenusPainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();

  VenusPainter(this.animationValue);

  @override
  //Here we are painting the background
  void paint(Canvas canvas, Size size) {
    final Paint lavaPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.deepOrange, Colors.red, Colors.black],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw lava base

    canvas.drawRect(
      Rect.fromLTWH(0, size.height * 0, size.width, size.height),
      lavaPaint,
    );

    _drawBubbles(canvas, size);
    _drawSmoke(canvas, size);
  }

  void _drawBubbles(Canvas canvas, Size size) {
    final bubblePaint = Paint()..color = Colors.orangeAccent.withValues(alpha: 0.7);
    for (int i = 0; i < 20; i++) {
      final x = (i * 40) % size.width;
      final offset = sin(animationValue * 2 * pi + i) *
          10; //Controls the value by which each bubble is displaced
      final y = size.height * 0.9 - offset;
      canvas.drawCircle(
          Offset(x.toDouble(), y), 5 + offset.abs() * 0.5, bubblePaint);
    }
  }

  void _drawSmoke(Canvas canvas, Size size) {
    final smokePaint = Paint()..color = Colors.grey.withValues(alpha: 0.1);
    for (int i = 0; i < 15; i++) {
      final x = size.width * 0.5 + sin(animationValue * 2 * pi + i) * 30;
      final y =
          size.height * 0.6 - (animationValue * 200 + i * 10) % size.height;
      canvas.drawCircle(Offset(x, y), 30 - (i * 1.2), smokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant VenusPainter oldDelegate) => true;
}
