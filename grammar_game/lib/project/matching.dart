import 'package:flutter/material.dart';
import 'package:petitparser/petitparser.dart';

class MatchingGame extends StatefulWidget {
  @override
  _MatchingGameState createState() => _MatchingGameState();
}

class _MatchingGameState extends State<MatchingGame> {
  List<String> words = ['apple', 'banana', 'cherry'];
  String selectedWord = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        DragTarget<String>(
          onAccept: (data) {
            setState(() {
              selectedWord = data;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 200,
              height: 50,
              color: Colors.grey[200],
              child: Center(child: Text(selectedWord.isEmpty ? 'Drop here' : selectedWord)),
            );
          },
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: words.map((word) {
            return Draggable<String>(
              data: word,
              child: Container(
                width: 100,
                height: 50,
                color: Colors.blue,
                child: Center(child: Text(word)),
              ),
              feedback: Container(
                width: 100,
                height: 50,
                color: Colors.blue.withOpacity(0.5),
                child: Center(child: Text(word)),
              ),
              childWhenDragging: Container(
                width: 100,
                height: 50,
                color: Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}


