import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/homepage/company/applicant_achievements.dart';
import 'package:secure_job_portal/screens/homepage/company/applicant_education.dart';
import 'package:secure_job_portal/screens/homepage/company/applicant_skills.dart';
import 'package:secure_job_portal/screens/homepage/company/applicant_work_exp.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/pdf_viewer.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

List<String> profilemenu = [
  'About Me',
  'Work Experience',
  'Education',
  'Skills',
  'Achievements',
  'Resume'
];
List<IconData> iconmenu = [
  Icons.person_pin_rounded,
  Icons.work_outline_rounded,
  Icons.school,
  Icons.lightbulb,
  Icons.workspace_premium_outlined,
  Icons.file_present_rounded
];

class ViewApplicantProfile extends StatefulWidget {
  String id;
  ViewApplicantProfile({Key? key, required this.id});

  @override
  State<ViewApplicantProfile> createState() => _ViewApplicantProfileState();
}

class _ViewApplicantProfileState extends State<ViewApplicantProfile> {
  String name = '';
  void getUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        name = userDoc.data()?['name'] ?? 'Default Name';
      });

      print('User Name: $name');
    } else {
      print('User document not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.2,
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
                style: TextButton.styleFrom(iconColor: Colors.white),
                child: Icon(
                  Icons.arrow_back,
                  size: 23,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.only(left: 30, top: 2),
                height: 50,
                child: Image(
                  image: AssetImage('assets/images/profile.png'),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 30, top: 10),
                child: Text(
                  '$name',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w400,
                    color: whitetheme,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: primarytheme,
        elevation: 5.0,
      ),
      body: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              // height: SizeConfig.screenHeight,
              child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: profilemenu.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: qbox(profilemenu.elementAt(index),
                            iconmenu.elementAt(index), widget.id));
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(50, 20, 50, 50),
            child: ElevatedButton(
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                  backgroundColor:
                  MaterialStateProperty.all<Color>(primarytheme),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
              child: Text(
                'Did you Hire the Candidate?',
                textAlign: TextAlign.left,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w800,
                  color: whitetheme,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
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
                                  .height * 0.02, 20, 20),
                              height: MediaQuery.of(context).size.height * 0.25,
                              child: Center(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(
                                      10, 20, 10, 10),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 15),
                                        child: SizedBox(
                                          width: 100,
                                          child: ElevatedButton(
                                              style: ButtonStyle(
                                                  minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                                                  backgroundColor:
                                                  MaterialStateProperty.all<Color>(primarytheme),
                                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(18.0),
                                                      ))),
                                              child: Text(
                                                'Yes',
                                                textAlign: TextAlign.left,
                                                style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w800,
                                                  color: whitetheme,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              onPressed: () {}
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                            style: ButtonStyle(
                                                minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                                                backgroundColor:
                                                MaterialStateProperty.all<Color>(primarytheme.withOpacity(0.5)),
                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(18.0),
                                                    ))),
                                            child: Text(
                                              'No',
                                              textAlign: TextAlign.left,
                                              style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w800,
                                                color: whitetheme,
                                                fontSize: 15,
                                              ),
                                            ),
                                            onPressed: () {}
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )));
                    });
                }
            ),
          ),
        ],
      ),
    );
  }
}

class qbox extends StatefulWidget {
  String title;
  IconData icon;
  String id;

  qbox(this.title, this.icon, this.id);
  // qbox(this.catlist, this.index);

  @override
  State<qbox> createState() => _qboxState();
}

class _qboxState extends State<qbox> {
  TextEditingController _aboutMeController = TextEditingController();
  var url = '';
  bool expand = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: GestureDetector(
          onTap: () {
            expand = !expand;
            FirebaseStorage.instance
                .ref()
                .child('files')
                .child(widget.id)
                .getDownloadURL()
                .then(
              (value) {
                setState(
                  () {
                    url = value;
                  },
                );
              },
            ).catchError((e) {
              debugPrint('Exception::: ==========>>>>>>> ${e.toString()}');
              setState(
                () {
                  url = '';
                },
              );
            });
            //setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.02),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(1, 2), // changes position of shadow
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(20))),
            padding: const EdgeInsets.all(12),
            child: (expand == false)
                ? Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          widget.icon,
                          size: 22.0,
                          color: orangetheme,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${widget.title}',
                        // overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontSize: 17,
                        ),
                      ),
                      Spacer(),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.open_in_new,
                          size: 22.0,
                          color: orangetheme,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      )
                    ],
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Icon(
                                    widget.icon,
                                    size: 22.0,
                                    color: orangetheme,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '${widget.title}',
                                  // overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.left,
                                  style: GoogleFonts.dmSans(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                    fontSize: 17,
                                  ),
                                ),
                                Spacer(),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: GestureDetector(
                                    onTap: () async {
                                      if (widget.title == 'Work Experience') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicantWorkExperience(
                                                        id: widget.id)));
                                      } else if (widget.title == 'Education') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicantEducation(
                                                        id: widget.id)));
                                      } else if (widget.title ==
                                          'Achievements') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicantAchievements(
                                                        id: widget.id)));
                                      } else if (widget.title == 'Skills') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ApplicantSkill(
                                                        id: widget.id)));
                                      }
                                    },
                                    child: Icon(
                                      Icons.open_in_new,
                                      size: 22.0,
                                      color: orangetheme,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            getText(widget.title, url)
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget getText(String title, String url) {
    if (title == 'Resume') {
      return TextButton(
        onPressed: () async {
          if (url != '') {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PdfViewerPage(url: url)));
          } else {}
        },
        child: Text(
          (url != '') ? 'View Resume' : '',
          textAlign: TextAlign.right,
          style: GoogleFonts.dmSans(
            fontWeight: FontWeight.w500,
            color: Colors.blue,
            fontSize: 14,
            decoration: TextDecoration.underline,
          ),
        ),
      );
    } else if (title == 'About Me') {
      var collection = FirebaseFirestore.instance.collection('Users');
      return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        future: collection.doc(widget.id).get(),
        builder: (_, snapshot) {
          if (snapshot.hasError) return Text('Error = ${snapshot.error}');

          if (snapshot.hasData) {
            var data = snapshot.data!.data();
            var value = data!['about_me'];
            return Text(
              value,
              textAlign: TextAlign.left,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 14,
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      );
    } else {
      return Text(
        '',
        textAlign: TextAlign.left,
      );
    }
  }
}
