import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/edu/education.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class AddEducation extends StatefulWidget {
  const AddEducation({super.key});

  @override
  State<AddEducation> createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  final TextEditingController _levelOfEduController = TextEditingController();
  final TextEditingController _instituteNameController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;


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
              'Add Education',
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
            child: Text('Level of Education',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: reusableTextField("Level of education", false, _levelOfEduController),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
            child: Text('Institution Name',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: reusableTextField(
                    "Institute Name", false, _instituteNameController),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
            child: Text('Field of Study',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: reusableTextField(
                    "Field of study", false, _fieldOfStudyController),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 80.0, 0.0),
                  child: Text('Start Date',
                      style: GoogleFonts.dmSans(
                          color: primarytheme,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none)),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(18.0, 0.0, 80.0, 0.0),
                  child: Text('End Date',
                      style: GoogleFonts.dmSans(
                          color: primarytheme,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none)),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: reusableTextField("", false, _startDateController),
                  )),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: reusableTextField("", false, _endDateController),
                  )),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 2.0, 80.0, 0.0),
            child: Text('Description',
                style: GoogleFonts.dmSans(
                    color: primarytheme,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none)),
          ),
          Expanded(
            child: reusableTextField("Description of the Education...", false, _description),
          ),
          Center(
            child: firebaseUIButton(context, "SAVE", () async {
              await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('education').
              add({
                'level_of_edu': _levelOfEduController.text,
                'institute_name': _instituteNameController.text,
                'field_of_study': _fieldOfStudyController.text,
                'start_date': _startDateController.text,
                'end_date': _endDateController.text,
                'description': _description.text,
              }).whenComplete(() => Navigator.pop(context));
            }),
          ),
        ],
      ),
    );
  }
}
