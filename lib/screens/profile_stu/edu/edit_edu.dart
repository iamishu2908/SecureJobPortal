import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/edu/education.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class EditEducation extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditEducation({super.key, required this.docToEdit});

  @override
  State<EditEducation> createState() => _EditEducationState();
}

class _EditEducationState extends State<EditEducation> {
  TextEditingController _levelOfEduController = TextEditingController();
  TextEditingController _instituteNameController = TextEditingController();
  TextEditingController _fieldOfStudyController = TextEditingController();
  TextEditingController _startYearController = TextEditingController();
  TextEditingController _endYearController = TextEditingController();
  TextEditingController _description = TextEditingController();
  TextEditingController _location = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _levelOfEduController = TextEditingController(text: (widget.docToEdit.data() as Map)['level_of_edu']);
    _instituteNameController = TextEditingController(text: (widget.docToEdit.data() as Map)['institute_name']);
    _fieldOfStudyController = TextEditingController(text: (widget.docToEdit.data() as Map)['field_of_study']);
    _startYearController = TextEditingController(text: (widget.docToEdit.data() as Map)['start_year']);
    _endYearController = TextEditingController(text: (widget.docToEdit.data() as Map)['end_year']);
    _description = TextEditingController(text: (widget.docToEdit.data() as Map)['description']);
    _location = TextEditingController(text: (widget.docToEdit.data() as Map)['location']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
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
                  'Edit Education',
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
            child: Text('Location',
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
                    "Location", false, _location),
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
                  child: Text('Start Year',
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
                  child: Text('End Year',
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
                    child: reusableTextField("", false, _startYearController),
                  )),
              Expanded(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: reusableTextField("", false, _endYearController),
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
              child: Container(
                padding: EdgeInsets.all(8.0),
                margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                child: reusableTextField("Description of the Education ..", false, _description),
              )),
          Center(
            child: firebaseUIButton(context, "SAVE", () {
              widget.docToEdit.reference.update({
                'level_of_edu': _levelOfEduController.text,
                'institute_name': _instituteNameController.text,
                'location': _location.text,
                'field_of_study': _fieldOfStudyController.text,
                'start_year': _startYearController.text,
                'end_year': _endYearController.text,
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
