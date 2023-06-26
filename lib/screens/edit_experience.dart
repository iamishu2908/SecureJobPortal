import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profilepage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class EditExperience extends StatefulWidget {
  const EditExperience({super.key});

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  final TextEditingController _jobTitleController = TextEditingController();
  final TextEditingController _companyDetailsController =
      TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    String description = '';
    bool? checkedValue = false;
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profilepage()));
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
              'Add Work Experience',
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
            padding: const EdgeInsets.fromLTRB(18.0, 0, 0, 9.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                  value: checkedValue,
                  onChanged: (bool? value) {
                    setState(() {
                      checkedValue = value!;
                    });
                  },
                ),
                Text("this is my position now"),
              ],
            ),
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
              height: 600,
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.all(8.0),
              child: TextField(
                cursorColor: Colors.grey.shade500,
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16.0),
                maxLines: 10,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(width: 1, style: BorderStyle.none),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                        width: 1,
                        style: BorderStyle.solid,
                        color: Colors.indigo.shade900),
                  ),
                ),
                onChanged: (String value) {
                  // Handle text input changes
                  setState(() {
                    description = value;
                  });
                },
              ),
            ),
          ),
          Center(
            child: firebaseUIButton(context, "SAVE", () {
              // FirebaseAuth.instance
              //     .editExperience(
              //     job_title: _jobTitleController.text,
              //     companyDetails: _companyDetailsController.text)
              //     .then((value) {
              //   Navigator.push(context,
              //       MaterialPageRoute(builder: (context) => profilepage()));
              // }).onError((error, stackTrace) {
              //   print("Error ${error.toString()}");
              // });
            }),
          ),
        ],
      ),
    );
  }
}
