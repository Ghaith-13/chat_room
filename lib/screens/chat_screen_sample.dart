import 'package:flutter/material.dart';
import '../core/styles/colors.dart';
import '../widgets/chat/sender_item_chat.dart';
import '../widgets/chat/response_item_chat.dart';

class ChatScreenSample extends StatelessWidget {
  const ChatScreenSample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.gray500,
              child: const Text(
                'r',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'raihan',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SenderItemChat(
            message: 'what is flutter ?',
            userName: 'raihan',
            onRegenerate: () => print('Regenerate'),
            onCopy: () => print('Copy'),
            onDelete: () => print('Delete'),
            onEdit: () => print('Edit'),
            onCode: () => print('Code'),
            onSave: (text) => print('Save: $text'),
            onSaveAndRetry: (text) => print('Save and Retry: $text'),
          ),
          const SizedBox(height: 16),
          // Loading Response
          ResponseItemChat(
            reasoning: '',
            response: '',
            aiName: 'Qwen3 0.6B (free)',
            isLoading: true,
            onUsernameTap: () => print('Username tapped'),
          ),
          const SizedBox(height: 16),
          // Completed Response
          ResponseItemChat(
            reasoning:
                '''Okay, the user asked, "what is flutter?" and then repeated the question. I need to respond appropriately.

First, I should acknowledge their question. Since they're asking again, maybe they want a more detailed explanation. Flutter is an open-source framework for building mobile, web, and desktop apps. It's designed to work across different platforms, so I should explain that it allows developers to create native code for both mobile and web. It's also built with a visual design system so it can be used on both platforms. Let me make sure to include key points like cross-platform compatibility and simplicity. I should keep it concise but informative.''',
            response:
                '''Flutter is an open-source framework developed by Google that allows developers to create cross-platform mobile, web, and desktop applications in a single codebase. It uses a visual design system (like Flutter's UI Kit) to build applications that work seamlessly on different platforms, including web, mobile, and desktop. The framework is optimized for performance by building native code for these platforms, making it a popular choice for developers looking to avoid multiple development cycles.''',
            aiName: 'Qwen3 0.6B (free)',
            isLoading: false,
            onRegenerate: () => print('Regenerate'),
            onCopy: () => print('Copy'),
            onDelete: () => print('Delete'),
            onEdit: () => print('Edit'),
            onAnalytics: () => print('Analytics'),
            onUsernameTap: () => print('Username tapped'),
          ),
        ],
      ),
    );
  }
}
