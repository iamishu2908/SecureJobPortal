import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/student/home.dart';
import 'package:flutter/material.dart';

class InfoStuScreen extends StatefulWidget {
  const InfoStuScreen({Key? key}) : super(key: key);

  @override
  _InfoStuScreenState createState() => _InfoStuScreenState();
}

class _InfoStuScreenState extends State<InfoStuScreen> {
  TextEditingController _domainTextController = TextEditingController();
  final ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('domains');
  String UserType = "student";
  String searchResult = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.white24
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.12, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("Welcome",
                    style: TextStyle(color: Colors.indigo[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 30),

                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text("What types of jobs are you interested in?",
                    style: TextStyle(color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 15),

                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                reusableTextContainer("Choose upto 5 Domains", MediaQuery.of(context).size.width),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _domainTextController,
                  onTap: () async {
                    final result = await showSearch(
                      context: context,
                      delegate: CustomSearchDelegate(),
                    );
                    setState(() {
                      searchResult = result!;
                      FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('domains').
                      add({
                        'domain': result.toString(),
                      });
                    });
                  },
                  //obscureText: isPasswordType,
                  //enableSuggestions: !isPasswordType,
                  autocorrect: true,
                  cursorColor: Colors.grey.shade500,
                  style: TextStyle(color: Colors.grey.shade600),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    labelText: 'Search Domain',
                    labelStyle: TextStyle(color: Colors.grey.shade500,
                        fontSize: 14),
                    filled: true,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1, style: BorderStyle.none),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(width: 1, style: BorderStyle.solid, color: Colors.indigo.shade900),
                    ),
                  ),
                  keyboardType: false
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                ),

                Container(
                  height: MediaQuery.of(context).size.height * 0.45,
                  color: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                  child: StreamBuilder(
                      stream: ref.snapshots(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(5,0,5,5),
                          child: ListView.builder(
                              itemCount: snapshot.hasData?(snapshot.data?.docs.length):0,
                              itemBuilder: (_,index) {
                                return GestureDetector(
                                  onTap: () {
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
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
                                              (snapshot.data!.docs.elementAt(index).data() as Map)['domain'].toString(),
                                              style: GoogleFonts.dmSans(
                                                fontWeight: FontWeight.w300,
                                                color: Colors.black,
                                                fontSize: 15,)
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
                const SizedBox(
                  height: 15,
                ),

                firebaseUIButton(context, "SAVE", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()))
                  .onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<String> searchTerms = [
    'Java Engineer',
    'C++ Programmer',
    'Flutter App Developer',
    'Mobile App Developer',
    'Frontend Developer',
    'Backend Developer',
    'Fullstack Developer',
    'UI/UX Developer',
    'AI/ML Developer',
    'Python Programmer',
    'Data Scientist',
    'Product Manager'
  ];

  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
        color: Colors.indigo[900],
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null!);
      },
      icon: const Icon(Icons.arrow_back),
      color: Colors.indigo[900],
    );
  }

  @override
  Widget buildResults(BuildContext context) {
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
  }

  @override
  Widget buildSuggestions(BuildContext context) {
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
  }
}