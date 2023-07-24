import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicantAchievements extends StatefulWidget {
  String id;
  ApplicantAchievements({super.key, required this.id});

  @override
  State<ApplicantAchievements> createState() => _ApplicantAchievementsState();
}

class _ApplicantAchievementsState extends State<ApplicantAchievements> {
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
        title: Text("Achievements",
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
            stream: ref.doc(widget.id).collection('achievement').snapshots(),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                          Container(
                          width: MediaQuery.of(context).size.width *0.55,
                          child: Text(
                          (snapshot.data!.docs.elementAt(index).data() as Map)['award_name'].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.dmSans(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                          0.05),
                          ),
                          ),
                          ],
                          ),
                          Spacer(),
                          Align(
                          alignment: Alignment.topRight,
                          child: Text(
                          (snapshot.data!.docs.elementAt(index).data() as Map)['date'].toString(),
                          style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          fontSize: MediaQuery.of(context)
                              .size
                              .width *
                          0.035),
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
                          )));
                    }),
              );
            }
        ),
      ),

    );
  }
}
