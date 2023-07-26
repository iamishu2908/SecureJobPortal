
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'generatingpdf.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';



class PdfPreviewPage extends StatelessWidget {
  final UserData user;
  PdfPreviewPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return  PdfPreviewPage(user: user);
          }));
        },
        child: const Icon(Icons.refresh),
      ),
      body: PdfPreview(
        build: (context) => makePdf(user),
      ),
    );
  }
}