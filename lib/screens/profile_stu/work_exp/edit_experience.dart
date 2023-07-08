import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/work_experience.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class EditExperience extends StatefulWidget {

  DocumentSnapshot docToEdit;
  EditExperience({super.key, required this.docToEdit});

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  TextEditingController _jobTitleController = TextEditingController();
  TextEditingController _companyDetailsController = TextEditingController();
  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _description = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    _jobTitleController = TextEditingController(text: (widget.docToEdit.data() as Map)['job_title']);
    _companyDetailsController = TextEditingController(text: (widget.docToEdit.data() as Map)['com_name']);
    _startDateController = TextEditingController(text: (widget.docToEdit.data() as Map)['start_date']);
    _endDateController = TextEditingController(text: (widget.docToEdit.data() as Map)['end_date']);
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
              'Edit Work Experience',
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
            child: Text('Job Title',
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
            child: reusableTextField("Job Title", false, _jobTitleController),
          )),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0.0),
            child: Text('Company Details',
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
                "Company Details", false, _companyDetailsController),
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
            child: reusableTextField("Description of the Job...", false, _description),
          ),
          Center(
            child: firebaseUIButton(context, "SAVE", () {
    widget.docToEdit.reference.update({
    'job_title': _jobTitleController.text,
    'com_name': _companyDetailsController.text,
    'start_date': _startDateController.text,
    'end_date': _endDateController.text,
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
