import 'package:flutter/material.dart';

Widget auroras() {
  return ShaderMask(
    shaderCallback: (rect) {
    return LinearGradient(
      // ignore: deprecated_member_use
      colors: [Colors.cyan, Colors.greenAccent.withOpacity(0.5)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ).createShader(rect);
  },
  child: Container(
    color: Colors.white,
    width: double.infinity,
    height: 200,
  ),
  );
}
