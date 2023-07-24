import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantSkill extends StatefulWidget {
  String id;
  ApplicantSkill({super.key, required this.id});

  @override
  State<ApplicantSkill> createState() => _ApplicantSkillState();
}

class _ApplicantSkillState extends State<ApplicantSkill> {
  final ref = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
    //final reference = ref.doc();
    //print(reference);
    return Scaffold(
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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text("Skills",
          style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900]),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: StreamBuilder(
            stream: ref.doc(widget.id).collection('skills').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    itemCount:
                    snapshot.hasData ? (snapshot.data?.docs.length) : 0,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      1, 2), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              shape: BoxShape.rectangle,
                              borderRadius:
                              const BorderRadius.all(Radius.circular(15.0)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10,15, 10),
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                child: Row(
                                  children: [
                                    Text(
                                        (snapshot.data!.docs
                                            .elementAt(index)
                                            .data() as Map)['skill']
                                            .toString(),
                                        style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontSize: 20,
                                        )),
                            Spacer(),
                            Text(
                                  (snapshot.data!.docs
                                      .elementAt(index)
                                      .data() as Map)[
                                  'isVerified']
                                      .toString() ==
                                      'false'
                                      ? ""
                                      : "Verified",
                                  style: GoogleFonts.openSans(
                                      fontWeight: FontWeight.w700,
                                      color: (snapshot.data!.docs
                                          .elementAt(
                                          index)
                                          .data() as Map)[
                                      'isVerified']
                                          .toString() ==
                                          'false'
                                          ? Colors.transparent
                                          : Colors.green[500],
                                      fontSize: 12)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              );
            }),
      ),
    );
  }
}
