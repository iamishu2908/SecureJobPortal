import 'package:flutter/material.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/previewpage.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreatePdfMainPage extends StatefulWidget {
  const CreatePdfMainPage({super.key});

  @override
  State<CreatePdfMainPage> createState() => _CreatePdfMainPageState();
}

class _CreatePdfMainPageState extends State<CreatePdfMainPage> {
  String text = "This is text for my pdf file";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(text),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          final userId = FirebaseAuth.instance.currentUser?.uid;
          var user = UserData(userId: userId);
          user.getUserDataResume();
          Navigator.of(context).push(MaterialPageRoute(builder: (context){

            return  PdfPreviewPage(user: user);
          }));
        },
        child: const Icon(Icons.picture_as_pdf_sharp),
      ),

    );
  }
}