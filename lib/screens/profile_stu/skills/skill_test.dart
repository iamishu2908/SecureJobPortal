// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/Models/question_model.dart';
import 'package:secure_job_portal/screens/profile_stu/skills/widgets/result_box.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import '../skills/widgets/next_button.dart';
import '../skills/widgets/option_card.dart';
import '../skills/widgets/question_widget.dart';
import '../skills/questions-list.dart';

class SkillTest extends StatefulWidget {
  final String skill;
  SkillTest({super.key, required this.skill});
  @override
  State<SkillTest> createState() => _SkillTestState();
}

class _SkillTestState extends State<SkillTest> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('skills');
  List<Question> _questions = [];
  int index = 0;
  int score = 0;
  bool isAlreadySelected = false;
  bool isPressed = false;
  String skill = "";
  bool isVerified = false;
  void nextQuestion() async {
    if (index == _questions.length - 1) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection('skills')
          .where('skill', isEqualTo: skill)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document (you can choose how to handle multiple matches)
        DocumentSnapshot docSnapshot = await querySnapshot.docs[0];

        // Step 2: Use the `update` method to modify the document's fields
        docSnapshot.reference.update({
          'isVerified': score >= _questions.length / 2 ? true : false,
          // Add other fields and their updated values here
        });
      }
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (ctx) =>
              ResultBox(result: score, questionLength: _questions.length));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please select an option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0)));
      }
    }
  }

  void changeAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    }
    if (value == true) {
      score++;
    }
    setState(() {
      isPressed = true;
      isAlreadySelected = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    skill = widget.skill;
    if (skill == 'C++') {
      _questions = CPP.questions;
    } else if (skill == 'Python') {
      _questions = Python.questions;
    } else {
      _questions = Flutter.questions;
    }
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: Text(skill),
        backgroundColor: background,
        shadowColor: Colors.transparent,
        actions: [
          Padding(
            padding: EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: TextStyle(fontSize: 18),
            ),
          )
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(children: [
          QuestionWidget(
              question: _questions[index].title,
              indexAction: index,
              totalQuestions: _questions.length),
          Divider(
            color: neutral,
          ),
          SizedBox(height: 25.0),
          for (int i = 0; i < _questions[index].options.length; i++)
            GestureDetector(
              onTap: () => changeAnswerAndUpdate(
                  _questions[index].options.values.toList()[i]),
              child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                          ? correct
                          : incorrect
                      : neutral),
            ),
        ]),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(nextQuestion: nextQuestion),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
