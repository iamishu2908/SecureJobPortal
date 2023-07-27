import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/feedback_form.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

import '../../homepage/company/job_posting.dart';

class AddExperience extends StatefulWidget {
  const AddExperience({super.key});

  @override
  State<AddExperience> createState() => _AddExperienceState();
}

class _AddExperienceState extends State<AddExperience> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyDetailsController = TextEditingController();
  final TextEditingController _startYearController = TextEditingController();
  final TextEditingController _endYearController = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _location = TextEditingController();
  final currentUser = FirebaseAuth.instance.currentUser;
  bool value = false;

  Future<bool> doesNameAlreadyExist(String name) async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users').doc(currentUser?.uid).collection('Hired')
        .where('name', isEqualTo: name)
        .limit(1)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    return documents.length >= 1;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 15, 15, 10),
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
                  'Add Work Experience',
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
            padding: const EdgeInsets.fromLTRB(18.0, 8.0, 18.0, 0.0),
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
                child: reusableTextField("Description of the Job..", false, _description),
              )),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 0.0, 8.0, 0.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 10,
                ), //SizedBox
                Text(
                  'Did we help you get the Job? ',
                  style: GoogleFonts.dmSans(
                      color: primarytheme,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none),
                ), //Text
                SizedBox(width: 10), //SizedBox
                /** Checkbox Widget **/
                Checkbox(
                  checkColor: whitetheme,
                  activeColor: primarytheme,
                  value: this.value,
                  onChanged: (value) async{
                    setState(() {
                      this.value = value!;
                      //print(value);
                    });

                    if(value == true) {
                      print(_companyDetailsController.text);
                      bool check = await doesNameAlreadyExist(_companyDetailsController.text);
                      print(check);
                      if(check == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => FeedbackForm(company: _companyDetailsController.text)));
                      }
                      else if(check == false) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Cannot be verified.'),
                          behavior: SnackBarBehavior.floating,
                          margin:
                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                        ));
                        setState(() {
                          this.value = !value!;
                        });
                      }
                    }
                  },
                ), //Checkbox
              ], //<Widget>[]
            ),
          ),
          Center(
            child: firebaseUIButton(context, "SAVE", () async {
              await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('work_exp').
              add({
                'job_title': _jobTitleController.text,
                'com_name': _companyDetailsController.text,
                'location': _location.text,
                'start_year': _startYearController.text,
                'end_year': _endYearController.text,
                'description': _description.text,
              }).whenComplete(() => Navigator.pop(context));
            }),
          ),
        ],
      ),
    );
  }
}
