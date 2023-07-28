import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/previewpage.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';

class ResumeInfoForm extends StatefulWidget {

  String linkedin, github, phone;
  ResumeInfoForm({super.key, required this.linkedin, required this.github, required this.phone});

  @override
  State<ResumeInfoForm> createState() => _ResumeInfoFormState();
}

class _ResumeInfoFormState extends State<ResumeInfoForm> {
  TextEditingController _linkedinController = TextEditingController();
  TextEditingController _githubController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _linkedinController = TextEditingController(text: widget.linkedin);
    _githubController = TextEditingController(text: widget.linkedin);
    _phoneController = TextEditingController(text: widget.phone);
    super.initState();
  }

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
                        child: firebaseUIButton(context, "CREATE RESUME", () async {
                          await FirebaseFirestore.instance.collection(
                              "Users").doc(FirebaseAuth.instance.currentUser?.uid).
                          update({
                            'linkedin': _linkedinController.text,
                            'github': _githubController.text,
                            'phone': _phoneController.text,
                          }).whenComplete(() => getData()
                              );
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
  getData() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    var user = UserData(userId: userId);
    user.getUserDataResume();
    Navigator.of(context).push(MaterialPageRoute(builder: (context){

      return  PdfPreviewPage(user: user);
    }));
  }

}

