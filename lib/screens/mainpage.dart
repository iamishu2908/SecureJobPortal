import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/signin_student.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:async/async.dart';

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          children: [
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(
                    top: 20, left: 10, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Stack(children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: primarytheme,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Test123 !',
                              textAlign: TextAlign.left,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w700,
                                color: primarytheme,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                    GestureDetector(
                      onTap: () {
                        //TODO : link to profile page here
                        setState(() {});
                      },
                      child: Container(
                        height: 50,
                        alignment: Alignment.topRight,
                        child: Image(
                          alignment: Alignment.topRight,
                          image: AssetImage('assets/images/profile.png'),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Text(
                'Find Your Job',
                textAlign: TextAlign.left,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  color: primarytheme,
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '44.5k',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Jobs',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  decoration: BoxDecoration(
                      color: secondarytheme,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '66.8k',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w800,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Internships',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: 100,
                  decoration: BoxDecoration(
                      color: peachtheme,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                )
              ],
            ),
            SizedBox(
              height: 35,
            ),
            Spacer(),
            ElevatedButton(
              child: Text("Logout"),
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
          ],
        ),
      ),
    );
  }
}
