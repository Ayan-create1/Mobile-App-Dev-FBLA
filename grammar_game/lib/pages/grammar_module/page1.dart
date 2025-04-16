import 'package:flutter/material.dart';

void main() {
  runApp(GrammarModule());
}

class GrammarModule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Module 1: Interactive Grammar'),
          backgroundColor: Colors.redAccent,
        ),
        body: GrammarLesson(),
      ),
    );
  }
}

class GrammarLesson extends StatefulWidget {
  @override
  _GrammarLessonState createState() => _GrammarLessonState();
}

class _GrammarLessonState extends State<GrammarLesson> {
  String subjectFeedback = '', verbFeedback = '', clauseFeedback = '';
  bool showSubjectAnswer = false, showVerbAnswer = false, showClauseAnswer = false;

  final Map<String, dynamic> subjectsData = {
    'sentence': 'The dog ran to the park.',
    'parts': {
      'The dog': {'correct': true, 'explanation': 'Correct! "The dog" is the subject.'},
      'ran': {'correct': false, 'explanation': '"Ran" is the verb.'},
      'to the park': {'correct': false, 'explanation': '"To the park" is a prepositional phrase.'}
    },
  };

  final Map<String, dynamic> verbsData = {
    'sentence': 'The rain fell from the sky.',
    'parts': {
      'The rain': {'correct': false, 'explanation': '"The rain" is the subject.'},
      'fell': {'correct': true, 'explanation': 'Correct! "Fell" is the verb.'},
      'from the sky': {'correct': false, 'explanation': '"From the sky" is a prepositional phrase.'}
    },
  };

  final Map<String, dynamic> clausesData = {
    'sentence': 'Although it was raining, she went for a walk.',
    'parts': {
      'Although it was raining': {'correct': false, 'explanation': '"Although it was raining" is a dependent clause.'},
      'she went for a walk': {'correct': true, 'explanation': 'Correct! "She went for a walk" is an independent clause.'},
      'Although it': {'correct': false, 'explanation': '"Although it" is incomplete.'}
    },
  };

  Widget buildInteractiveSection({
    required String title,
    required String content,
    required Map<String, dynamic> data,
    required String feedback,
    required bool showAnswer,
    required Function(String) onFeedbackUpdate,
    required VoidCallback toggleAnswer,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
      ),
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(content, style: TextStyle(fontSize: 16, color: Colors.white)),
          ),
          Text('Sentence: ${data['sentence']}', style: TextStyle(fontSize: 16, color: Colors.white70)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: data['parts'].keys.map<Widget>((part) {
              return GestureDetector(
                onTap: () => onFeedbackUpdate(data['parts'][part]['explanation']),
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Text(part, style: TextStyle(color: Colors.white)),
                ),
              );
            }).toList(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(feedback, style: TextStyle(color: feedback.contains('Correct') ? Colors.greenAccent : Colors.white)),
          ),
          ElevatedButton(
            onPressed: toggleAnswer,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
            child: Text(showAnswer ? 'Hide Answer Key' : 'Show Answer Key'),
          ),
          if (showAnswer)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: data['parts'].entries.map<Widget>((entry) {
                  return Text('• "${entry.key}" - ${entry.value['explanation']}', style: TextStyle(color: Colors.greenAccent));
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.redAccent, Colors.orangeAccent], begin: Alignment.topCenter, end: Alignment.bottomCenter),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Interactive Grammar Practice',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              SizedBox(height: 16),
              buildInteractiveSection(
                title: 'What is a Subject?',
                content: 'The subject tells who or what the sentence is about.',
                data: subjectsData,
                feedback: subjectFeedback,
                showAnswer: showSubjectAnswer,
                onFeedbackUpdate: (feedback) => setState(() => subjectFeedback = feedback),
                toggleAnswer: () => setState(() => showSubjectAnswer = !showSubjectAnswer),
              ),
              buildInteractiveSection(
                title: 'What is a Verb?',
                content: 'The verb shows action or state of being in the sentence.',
                data: verbsData,
                feedback: verbFeedback,
                showAnswer: showVerbAnswer,
                onFeedbackUpdate: (feedback) => setState(() => verbFeedback = feedback),
                toggleAnswer: () => setState(() => showVerbAnswer = !showVerbAnswer),
              ),
              buildInteractiveSection(
                title: 'Independent vs Dependent Clauses',
                content:
                    'An independent clause can stand alone as a sentence, while a dependent clause cannot.',
                data: clausesData,
                feedback: clauseFeedback,
                showAnswer: showClauseAnswer,
                onFeedbackUpdate: (feedback) => setState(() => clauseFeedback = feedback),
                toggleAnswer: () => setState(() => showClauseAnswer = !showClauseAnswer),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
