import 'package:flutter/material.dart';
import 'core/utils/app_config.dart';
import 'core/utils/app_theme.dart';
import 'core/enums/app_enums.dart';
import 'examples/model_selector_demo.dart';
import 'examples/model_add_button_demo.dart';
import 'examples/info_card_demo.dart';
import 'examples/chat_input_demo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize app configuration
  AppConfig().init(environment: Environment.development);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = AppTheme();

    return MaterialApp(
      title: 'Chatroom App',
      debugShowCheckedModeBanner: false,
      themeMode: appTheme.getThemeMode(),
      theme: appTheme.lightTheme,
      darkTheme: appTheme.darkTheme,
      home: const ChatInputDemo(),
    );
  }
}
