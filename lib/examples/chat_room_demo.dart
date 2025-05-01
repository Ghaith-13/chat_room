import 'package:flutter/material.dart';
import '../widgets/chat_room_list.dart';

class ChatRoomDemo extends StatelessWidget {
  const ChatRoomDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Rooms'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ChatRoomList(),
    );
  }
}
