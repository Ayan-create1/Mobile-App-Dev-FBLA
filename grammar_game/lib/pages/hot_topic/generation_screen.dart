import 'package:flutter/material.dart';
import 'package:grammar_game/pages/hot_topic/venus_background.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:grammar_game/consts.dart';

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
  List<String> prompts = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchPrompts();
  }

  Future<void> fetchPrompts() async {
    const apiKey = OPENAI_API_KEY;
    const url = 'https://api.openai.com/v1/chat/completions';

    final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    },
    body: jsonEncode({
      "model": "gpt-4",
      "messages": [
        {
          "role": "user",
          "content": '''
Generate 3 conversation prompts with short 1 sentence descriptions for each.
Format like this:
"Prompt-Description"
Only list them.
'''
        }
      ],
      "temperature": 0.7,
    }),
  );
  if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      final content = decoded['choices'][0]['message']['content'] as String;
      final lines = content.trim().split('\n').where((l) => l.trim().isNotEmpty).toList();

      setState(() {
        prompts = lines;
        loading = false;
      });
    } else {
      setState(() {
        prompts = ['Failed to load prompts.'];
        loading = false;
      });
    }
  }

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
        body: Stack(children: [
          VenusBackground(),
        ]),
      ),
    );
  }
}
