import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:grammar_game/consts.dart';

void main() {
  runApp(
    MaterialApp(
      home: ChatPage(),
    ),
  );
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 5,
      ),
    ),
    enableLog: true,
  );
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: 'Ayan', lastName: 'Agarwal');
  final ChatUser _gptUser =
      ChatUser(id: '2', firstName: 'Astro', lastName: 'Galaxia');

  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text(
            'Speak to Astro',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        body: DashChat(
            currentUser: _currentUser,
            messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.lightBlue,
              containerColor: Colors.purple,
              textColor: Colors.white,
            ),
            onSend: (ChatMessage mes) {
              getChatResponse(mes);
            },
            messages: _messages));
  }

  Future<void> getChatResponse(ChatMessage mes) async {
    setState(() {
      _messages.insert(0, mes);
    });
    final List<Map<String, String>> _messagesHistory =
        _messages.reversed.map((mes) {
      return {
        'role': mes.user == _currentUser ? 'user' : 'assistant',
        'content': mes.text,
      };
    }).toList();
    final request = ChatCompleteText(
      model: GptTurboChatModel(),
      messages: _messagesHistory,
      maxToken: 200,
    );
    final response = await _openAI.onChatCompletion(request: request);
    for (var element in response!.choices) {
      if (element.message != null) {
        setState(() {
          _messages.insert(
              0,
              ChatMessage(
                  user: _gptUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content));
        });
      }
    }
  }
}
