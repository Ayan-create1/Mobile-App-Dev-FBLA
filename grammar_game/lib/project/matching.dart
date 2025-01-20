import 'package:flutter/material.dart';
import 'dart:math';

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
  List<Map<String, dynamic>> questions = [
    {
      'question': 'Complete the sentence: The sky is _____.',
      'answers': ['blue', 'green', 'red', 'yellow'],
      'correctAnswer': 'blue'
    },
    {
      'question': 'Complete the sentence: Grass is _____.',
      'answers': ['blue', 'green', 'red', 'yellow'],
      'correctAnswer': 'green'
    },
    {
      'question': 'Complete the sentence: Roses are _____.',
      'answers': ['blue', 'green', 'red', 'yellow'],
      'correctAnswer': 'red'
    },
  ];

  List<Map<String, dynamic>> incorrectQuestions = [];
  int currentQuestionIndex = 0;
  String userAnswer = '';

  @override
  void initState() {
    super.initState();
    questions.shuffle(); // Shuffle the questions to appear in random order
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            questions[currentQuestionIndex]['question'],
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
          children: questions[currentQuestionIndex]['answers'].map<Widget>((answer) {
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
    bool isCorrect = userAnswer == questions[currentQuestionIndex]['correctAnswer'];
    if (!isCorrect) {
      incorrectQuestions.add(questions[currentQuestionIndex]);
    }
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isCorrect ? 'Correct!' : 'Try Again!'),
        content: Text(isCorrect
            ? 'You got the right answer.'
            : 'The correct answer is "${questions[currentQuestionIndex]['correctAnswer']}".'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                if (currentQuestionIndex < questions.length - 1) {
                  currentQuestionIndex++;
                  userAnswer = '';
                } else if (incorrectQuestions.isNotEmpty) {
                  questions = incorrectQuestions;
                  incorrectQuestions = [];
                  currentQuestionIndex = 0;
                  userAnswer = '';
                } else {
                  // All questions answered
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Congratulations!'),
                      content: Text('You have completed all the questions.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              });
            },
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
