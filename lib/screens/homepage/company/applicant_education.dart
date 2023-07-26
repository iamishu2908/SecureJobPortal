import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantEducation extends StatefulWidget {
  String id;
  ApplicantEducation({super.key, required this.id});

  @override
  State<ApplicantEducation> createState() => _ApplicantEducationState();
}

class _ApplicantEducationState extends State<ApplicantEducation> {
  final ref = FirebaseFirestore.instance.collection("Users");

  @override
  Widget build(BuildContext context) {
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
        title: Text("Education",
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
            stream: ref.doc(widget.id).collection('education').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: ListView.builder(
                    itemCount: snapshot.hasData?(snapshot.data?.docs.length):0,
                    itemBuilder: (_,index) {
                      return Padding(
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
                                          Container(
                                            width: MediaQuery.of(context).size.width *0.55,
                                            child: Flexible(
                                              child: Text(
                                                (snapshot.data!.docs.elementAt(index).data() as Map)['level_of_edu'].toString(),
                                                //maxLines: 1,
                                                overflow: TextOverflow.visible,
                                                style: GoogleFonts.dmSans(
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black,
                                                    fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                        0.055),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            (snapshot.data!.docs.elementAt(index).data() as Map)['institute_name'].toString(),
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
                                              (snapshot.data!.docs.elementAt(index).data() as Map)['end_date'].toString(),
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
                      );
                    }),
              );
            }
        ),
      ),

    );
  }
}
