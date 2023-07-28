// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/student/home.dart';
import 'package:secure_job_portal/screens/profile_stu/achievements/achievement.dart';
import 'package:secure_job_portal/screens/profile_stu/edu/education.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/pdf_viewer.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/previewpage.dart';
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker_info.dart';
import 'package:secure_job_portal/screens/profile_stu/skills/add_skills.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/work_experience.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:secure_job_portal/screens/profile_stu/resume/resume_maker/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

class profilepage extends StatefulWidget {
  const profilepage({Key? key}) : super(key: key);

  @override
  State<profilepage> createState() => _profilepageState();
}

class _profilepageState extends State<profilepage> {
  String name = '';
  String linkedin = '';
  String github = '';
  String phone = '';

  void getUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
        name = userDoc.data()?['name'] ?? 'Default Name';
        linkedin = userDoc.data()?['linkedin'] ?? '';
        github = userDoc.data()?['github'] ?? '';
        phone = userDoc.data()?['phone'] ?? '';
      });
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
                  padding: const EdgeInsets.only(left: 30, top: 10),
                  child: Text(
                    name,
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
          actions: [
            Container(
                padding: EdgeInsets.only(top: 20),
                height: 50,
                alignment: Alignment.topRight,
                child: Icon(Icons.share_rounded)),
            Container(
                padding: EdgeInsets.only(left: 20, right: 10, top: 20),
                height: 50,
                alignment: Alignment.topRight,
                child: Icon(Icons.settings)),
          ]),
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
                            iconmenu.elementAt(index)));
                  }),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(50, 25, 50, 0),
              child: ElevatedButton(
                  style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(Size(60, 50)),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.orangeAccent.shade200),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  child: Text(
                    'Resume Maker',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w800,
                      color: whitetheme,
                      fontSize: 15,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ResumeInfoForm(linkedin: linkedin, github: github, phone: phone)));
                  })),
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
                'Logout',
                textAlign: TextAlign.left,
                style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w800,
                  color: whitetheme,
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  print("Signed Out");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SignInStuScreen()));
                });
              },
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

  qbox(this.title, this.icon);
  // qbox(this.catlist, this.index);

  @override
  State<qbox> createState() => _qboxState();
}

class _qboxState extends State<qbox> {
  TextEditingController _aboutMeController = TextEditingController();
  var url = '';
  bool expand = false;
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
                .child(FirebaseAuth.instance.currentUser!.uid)
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
                          Icons.edit,
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
                                      if (widget.title == 'About Me') {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40)),
                                                elevation: 16,
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      20,
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.06,
                                                      20,
                                                      0),
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.35,
                                                  child: Column(
                                                    children: [
                                                      reusableTextContainer(
                                                          'About Me',
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width),
                                                      SizedBox(height: 5),
                                                      reusableTextField(
                                                          'Describe Yourself..',
                                                          false,
                                                          _aboutMeController),
                                                      SizedBox(height: 20),
                                                      firebaseUIButton(
                                                          context, "SAVE",
                                                          () async {
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid)
                                                            .update({
                                                          'about_me':
                                                              _aboutMeController
                                                                  .text,
                                                        }).whenComplete(() =>
                                                                Navigator.pop(
                                                                    context));
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            });
                                      } else if (widget.title ==
                                          'Work Experience') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    WorkExperience()));
                                      } else if (widget.title == 'Education') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Education()));
                                      } else if (widget.title == 'Skills') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AddSkill()));
                                      } else if (widget.title ==
                                          'Achievements') {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Achievement()));
                                      } else if (widget.title == 'Resume') {
                                        final path =
                                            (await FlutterDocumentPicker
                                                .openDocument())!;
                                        final lastIndex = path.lastIndexOf('.');
                                        final extension =
                                            path.substring(lastIndex + 1);
                                        print(extension);
                                        if (extension == 'pdf') {
                                          File file = File(path);
                                          firebase_storage.UploadTask? task =
                                              await uploadFile(file)
                                                  .then((result) {
                                            FirebaseStorage.instance
                                                .ref()
                                                .child('files')
                                                .child(FirebaseAuth
                                                    .instance.currentUser!.uid)
                                                .getDownloadURL()
                                                .then((result) {
                                              setState(() {
                                                url = result;
                                              });
                                            });
                                          });
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content:
                                                  Text('File should be in .pdf extension'),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    child: Icon(
                                      Icons.edit,
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
        future: collection.doc(FirebaseAuth.instance.currentUser?.uid).get(),
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

  Future<firebase_storage.UploadTask?> uploadFile(File file) async {
    if (file == null) {
      return null;
    }

    firebase_storage.UploadTask uploadTask;

    // Create a Reference to the file
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('files')
        .child(FirebaseAuth.instance.currentUser!.uid);

    final metadata = firebase_storage.SettableMetadata(
        contentType: 'file/pdf',
        customMetadata: {'picked-file-path': file.path});
    print("Uploading..!");

    uploadTask = ref.putData(await file.readAsBytes(), metadata);

    print("done..!");
    return Future.value(uploadTask);
  }
}
