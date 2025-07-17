import 'package:flutter/material.dart';
import 'package:grammar_game/pages/hot_topic/venus_background.dart';

void main() {
  runApp(HotTopicGame());
}

class HotTopicGame extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HotTopicState();
  }
}

class _HotTopicState extends State<HotTopicGame> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Add this wrapper
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "HOT TOPIC",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.deepOrange[900],
        ),
        body: Stack(children: const [
          VenusBackground(),
          SizedBox(height: 20),
        ]),
      ),
    );
  }
}
