import 'package:flutter/material.dart';
import 'chat_screen.dart'; // if needed

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: Center(child: Text("Messages List Placeholder")),
    );
  }
}
