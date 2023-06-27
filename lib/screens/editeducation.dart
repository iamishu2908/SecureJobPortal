import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/screens/profilepage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.indigo,
        ),
        home: profilepage()
      // home: const SignInStuScreen(),
    );
  }
}




class EditEducationPage extends StatefulWidget {
  const EditEducationPage({Key? key}) : super(key: key);

  @override
  State<EditEducationPage> createState() => _EditEducationPageState();
}

class _EditEducationPageState extends State<EditEducationPage> {
  final TextEditingController _levelOfEducationController = TextEditingController();
  final TextEditingController _courseDetailsController = TextEditingController();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => profilepage()));
              },
              icon: const Icon(
                Icons.arrow_back,
                size: 25,
              ),
              color: Colors.grey[900]
          ),
        ),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,

          child: Padding(
                  padding: EdgeInsets.fromLTRB(20, MediaQuery.of(context).size.height * 0.12, 20, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Add Education',
                            style: GoogleFonts.dmSans(
                              color: Colors.indigo.shade900,
                              fontSize: 20,
                              fontWeight: FontWeight.w800,

                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Level of Education",
                              style: TextStyle(color: Colors.indigo.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: reusableTextField(
                                  "Level of Education", false, _levelOfEducationController),
                            )
                        ),
                        const SizedBox(height: 10.0),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Institution Name",
                              style: TextStyle(color: Colors.indigo.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 10.0),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: reusableTextField(
                                  "Institution details", false, _institutionController),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Course Name",
                              style: TextStyle(color: Colors.indigo.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),


                        const SizedBox(height: 10.0),
                        Expanded(
                            child: Container(
                              padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                              margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                              child: reusableTextField(
                                  "Course details", false, _courseDetailsController),
                            )
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Field of Study",
                              style: TextStyle(color: Colors.indigo.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10.0),
                            
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                                margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                                child: reusableTextField(
                                    "Field of Study", false, _fieldOfStudyController),
                              ),
                            ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            alignment: Alignment.topLeft,
                            child: Text(
                              "",
                              style: TextStyle(color: Colors.indigo.shade900,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(18.0, 0.0, 80.0, 0.0),
                                child: Text('Start Date',
                                    style: GoogleFonts.dmSans(
                                        color: primarytheme,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        )
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(18.0, 0.0, 80.0, 0.0),
                                child: Text('End Date',
                                    style: GoogleFonts.dmSans(
                                        color: primarytheme,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                        )
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                                  margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                                  child: reusableTextField("Date", false, _startDateController),
                                )
                            ),
                            Expanded(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 8.0, 8.0),
                                  margin: EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                                  child: reusableTextField("Date", false, _endDateController),
                                )),
                          ],
                        ),
                        Center(
                            child: firebaseUIButton(context, "SAVE", () {
                            })
                        ),
                      ]
                  )


              )
          )

    );
  }
}