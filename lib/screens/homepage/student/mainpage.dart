import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_expansion_tile/rounded_expansion_tile.dart';
import 'package:secure_job_portal/screens/homepage/student/job_description.dart';
import 'package:secure_job_portal/screens/profile_stu/profilepage.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
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
  final ref = FirebaseFirestore.instance.collection("Job_Postings");
  String name = "";
  void getUserData() async {
    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();

    if (userDoc.exists) {
      setState(() {
       name = userDoc.data()?['name'] ?? 'Default Name'; 
      });


    } else {
      print('User document not found.');
    }
  }

  @override
  Widget build(BuildContext context) {
    getUserData();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
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
                            style: GoogleFonts.dmSans(
                              fontWeight: FontWeight.w700,
                              color: primarytheme,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '$name,',
                            textAlign: TextAlign.left,
                            style: GoogleFonts.dmSans(
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => profilepage()));
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
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: primarytheme,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '44.5k',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w800,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Jobs',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
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
                        style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w800,
                          color: primarytheme,
                          fontSize: 15,
                        ),
                      ),
                      Text(
                        'Internships',
                        textAlign: TextAlign.left,
                        style: GoogleFonts.dmSans(
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
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Text(
              'Recommended Job List',
              textAlign: TextAlign.left,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: primarytheme,
                fontSize: 15,
              ),
            ),
          ),
          Container(
            child: StreamBuilder(
                stream: ref.snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                    child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            snapshot.hasData ? (snapshot.data?.docs.length) : 0,
                        itemBuilder: (_, index) {
                          //bool expanded = false;
                          return Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                            child: Align(
                                child: Stack(children: <Widget>[
                              Container(
                                decoration: new BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.1),
                                      spreadRadius: 1,
                                      blurRadius: 3,
                                      offset: Offset(
                                          1, 2), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                child: Card(
                                  elevation: 0,
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(
                                              Icons.apple,
                                              size: 30.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                (snapshot.data!.docs
                                                            .elementAt(index)
                                                            .data()
                                                        as Map)['position']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.04),
                                              ),
                                              Text(
                                                (snapshot.data!.docs
                                                            .elementAt(index)
                                                            .data()
                                                        as Map)['company']
                                                    .toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w300,
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.03),
                                              ),
                                            ],
                                          ),
                                          Spacer(),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Icon(
                                              Icons.bookmark_border_outlined,
                                              size: 28.0,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            14, 0, 0, 0),
                                        child: Text(
                                          (snapshot.data!.docs
                                                  .elementAt(index)
                                                  .data() as Map)['salary']
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.038),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12, 0, 0, 0),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: greytheme,
                                                  shadowColor: Colors.grey,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0)),
                                                  minimumSize: Size(
                                                      50, 30), //////// HERE
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  (snapshot.data!.docs
                                                              .elementAt(index)
                                                              .data()
                                                          as Map)['experience']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.028),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(right: 35),
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: greytheme,
                                                  shadowColor: Colors.grey,
                                                  elevation: 3,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32.0)),
                                                  minimumSize: Size(
                                                      50, 30), //////// HERE
                                                ),
                                                onPressed: () {},
                                                child: Text(
                                                  (snapshot.data!.docs
                                                              .elementAt(index)
                                                              .data()
                                                          as Map)['job_type']
                                                      .toString(),
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.black,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.028),
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: peachtheme,
                                                shadowColor: Colors.grey,
                                                elevation: 3,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            32.0)),
                                                minimumSize:
                                                    Size(50, 30), //////// HERE
                                              ),
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            JobDescriptionScreen(
                                                                docToView: snapshot
                                                                    .data!.docs
                                                                    .elementAt(
                                                                        index))));
                                              },
                                              child: Text(
                                                'Apply',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.black,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.035),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ])),
                          );
                        }),
                  );
                }),
          )
        ],
      ),
    );
  }
}
