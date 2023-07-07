import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/work/add_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/work/edit_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/profilepage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class WorkExperience extends StatefulWidget {
  const WorkExperience({super.key});

  @override
  State<WorkExperience> createState() => _WorkExperienceState();
}

class _WorkExperienceState extends State<WorkExperience> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('work_exp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: FloatingActionButton(
            backgroundColor: primarytheme,
            child: Icon(
              Icons.add,
            ),
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AddExperience(),
                  ),
                );
              });
            }),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(""),
        ),
        //notchMargin: 5,
      ),
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          style: TextButton.styleFrom(iconColor: Colors.indigo[900]),
          child: Icon(
            Icons.arrow_back,
            size: 23,
          ),
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => profilepage())),
        ),
        title: Text("Work Experience",
            style: TextStyle(
                fontFamily: 'Playfair Display',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.indigo[900]),
        ),
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: StreamBuilder(
            stream: ref.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    itemCount: snapshot.hasData?(snapshot.data?.docs.length):0,
                    itemBuilder: (_,index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditExperience(docToEdit: snapshot.data!.docs.elementAt(index),),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,8),
                          child: Container(
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset:
                                  Offset(1, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              (snapshot.data!.docs.elementAt(index).data() as Map)['job_title'].toString(),
                                              maxLines: 1,
                                              style: GoogleFonts.dmSans(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black,
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.06),
                                            ),
                                            Text(
                                              (snapshot.data!.docs.elementAt(index).data() as Map)['com_name'].toString(),
                                              maxLines: 1,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.indigo[900],
                                                  fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                      0.038),
                                            ),
                                          ],
                                        ),
                                        Spacer(),
                                        Align(
                                          alignment: Alignment.topRight,
                                          child: Row(
                                            children: [
                                              Text(
                                                (snapshot.data!.docs.elementAt(index).data() as Map)['start_date'].toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.035),
                                              ),
                                              Text(
                                                ' - ',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w200,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.05),
                                              ),
                                              Text(
                                                (snapshot.data!.docs.elementAt(index).data() as Map)['end-date'].toString(),
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.035),
                                              ),
                                            ],
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
                                    Text(
                                      (snapshot.data!.docs.elementAt(index).data() as Map)['description'].toString(),
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.035),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      );
                    }),
              );
            }
        ),
      ),

    );
  }
}
