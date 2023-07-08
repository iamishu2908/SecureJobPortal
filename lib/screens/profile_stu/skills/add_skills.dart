import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSkill extends StatefulWidget {
  const AddSkill({super.key});

  @override
  State<AddSkill> createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('skills');
  String searchResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          style: TextButton.styleFrom(iconColor: Colors.indigo[900]),
          child: Icon(
            Icons.arrow_back,
            size: 23,
          ),
          onPressed: () {
            // Perform navigation
            Navigator.pop(context);
          },
        ),
        title: Text("Skills",
          style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900]),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              final result = await showSearch(context: context, delegate: CustomSearchDelegate());
              setState(() {
                searchResult = result;
                FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('skills').
                add({
                  'skill': result.toString(),
                });
              });
            },
            color: Colors.indigo[900]
            , icon: const Icon(Icons.add),
            iconSize: 30,
          ),
        ],
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
                            },
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0,10,0,0),
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
                                    child: Text(
                                      (snapshot.data!.docs.elementAt(index).data() as Map)['skill'].toString(),
                                      style: GoogleFonts.dmSans(
                                          fontWeight: FontWeight.w300,
                                          color: Colors.black,
                                          fontSize: 20,)
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
    for(var skill in searchTerms) {
      if(skill.toLowerCase().contains(query.toLowerCase())) {
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
    for(var skill in searchTerms) {
      if(skill.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(skill);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
            onTap: () {close(context, result);}
        );
      },
    );
    //throw UnimplementedError();
  }
}
