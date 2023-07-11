import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class JobPosting extends StatefulWidget {
  const JobPosting({super.key});

  @override
  State<JobPosting> createState() => _JobPostingState();
}

class _JobPostingState extends State<JobPosting> {
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _salaryController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _jobDescriptionController = TextEditingController();
  final TextEditingController _resposibilitiesController = TextEditingController();
  final TextEditingController _requirementsController = TextEditingController();
  final TextEditingController _qualificationController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _jobTypeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white24
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.0, 20, 0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,15,0,15),
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
                Container(
                  alignment: Alignment.topLeft,
                  child: Text("Add Job Posting",
                    style: TextStyle(color: Colors.indigo[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 20),

                  ),
                ),
                const SizedBox(
                  height: 40,
                ),

                reusableTextContainer("Job Position", MediaQuery.of(context).size.width),

                reusableTextField("Job Position", false,
                    _positionController),
                const SizedBox(
                  height: 20,
                ),

                reusableTextContainer("Company", MediaQuery.of(context).size.width),

                reusableTextField("Company", false,
                    _companyController),
                const SizedBox(
                  height: 20,
                ),

                reusableTextContainer("Job Description", MediaQuery.of(context).size.width),

                reusableTextField("Job Description", false,
                    _jobDescriptionController),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Salary", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Job Type", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("Salary", false,
                            _salaryController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("Job Type", false,
                            _jobTypeController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Qualification", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Experience", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("Qualification", false,
                            _qualificationController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("Experience", false,
                            _experienceController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),

                reusableTextContainer("Resposibilities", MediaQuery.of(context).size.width),

                reusableTextField("Describe the responsibilities of the candidate..", false,
                    _resposibilitiesController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer("Requirements", MediaQuery.of(context).size.width),

                reusableTextField("Describe the requirements of the job..", false,
                    _requirementsController),
                const SizedBox(
                  height: 25,
                ),
                Center(
                  child: firebaseUIButton(context, "SAVE", () async {
                    await FirebaseFirestore.instance.collection("Job_Postings").
                    add({
                      'position': _positionController.text,
                      'company': _companyController.text,
                      'job_description': _jobDescriptionController.text,
                      'salary': _salaryController.text,
                      'job_type': _jobTypeController.text,
                      'qualification': _qualificationController.text,
                      'experience': _experienceController.text,
                      'responsibilities': _resposibilitiesController.text,
                      'requirements': _requirementsController.text,
                      'id': FirebaseAuth.instance.currentUser?.uid.toString(),
                    }).whenComplete(() => Navigator.pop(context));
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
