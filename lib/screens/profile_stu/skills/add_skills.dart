import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/profile_stu/skills/cert_verify.dart';
import '../../../utils/color_utils.dart';
import '../skills/skill_test.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseFirestore.instance
      .collection("Users")
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('skills');

  String searchResult = '';

  @override
  Widget build(BuildContext context) {
    final reference = ref.doc();
    print(reference);
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          style: TextButton.styleFrom(iconColor: Colors.indigo[900]),
          child: const Icon(
            Icons.arrow_back,
            size: 23,
          ),
          onPressed: () {
            // Perform navigation
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Skills",
          style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900]),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showSearch(
                  context: context, delegate: CustomSearchDelegate());
              setState(() async {
                searchResult = result;
                QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("Users")
                    .doc(FirebaseAuth.instance.currentUser?.uid)
                    .collection('skills')
                    .where('skill', isEqualTo: result.toString())
                    .get();

                if (querySnapshot.docs.isEmpty) {
                  FirebaseFirestore.instance
                      .collection("Users")
                      .doc(FirebaseAuth.instance.currentUser?.uid)
                      .collection('skills')
                      .add({
                    'skill': result.toString(),
                    'isVerified': false,
                  });
                }
              });
            },
            color: Colors.indigo[900],
            icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: StreamBuilder(
            stream: ref.snapshots(),
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
                              padding: const EdgeInsets.all(10.0),
                              child: Card(
                                elevation: 0,
                                color: Colors.white,
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  //crossAxisAlignment: CrossAxisAlignment.start,
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
                                    TextButton(
                                      onPressed: () => {
                                        if ((snapshot.data!.docs
                                                        .elementAt(index)
                                                        .data()
                                                    as Map)['isVerified']
                                                .toString() ==
                                            'false')
                                          {
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (ctx) => AlertDialog(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius
                                                            .circular(20)),
                                                    elevation: 16,
                                                    content: Padding(
                                                      padding:
                                                          const EdgeInsets
                                                              .all(8.0),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                                                                backgroundColor:
                                                                MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(18.0),
                                                                    ))),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              SkillTest(skill: (snapshot.data!.docs.elementAt(index).data() as Map)['skill'])));
                                                            },
                                                            child: Text(
                                                              'Take the skill questionnaire',
                                                              textAlign: TextAlign.left,
                                                              style: GoogleFonts.dmSans(
                                                                fontWeight: FontWeight.w800,
                                                                color: whitetheme,
                                                                fontSize: 12,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text("OR",
                                                              textAlign: TextAlign.left,
                                                              style: GoogleFonts.dmSans(
                                                                fontWeight: FontWeight.w800,
                                                                color: primarytheme,
                                                                fontSize: 14,
                                                              ),),
                                                          ),
                                                          ElevatedButton(
                                                            style: ButtonStyle(
                                                                minimumSize: MaterialStateProperty.all<Size>(Size(60, 50)),
                                                                backgroundColor:
                                                                MaterialStateProperty.all<Color>(Colors.indigo.shade900),
                                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                                    RoundedRectangleBorder(
                                                                      borderRadius: BorderRadius.circular(18.0),
                                                                    ))),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              CertificateVerification(skill: (snapshot.data!.docs.elementAt(index).data() as Map)['skill'])));
                                                            },
                                                            child: Text(
                                                                'Verify through Certificates',
                                                              textAlign: TextAlign.left,
                                                              style: GoogleFonts.dmSans(
                                                                fontWeight: FontWeight.w800,
                                                                color: whitetheme,
                                                                fontSize: 12,
                                                              ),),
                                                          ),
                                                        ],
                                                      ),
                                                    )))
                                          }
                                        else
                                          {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        'Skill already verified'),
                                                    behavior: SnackBarBehavior
                                                        .floating,
                                                    margin:
                                                        EdgeInsets.fromLTRB(10, 20, 10, 20),
                                                        ))
                                          }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: (snapshot.data!.docs
                                                            .elementAt(index)
                                                            .data()
                                                        as Map)['isVerified']
                                                    .toString() ==
                                                'false'
                                            ? Colors.indigo[900]
                                            : Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                      ),
                                      child: Text(
                                          (snapshot.data!.docs
                                                              .elementAt(index)
                                                              .data() as Map)[
                                                          'isVerified']
                                                      .toString() ==
                                                  'false'
                                              ? "Take the Skill Test"
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
                                                  ? Colors.white
                                                  : Colors.green[500],
                                              fontSize: 12)),
                                    ),
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

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchTerms = [
    'Java',
    'C++',
    'Python',
    'Flutter',
    'Firebase',
    'React',
    'JavaScript',
    'Figma',
    'HTML',
    'CSS',
  ];

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: Colors.indigo[900],
      ),
    ];
    //throw UnimplementedError();
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
      color: Colors.indigo[900],
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<String> matchQuery = [];
    for (var skill in searchTerms) {
      if (skill.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(skill);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List<String> matchQuery = [];
    for (var skill in searchTerms) {
      if (skill.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(skill);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
            title: Text(result),
            onTap: () {
              close(context, result);
            });
      },
    );
    //throw UnimplementedError();
  }
}
