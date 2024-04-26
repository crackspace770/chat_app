import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {

  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isCurrentUser ? Colors.green : Colors.grey,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 25),
      child: Text(message,
      style: TextStyle(color: Colors.white),
      ),
    );
  }
}
