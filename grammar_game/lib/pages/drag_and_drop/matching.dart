import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:grammar_game/pages/home_page/home_page.dart';
import 'jupiter.dart';
import '../word_search/pop_up.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/rendering.dart';

bool popup = true;

class DragAndDropGame extends StatefulWidget {
  @override
  _DragAndDropGameState createState() => _DragAndDropGameState();
}

class _DragAndDropGameState extends State<DragAndDropGame> {
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (popup) {
      // Schedule the iWordSPopup method to run after the build phase
      WidgetsBinding.instance.addPostFrameCallback((_) {
        iDragDPopup(context);
        popup = false;
      });
    }
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.blueAccent,
        //Will show title of screen and center that title
        centerTitle: true,
        title: Text(
          "GRAVITY DROP",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.orange[900],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.orange[300], // You can customize the color here
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the button, adjust if needed
          children: [
            IconButton(
              icon: Icon(Icons.info),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                iDragDPopup(context);
              },
            ),
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(), // Your HomePage widget
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.share),
              color: Colors.white,
              splashRadius: 50.0,
              splashColor: Colors.black,
              iconSize: 50.0,
              onPressed: () {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _captureAndShare(_screenshotKey);
                });
              },
            ),
          ],
        ),
      ),
      body: ScreenshotArea(
        screenshotKey: _screenshotKey,
        child: Center(
          child: Stack(
            children: [
              Positioned.fill(
                child: LightningEffectPage(),
              ),
              Center(
                child: DragAndDropGameScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _captureAndShare(GlobalKey boundaryKey) async {
    try {
      if (_screenshotKey.currentContext == null) {
        print("Current context is null. The widget might not be built yet.");
        return;
      }

      final RenderRepaintBoundary boundary = _screenshotKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;

      if (boundary.debugNeedsPaint) {
        await Future.delayed(Duration(milliseconds: 20));
      }

      //Captures the image
      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;
      final Uint8List pngBytes = byteData.buffer.asUint8List();

      //Saves Image to temporary file
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/screenshot.png').create();
      await file.writeAsBytes(pngBytes);

      //Shares image with shareplus
      await Share.shareXFiles([XFile(file.path)],
          text: 'Help me on this drag and drop!');
    } catch (e) {
      print("Error capturing and sharing screenshot: $e");
    }
  }
}

class ScreenshotArea extends StatelessWidget {
  final Widget child;
  final GlobalKey screenshotKey;

  const ScreenshotArea(
      {Key? key, required this.child, required this.screenshotKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: screenshotKey, // Use the correct GlobalKey here
      child: child,
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
      'question':
          'Complete the sentence with the correct punctuation:\n\nI love the game of basketball ____ however, I do not play it myself',
      'answers': [';', '.', ':', 'No change'],
      'correctAnswer': ';'
    },
    {
      'question':
          'Complete the sentence with the correct punctuation:\n\nAlthough he is lactose intolerant ____ he likes to eat pizza for lunch.',
      'answers': [';', '.', ',', '-'],
      'correctAnswer': ','
    },
    {
      'question':
          'Fill in the blank with the correct punctuation:\n\nBats are nocturnal creatures ____ they come out only during the night.',
      'answers': [',', '.', ':', ';'],
      'correctAnswer': ';'
    },
    {
      'question':
          'Fill in the blank with the correct punctuation:\n\nWhen I turn 16 ____ I\'m going to buy a car.',
      'answers': ['No change', ';', '-', ','],
      'correctAnswer': ','
    },
    {
      'question':
          'Fill in the blanks with the correct punctuation:\n\nAfter college, James had three options: get a job ____ apply to graduate school ____ or become a criminal.',
      'answers': [',', '-', ':', 'No change'],
      'correctAnswer': ','
    },
    {
      'question':
          'Fill in the blanks with the correct punctuation:\n\nThe homerun ball smashed through ____the neighbor\'s window and rolled into the living room.',
      'answers': [',', '()', ':', 'No change'],
      'correctAnswer': 'No change'
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
        Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {}, // Do nothing when pressed
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow[900],
                shadowColor: Colors.black, // Remove shadow
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Optional: rounded corners
                ),
                padding: EdgeInsets.all(16), // Padding inside the button
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  textAlign: TextAlign.center,
                  questions[currentQuestionIndex]['question'],
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
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
                  style: TextStyle(fontSize: 20, color: Colors.grey),
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
          child: Text(
            'CHECK ANSWER',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
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
      width: 150,
      margin: EdgeInsets.all(10.0),
      color: isDragging ? Colors.grey[300] : Colors.yellow[300],
      child: Center(
        child: Text(
          answer,
          style: TextStyle(fontSize: 30, color: Colors.black),
        ),
      ),
    );
  }
}
