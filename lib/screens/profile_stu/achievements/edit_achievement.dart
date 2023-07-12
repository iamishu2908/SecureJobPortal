import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class EditAchievement extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditAchievement({super.key, required this.docToEdit});

  @override
  State<EditAchievement> createState() => _EditAchievementState();
}

class _EditAchievementState extends State<EditAchievement> {
  TextEditingController _awardController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _description = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _awardController = TextEditingController(text: (widget.docToEdit.data() as Map)['award_name']);
    _dateController = TextEditingController(text: (widget.docToEdit.data() as Map)['date']);
    _description = TextEditingController(text: (widget.docToEdit.data() as Map)['description']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextButton(
              onPressed: () {
                // Perform navigation
                Navigator.pop(context);
              },
              child: Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.black),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Edit Achievement',
              style: GoogleFonts.dmSans(
                color: primarytheme,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0.0),
            child: Text('Award Name',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: reusableTextField("Award Name", false, _awardController),
          ),
          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
            child: Text('Date',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: reusableTextField("Date of Award", false, _dateController),
          ),
          const SizedBox(height: 20.0),

          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 2.0, 80.0, 0.0),
            child: Text('Description',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Container(
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 8.0),
            child: reusableTextField("Description of the award..", false, _description),
          ),
          const SizedBox(height: 30.0),

          Center(
            child: firebaseUIButton(context, "SAVE", () {
              widget.docToEdit.reference.update({
                'award_name': _awardController.text,
                'date': _dateController.text,
                'description': _description.text,
              }).whenComplete(() => Navigator.pop(context));
            },
            ),
          ),
        ],
      ),
    );
  }
}