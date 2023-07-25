import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

import '../../profile_stu/profilepage.dart';

class ApplicantForm extends StatefulWidget {

  String role, company;
  ApplicantForm({super.key, required this.role, required this.company});

  @override
  State<ApplicantForm> createState() => _ApplicantFormState();
}

class _ApplicantFormState extends State<ApplicantForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
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
                      child: Text("Apply through your profile",
                        style: TextStyle(color: Colors.indigo[900],
                            fontWeight: FontWeight.w500,
                            fontSize: 20),

                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),

                    reusableTextContainer("Name", MediaQuery
                        .of(context)
                        .size
                        .width),

                    reusableTextField("Name", false,
                        _nameController),
                    const SizedBox(
                      height: 20,
                    ),

                    reusableTextContainer("Email", MediaQuery
                        .of(context)
                        .size
                        .width),

                    reusableTextField("Email", false,
                        _emailController),
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

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Profile not updated?",
                            style: TextStyle(color: Colors.indigo[900],
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) =>
                                    profilepage()));
                          },
                          child: const Text(
                            " Update Now",
                            style: TextStyle(color: Colors.orangeAccent,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: firebaseUIButton(context, "SUBMIT", () async {
                          await FirebaseFirestore.instance.collection(
                              "Applicants").
                          add({
                            'candidate_name': _nameController.text,
                            'candidate_email': _emailController.text,
                            'candidate_phone': _phoneController.text,
                            'role': widget.role,
                            'company': widget.company,
                            'id': FirebaseAuth.instance.currentUser?.uid
                                .toString(),
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
                                              child: Text("Applied!",
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

