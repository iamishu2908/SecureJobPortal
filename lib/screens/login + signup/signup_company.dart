import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/home.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/info_company.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_company.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signup_student.dart';
import 'package:flutter/material.dart';

class SignUpComScreen extends StatefulWidget {
  const SignUpComScreen({Key? key}) : super(key: key);

  @override
  _SignUpComScreenState createState() => _SignUpComScreenState();
}

class _SignUpComScreenState extends State<SignUpComScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _comNameTextController = TextEditingController();
  TextEditingController _designationTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
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
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text("Create an Account",
                    style: TextStyle(color: Colors.indigo[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 30),

                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(child: OutlinedButton(onPressed: () {
                        UserType = "student";
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpStuScreen()),
                        );
                        },
                        child: Text("Student"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.indigo[900],
                          backgroundColor: Colors.white,
                          side: BorderSide(color: Colors.indigo.shade900, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: FilledButton(onPressed: () {
                        UserType = "company";
                      },child: Text("Company"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo[900],
                          side: BorderSide(color: Colors.indigo.shade900, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                reusableTextContainer("Your Name", MediaQuery.of(context).size.width),
                reusableTextField("Enter Name", false,
                    _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Company Name", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Designation", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: reusableTextField("Enter Company", false,
                          _comNameTextController),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child:reusableTextField("Enter Designation", false,
                        _designationTextController),
                    ),
                  ]),
                const SizedBox(
                  height: 20,
                ),
                Row(
                    children: <Widget>[
                      reusableTextContainer("Email", MediaQuery.of(context).size.width * 0.46),
                      reusableTextContainer("Password", MediaQuery.of(context).size.width * 0.4),
                    ]
                ),
                Row(
                    children: <Widget>[
                      Expanded(
                        child: reusableTextField("Enter Email", false,
                            _emailTextController),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child:reusableTextField("Enter Password", true,
                            _passwordTextController),
                      ),
                    ]),
                const SizedBox(
                  height: 20,
                ),

                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    addUserDetails(
                      UserType,
                      _emailTextController.text,
                      _nameTextController.text,
                      _comNameTextController.text,
                      _designationTextController.text
                    );
                  }).then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => InfoComScreen()));
                  }).onError((error, stackTrace) {
                    print("Error ${error.toString()}");
                  });
                }),
                signInOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Already have an account?",
            style: TextStyle(color: Colors.indigo[900])),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInComScreen()));
          },
          child: const Text(
            " Sign In",
            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future addUserDetails(String userType, String email, String name, String comName, String desig) async {
    await FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser?.uid).set({
      'user_type' : userType,
      'email' : email,
      'name' : name,
      'company_name' : comName,
      'designation' : desig
    });
  }

}