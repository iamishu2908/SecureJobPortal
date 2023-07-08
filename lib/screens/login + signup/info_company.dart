import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/home.dart';
import 'package:flutter/material.dart';

class InfoComScreen extends StatefulWidget {
  const InfoComScreen({Key? key}) : super(key: key);

  @override
  _InfoComScreenState createState() => _InfoComScreenState();
}

class _InfoComScreenState extends State<InfoComScreen> {
  TextEditingController _linkedInTextController = TextEditingController();
  TextEditingController _websiteTextController = TextEditingController();
  TextEditingController _locationTextController = TextEditingController();
  TextEditingController _comTypeTextController = TextEditingController();
  TextEditingController _industryTypeTextController = TextEditingController();
  TextEditingController _twitterTextController = TextEditingController();
  TextEditingController _aboutComTextController = TextEditingController();
  String UserType = "company";

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
                  child: Text("Let's get started by setting up your profile",
                    style: TextStyle(color: Colors.black87,
                        fontWeight: FontWeight.w300,
                        fontSize: 15),

                  ),
                ),
                const SizedBox(
                  height: 45,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("LinkedIn*", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Website", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),

                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("www.linkedin.com", false,
                            _linkedInTextController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("www.website.com", false,
                            _websiteTextController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Location*", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Company Type*", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),

                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("Enter Location", false,
                            _locationTextController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("Enter Type", false,
                            _comTypeTextController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Twitter", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Industry Type*", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("www.twitter.com/", false,
                            _twitterTextController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("Enter Type", false,
                            _industryTypeTextController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer("About Company", MediaQuery.of(context).size.width),
                reusableTextField("Explain what your company does...", false,
                    _aboutComTextController),
                const SizedBox(
                  height: 25,
                ),

                firebaseUIButton(context, "SAVE", () {
                    addComDetails(
                        _linkedInTextController.text,
                      _websiteTextController.text,
                      _locationTextController.text,
                      _comTypeTextController.text,
                      _twitterTextController.text,
                      _industryTypeTextController.text,
                      _aboutComTextController.text
                    )
                  .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
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


  Future addComDetails(String linkedin, String website, String location, String comType, String twitter, String industryType, String aboutCom) async {
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).set({
      'linkedin' : linkedin,
      'website' : website,
      'location' : location,
      'company_type' : comType,
      'twitter' : twitter,
      'industry_type' : industryType,
      'about_company' : aboutCom
    }, SetOptions(merge: true));
  }

}