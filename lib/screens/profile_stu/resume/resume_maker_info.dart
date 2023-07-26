import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

import '../../profile_stu/profilepage.dart';

class ResumeInfoForm extends StatefulWidget {

  const ResumeInfoForm({super.key});

  @override
  State<ResumeInfoForm> createState() => _ResumeInfoFormState();
}

class _ResumeInfoFormState extends State<ResumeInfoForm> {
  final TextEditingController _linkedinController = TextEditingController();
  final TextEditingController _githubController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: MediaQuery
                .of(context)
                .size
                .height,
            decoration: BoxDecoration(
                color: Colors.white24
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    20, MediaQuery
                    .of(context)
                    .size
                    .height * 0.05, 20, 0),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
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
                      child: Text("Provide Information for Resume",
                        style: TextStyle(color: Colors.indigo[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 20),

                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),

                    reusableTextContainer("LinkedIn", MediaQuery
                        .of(context)
                        .size
                        .width),

                    reusableTextField("LinkedIn URL", false,
                        _linkedinController),
                    const SizedBox(
                      height: 20,
                    ),

                    reusableTextContainer("GitHub", MediaQuery
                        .of(context)
                        .size
                        .width),

                    reusableTextField("GitHub URL", false,
                        _githubController),
                    const SizedBox(
                      height: 20,
                    ),

                    reusableTextContainer("Phone Number", MediaQuery
                        .of(context)
                        .size
                        .width),

                    reusableTextField("Phone Number", false,
                        _phoneController),

                    const SizedBox(
                      height: 40,
                    ),

                    Center(
                        child: firebaseUIButton(context, "SUBMIT", () async {
                          await FirebaseFirestore.instance.collection(
                              "Users").doc(FirebaseAuth.instance.currentUser?.uid).
                          update({
                            'linkedin': _linkedinController.text,
                            'github': _githubController.text,
                            'phone': _phoneController.text,
                          }).whenComplete(() =>
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius
                                                .circular(40)),
                                        elevation: 16,
                                        child: Container(
                                            padding: EdgeInsets.fromLTRB(
                                                20, MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.02, 20, 0),
                                            height: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.2,
                                            child: Center(
                                              child: Text("Submitted!",
                                                  style: TextStyle(color: Colors.indigo[900],
                                                      fontSize: 22,
                                                      fontWeight: FontWeight.w500)),
                                            )));
                                  }));
                        }
                        )
                    ),
                  ],
                ),
              ),
            )
        )
    );
  }
}

