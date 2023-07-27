import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class FeedbackForm extends StatefulWidget {
  String company;
  FeedbackForm({super.key, required this.company});

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final TextEditingController _feedback = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 15),
                child: TextButton(
                  onPressed: () {
                    // Perform navigation
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text(
                  'Feedback Form',
                  style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 5.0),

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Please provide Company Feedback (Optional)',
              style: GoogleFonts.dmSans(
                color: primarytheme,
                fontSize: 14,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
            child: Text('Feedback',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: TextField(
              maxLines: 6,
              controller: _feedback,
              obscureText: false,
              enableSuggestions: !false,
              autocorrect: !false,
              cursorColor: Colors.grey.shade500,
              style: TextStyle(color: Colors.grey.shade600),
              decoration: InputDecoration(
                labelText: "Provide Feedback..",
                labelStyle: TextStyle(color: Colors.grey.shade500,
                    fontSize: 14),
                alignLabelWithHint: true,
                filled: true,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, style: BorderStyle.none),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.indigo.shade900),
                ),
              ),
              keyboardType: true
                  ? TextInputType.visiblePassword
                  : TextInputType.emailAddress,
            ),
          ),
          const SizedBox(height: 30.0),

          Center(
            child: firebaseUIButton(context, "SAVE", () async {
              await FirebaseFirestore.instance.collection("Feedback").
              add({
                'feedback': _feedback.text,
                'company': widget.company,
              }).whenComplete(() => Navigator.pop(context));
            }),
          ),
        ],
      ),
    );
  }
}
