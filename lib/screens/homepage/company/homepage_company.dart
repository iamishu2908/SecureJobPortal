import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/homepage/company/job_posting.dart';
import 'package:secure_job_portal/screens/homepage/company/view_applicant_profile.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_job_portal/screens/profile_stu/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../student/job_description.dart';

final userId = FirebaseAuth.instance.currentUser?.uid;

// Access the Firestore instance
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class CompanyHome extends StatefulWidget {
  const CompanyHome({super.key});

  @override
  State<CompanyHome> createState() => _CompanyHomeState();
}

class _CompanyHomeState extends State<CompanyHome> {
  String company = "";
  bool result = false;
  final CollectionReference ref = FirebaseFirestore.instance.collection("Applicants");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: ListView(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Hello!',
                    textAlign: TextAlign.left,
                    style: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w700,
                      color: primarytheme,
                      fontSize: 20,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
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
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Post',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: primarytheme,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      getUserData(userId).then((String s) => setState(() {
                            company = s;
                          }));
                      fetchData(company).then((bool b) => setState(() {
                            result = b;
                          }));
                      if (result == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobPosting()));
                      }
                      else
                      {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Company not Verified'),
                          behavior: SnackBarBehavior
                              .floating,
                          margin:
                          EdgeInsets.fromLTRB(10, 20, 10, 20),
                        ));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(254, 190, 175, 254)),
                    child: Text(
                      "A Job",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        color: primarytheme,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      getUserData(userId).then((String s) => setState(() {
                            company = s.toLowerCase();
                          }));
                      fetchData(company).then((bool b) => setState(() {
                            result = b;
                          }));
                      if (result == true) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JobPosting()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(250, 255, 225, 213)),
                    child: Text(
                      "An Internship",
                      style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w700,
                        color: primarytheme,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Applicants',
                  textAlign: TextAlign.left,
                  style: GoogleFonts.dmSans(
                    fontWeight: FontWeight.w700,
                    color: primarytheme,
                    fontSize: 15,
                  ),
                ),
              ),

              Container(
                child: FutureBuilder<String>(
                  future: getFieldValue(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text('Error: ${snapshot.error}'),
                      );
                    }
                    final fieldValue = snapshot.data;


                    return StreamBuilder<QuerySnapshot>(
                        stream: ref.where('company',
                            isEqualTo: fieldValue) // Replace 'field_name' with the actual field name you want to filter on
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // Convert QuerySnapshot to a list of DocumentSnapshots
                          final List<DocumentSnapshot> documents = snapshot
                              .data!.docs;

                          if (documents.isEmpty) {
                            return Center(
                              child: Text('No Applicants.'),
                            );
                          }
                          return
                            Padding(
                              padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
                              child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: documents.length,
                                  itemBuilder: (_, index) {
                                    //bool expanded = false;
                                    final Map<String,
                                        dynamic> data = documents[index]
                                        .data() as Map<String, dynamic>;
                                    return Padding(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
                                      child: Align(
                                          child: SingleChildScrollView(
                                            child: Column(children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.12),
                                                      spreadRadius: 2,
                                                      blurRadius: 3,
                                                      offset:
                                                      Offset(1,
                                                          2), // changes position of shadow
                                                    ),
                                                  ],
                                                  color: Colors.white,
                                                  shape: BoxShape.rectangle,
                                                  borderRadius: BorderRadius.all(
                                                      Radius.circular(15.0)),
                                                ),
                                                child: Card(
                                                  elevation: 0,
                                                  color: Colors.white,
                                                  child: Column(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .start,
                                                    crossAxisAlignment: CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Icon(
                                                              Icons.person,
                                                              size: 30.0,
                                                              color: Colors.black,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            data['candidate_name'],
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .width *
                                                                    0.048),
                                                          ),
                                                          Spacer(),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Icon(
                                                              Icons
                                                                  .bookmark_border_outlined,
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
                                                        padding: const EdgeInsets
                                                            .fromLTRB(
                                                            10, 0, 0, 0),
                                                        child: Row(
                                                          children: [
                                                            Text("Role - ",
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  fontWeight: FontWeight
                                                                      .w500,
                                                                  color: Color
                                                                      .fromARGB(
                                                                      254, 190,
                                                                      175, 254),
                                                                  fontSize:
                                                                  MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .width *
                                                                      0.038),
                                                            ),
                                                            Text(
                                                              data['role'],
                                                              style: GoogleFonts
                                                                  .poppins(
                                                                  fontWeight: FontWeight
                                                                      .w500,
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize:
                                                                  MediaQuery
                                                                      .of(context)
                                                                      .size
                                                                      .width *
                                                                      0.038),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets
                                                            .only(left: 7),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor: peachtheme,
                                                            shadowColor: Colors
                                                                .grey,
                                                            elevation: 3,
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    32.0)),
                                                            minimumSize: Size(
                                                                50,
                                                                30), //////// HERE
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (
                                                                        context) =>
                                                                        ViewApplicantProfile(
                                                                            id: data['id'])));
                                                          },
                                                          child: Text(
                                                            'View Profile',
                                                            style: GoogleFonts
                                                                .poppins(
                                                                fontWeight: FontWeight
                                                                    .w600,
                                                                color: Colors
                                                                    .black,
                                                                fontSize: MediaQuery
                                                                    .of(context)
                                                                    .size
                                                                    .width *
                                                                    0.035),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ]),
                                          )),
                                    );
                                  }),
                            );
                        }
                    );
                  })
              )
            ],
          ),
        ));
  }

  Future<String> getFieldValue() async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .get();

      if (snapshot.exists) {
        // Extract the field value from the document
        final fieldValue = snapshot.get('company_name');
        return fieldValue.toString();
      } else {
        return 'Document not found';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}


Future<String> getUserData(String? userId) async {
  try {
    final userSnapshot = await firestore.collection('Users').doc(userId).get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.get('company_name');
      // Process or use the userData
      return userData.toString();
    } else {
      return 'User not found';
    }
  } catch (error) {
    return 'Error retrieving user data: $error';
  }
}


Future<bool> fetchData(String company) async {
  String companyCrunch = company.toLowerCase().replaceAll(" ", "-");
  final response = await http.get(Uri.parse(
      'https://api.crunchbase.com/api/v4/entities/organizations/${companyCrunch}?card_ids=founders,raised_funding_rounds&field_ids=categories,short_description,rank_org_company,founded_on,website,facebook,created_at&user_key=dccd0a325bffd426fd388998e20476b6'));
  final mca_response = await http.get(Uri.parse(
      "https://api.data.gov.in/catalog/ec58dab7-d891-4abb-936e-d5d274a6ce9b?api-key=579b464db66ec23bdd00000175cd4f1a6fd34d7974a6f1889f669e37&format=json&filters%5Bcompany_name%5D=${company}"));
  if (response.statusCode == 200) {
    return true;
  } else {
    if (mca_response.statusCode == 200) {
      Map data = jsonDecode(mca_response.body);
      if (data["records"].length != 0) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}
