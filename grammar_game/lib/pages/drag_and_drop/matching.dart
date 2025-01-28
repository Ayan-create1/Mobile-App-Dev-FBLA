import 'package:flutter/material.dart';
import 'dart:math';
import 'package:grammar_game/pages/home_page/home_page.dart';

class DragAndDropGame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.home),
                color: Colors.black,
                splashRadius: 50.0,
                splashColor: Colors.blue,
                iconSize: 50.0,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                })
          ],
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
    'question': 'Complete the sentence with the correct punctuation: I love the game of basketball_ however, I do not play it myself',
    'answers': [';', '.', ':', 'No change'],
    'correctAnswer': ';'
  },
  {
    'question': 'Complete the sentence with the correct punctuation: Although he is lactose intolerant_ he likes to eat pizza for lunch.',
    'answers': [';', '.', ',', '-'],
    'correctAnswer': ','
  },
  {
    'question': 'Fill in the blank with the correct punctuation: Bats are nocturnal creatures_ they come out only during the night.',
    'answers': [',', '.', ':', ';'],
    'correctAnswer': ';'
  },
  {
    'question': 'Fill in the blank with the correct punctuation: When I turn 16_ I\'m going to buy a car.',
    'answers': ['No change', ';', '-', ','],
    'correctAnswer': ','
  },
  {
    'question': 'Fill in the blanks with the correct punctuation: After college, James had three options: get a job_ apply to graduate school_ or become a criminal.',
    'answers': [',', '-', ':', 'No change'],
    'correctAnswer': ','
  },
  {
    'question': 'Fill in the blanks with the correct punctuation: The homerun ball smashed through_the neighbor\'s window_and rolled into the living room.',
    'answers': [',', '()', ':', '-'],
    'correctAnswer': '-'
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
          children:
              questions[currentQuestionIndex]['answers'].map<Widget>((answer) {
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
    bool isCorrect =
        userAnswer == questions[currentQuestionIndex]['correctAnswer'];
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
