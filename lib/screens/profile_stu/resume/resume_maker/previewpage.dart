
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'generatingpdf.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';
import 'package:secure_job_portal/utils/color_utils.dart';


class PdfPreviewPage extends StatelessWidget {
  final UserData user;
  PdfPreviewPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primarytheme,
        elevation: 5.0,
        title: const Text('Resume Preview'),
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        titleSpacing: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primarytheme,
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