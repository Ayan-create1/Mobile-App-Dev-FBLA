// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';

class LightningEffectPage extends StatefulWidget {
  @override
  _LightningEffectPageState createState() => _LightningEffectPageState();
}

class _LightningEffectPageState extends State<LightningEffectPage> {
  bool _isLightning = false;
  double _opacity = 1.0;

  // Start the lightning effect periodically
  void _startLightningEffect() {
    Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        _isLightning = true;
        _opacity = 0.8; // Simulate a lightning flash
      });

      // Stop the lightning effect after 0.2 seconds
      Future.delayed(Duration(milliseconds: 200), () {
        setState(() {
          _isLightning = false;
          _opacity = 1.0; // Reset the opacity after the flash
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _startLightningEffect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Jupiter Stormy Gradient Background
          AnimatedOpacity(
            duration: Duration(milliseconds: 10),
            opacity: _opacity,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.deepOrange.shade900,
                    Colors.brown.shade700,
                    Colors.red.shade800,
                    Colors.deepOrange.shade700,
                  ],
                  stops: [0.1, 0.4, 0.7, 1.0],
                ),
              ),
            ),
          ),

          // Lightning Overlay Effect
          AnimatedOpacity(
            duration: Duration(milliseconds: 200), // Flash lasts for 200ms
            opacity:
                _isLightning ? 0.8 : 0.0, // Flash opacity when lightning occurs
            child: Container(
              color: Colors.white.withOpacity(0.3), // Quick flash effect
            ),
          ),
        ],
      ),
    );
  }
}
