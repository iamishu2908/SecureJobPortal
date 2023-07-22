import 'package:flutter/material.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {super.key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions});

  final String question;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}/$totalQuestions: $question',
          style: const TextStyle(fontSize: 24.0, color: neutral)),
    );
  }
}
