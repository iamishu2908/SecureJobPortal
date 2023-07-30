import 'package:flutter/material.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  const ChatBubble({
    super.key,
    required this.message,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: secondarytheme,
      ),
      child: Text(
        message,
        style: const TextStyle(fontSize: 16, color: Colors.black),
      )
    );
  }
}