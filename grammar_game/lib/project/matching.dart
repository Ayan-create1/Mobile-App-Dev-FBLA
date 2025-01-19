import 'package:flutter/material.dart';

void main() {
  runApp(DragAndDropGame());
}

class DragAndDropGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Drag and Drop Game'),
        ),
        body: DragAndDropGameScreen(),
      ),
    );
  }
}

class DragAndDropGameScreen extends StatefulWidget {
  @override
  _DragAndDropGameScreenState createState() => _DragAndDropGameScreenState();
}

class _DragAndDropGameScreenState extends State<DragAndDropGameScreen> {
  List<String> questions = ['Complete the sentence: The sky is _____.'];
  List<String> answers = ['blue', 'green', 'red', 'yellow'];
  String correctAnswer = 'blue';
  String userAnswer = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            questions[0],
            style: TextStyle(fontSize: 18),
          ),
        ),
        DragTarget<String>(
          onAccept: (data) {
            setState(() {
              userAnswer = data;
            });
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              height: 50,
              width: 200,
              color: Colors.grey[200],
              child: Center(
                child: Text(
                  userAnswer.isEmpty ? 'Drop answer here' : userAnswer,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            );
          },
        ),
        SizedBox(height: 20),
        Wrap(
          spacing: 10,
          children: answers.map((answer) {
            return Draggable<String>(
              data: answer,
              child: AnswerBox(answer: answer),
              feedback: Material(
                child: AnswerBox(answer: answer, isDragging: true),
              ),
              childWhenDragging: AnswerBox(answer: answer, isDragging: true),
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _checkAnswer,
          child: Text('Check Answer'),
        ),
      ],
    );
  }

  void _checkAnswer() {
    bool isCorrect = userAnswer == correctAnswer;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Try Again!'),
        content: Text(isCorrect
            ? 'You got the right answer.'
            : 'The correct answer is "$correctAnswer".'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class AnswerBox extends StatelessWidget {
  final String answer;
  final bool isDragging;

  AnswerBox({required this.answer, this.isDragging = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 100,
      color: isDragging ? Colors.grey[300] : Colors.blue,
      child: Center(
        child: Text(
          answer,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }
}
