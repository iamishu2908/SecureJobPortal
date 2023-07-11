import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/company_description.dart';
import 'package:secure_job_portal/screens/homepage/home.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/reset_password.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_company.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signup_student.dart';
import 'package:flutter/material.dart';

import '../../utils/color_utils.dart';

class JobDescriptionScreen extends StatefulWidget {
  DocumentSnapshot docToView;
  JobDescriptionScreen({super.key, required this.docToView});

  @override
  _JobDescriptionScreenState createState() => _JobDescriptionScreenState();
}

class _JobDescriptionScreenState extends State<JobDescriptionScreen> {
  bool readMore = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height * 0.18,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          titleSpacing: 0,
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: TextButton.styleFrom(iconColor: primarytheme),
                  child: Icon(
                    Icons.arrow_back,
                    size: 23,
                  ),
                  onPressed: () => Navigator.pop(context)
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 65,
                  decoration: BoxDecoration(
                    //border: Border.all(width: 1.5, color: primarytheme),
                    color: whitetheme,
                    shape: BoxShape.circle,
                  ),
                  child: Image(image: AssetImage('assets/images/apple.png'),)
                ),

              ),

            ],
          ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/wavy.jpg'),
                  colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.35), BlendMode.modulate),
                  fit: BoxFit.fill
              ),
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),

        backgroundColor: secondarytheme,
          elevation: 1,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white24
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                22, MediaQuery.of(context).size.height * 0.02, 22, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text((widget.docToView.data() as Map)['position'].toString(),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 23,
              ),
                ),
                ),
                Container(
                  child: Text((widget.docToView.data() as Map)['company'].toString(),
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w100,
                      color: primarytheme,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: OutlinedButton(onPressed: () {},
                        child: Text("Description"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: primarytheme,
                          side: BorderSide(color: primarytheme, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: FilledButton(onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CompanyDescriptionScreen(id: ((widget.docToView.data() as Map)['id'].toString()))),
                        );
                      },child: Text("Company"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: primarytheme,
                          backgroundColor: Colors.white,
                          side: BorderSide(color: primarytheme, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),

                //reusableTextContainer("Job Description", MediaQuery.of(context).size.width),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Job Description",
                    style: TextStyle(color: primarytheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                      (widget.docToView.data() as Map)['job_description'].toString(),
                    style: TextStyle(color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w200
                    ),
                    textAlign: TextAlign.left,
                    maxLines: readMore ? 20 : 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          readMore = !readMore;
                        });
                      },
                      child: Text(readMore ? "Read less" : "Read more",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400
                      ),
                      ),
                      style: OutlinedButton.styleFrom(
                        elevation: 0,
                        foregroundColor: primarytheme,
                        backgroundColor: secondarytheme,
                        //side: BorderSide(color: primarytheme, width: 1),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Requirements",
                    style: TextStyle(color: primarytheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        (widget.docToView.data() as Map)['requirements'].toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Responsibilities",
                    style: TextStyle(color: primarytheme,
                        fontSize: 16,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        (widget.docToView.data() as Map)['responsibilities'].toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Qualification",
                    style: TextStyle(color: primarytheme,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        (widget.docToView.data() as Map)['qualification'].toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Experience",
                    style: TextStyle(color: primarytheme,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        (widget.docToView.data() as Map)['experience'].toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 27,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Job Type",
                    style: TextStyle(color: primarytheme,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  //height: 27,
                  alignment: Alignment.topLeft,
                  child: Column(
                    children: [
                      Text(
                        (widget.docToView.data() as Map)['job_type'].toString(),
                        style: TextStyle(color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.w200
                        ),
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),


                firebaseUIButton(context, "Apply", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                  .onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

}