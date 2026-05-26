import 'package:flutter/material.dart';
import 'package:my_portfolio/widgets/Chat_Bubble.dart';
import '../models/message_model.dart';
import '../services/ai_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();

  final List<MessageModel> messages = [];

  bool isTyping = false;

  void sendMessage() async {
    if (controller.text.trim().isEmpty) return;

    String userMessage = controller.text;

    setState(() {
      messages.add(MessageModel(text: userMessage, isUser: true));

      isTyping = true;
    });

    controller.clear();

    await Future.delayed(const Duration(seconds: 1));

    String botReply = AIService.getReply(userMessage);

    setState(() {
      messages.add(MessageModel(text: botReply, isUser: false));

      isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(
                  text: messages[index].text,
                  isUser: messages[index].isUser,
                );
              },
            ),
          ),

          if (isTyping)
            const Padding(
              padding: EdgeInsets.only(left: 16, bottom: 10),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('AI is typing...'),
              ),
            ),

          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Type message...',
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.blue,
                  child: IconButton(
                    onPressed: sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
