import 'package:flutter/material.dart';
import '../widgets/chat_input_widget.dart';
import '../core/styles/colors.dart';
import '../core/styles/radius.dart';

class ChatInputDemo extends StatefulWidget {
  const ChatInputDemo({Key? key}) : super(key: key);

  @override
  State<ChatInputDemo> createState() => _ChatInputDemoState();
}

class _ChatInputDemoState extends State<ChatInputDemo> {
  final List<ChatMessage> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _addMessage(String text) {
    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isSent: true,
        timestamp: DateTime.now(),
      ));
    });

    // Scroll to bottom after message is added
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: _messages.isEmpty
                ? const Center(
                    child: Text(
                      'Start the conversation',
                      style: TextStyle(color: AppColors.gray400),
                    ),
                  )
                : ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16.0),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageItem(_messages[index]);
                    },
                  ),
          ),

          // Chat input widget
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ChatInputWidget(
              onSendMessage: (message) {
                _addMessage(message);
              },
              onAttachmentTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Attachment tapped')),
                );
              },
              onNewRoomTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New Room tapped')),
                );
              },
              onMicTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Mic tapped')),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageItem(ChatMessage message) {
    return Align(
      alignment: message.isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: message.isSent ? AppColors.primary : AppColors.gray200,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16.0),
            topRight: const Radius.circular(16.0),
            bottomLeft: message.isSent
                ? const Radius.circular(16.0)
                : const Radius.circular(4.0),
            bottomRight: message.isSent
                ? const Radius.circular(4.0)
                : const Radius.circular(16.0),
          ),
        ),
        child: Text(
          message.text,
          style: TextStyle(
            color: message.isSent ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isSent;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isSent,
    required this.timestamp,
  });
}
