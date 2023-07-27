import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/info_student.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_student.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signup_company.dart';
import 'package:flutter/material.dart';

class SignUpStuScreen extends StatefulWidget {
  const SignUpStuScreen({Key? key}) : super(key: key);

  @override
  _SignUpStuScreenState createState() => _SignUpStuScreenState();
}

class _SignUpStuScreenState extends State<SignUpStuScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  String UserType = "student";

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(color: Colors.white24),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.15, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Create an Account",
                    style: TextStyle(
                        color: Colors.indigo[900],
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
                      Expanded(
                          child: OutlinedButton(
                        onPressed: () {
                          UserType = "student";
                        },
                        child: Text("Student"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo[900],
                          side: BorderSide(
                              color: Colors.indigo.shade900, width: 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      )),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: FilledButton(
                        onPressed: () {
                          UserType = "company";
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpComScreen()),
                          );
                        },
                        child: Text("Company"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.indigo[900],
                          backgroundColor: Colors.white,
                          side: BorderSide(
                              color: Colors.indigo.shade900, width: 1),
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                reusableTextContainer(
                    "Your Name", MediaQuery.of(context).size.width),
                reusableTextField("Enter Name", false, _nameTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer(
                    "Email", MediaQuery.of(context).size.width),
                reusableTextField("Enter Email", false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer(
                    "Password", MediaQuery.of(context).size.width),
                reusableTextField(
                    "Enter Password", true, _passwordTextController),
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
                    );
                  }).then((value) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InfoStuScreen()));
                  }).onError((error, stackTrace) async {
                    if (error.toString() ==
                        '[firebase_auth/email-already-in-use] The email address is already in use by another account.') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email already registered.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    else if (_isEmailValid(_emailTextController.text.trim()) ==
                        false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email format not valid.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    if (_passwordTextController.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Password should be at least 6 characters.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    print("Error: ${error.toString()}");
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
                MaterialPageRoute(builder: (context) => SignInStuScreen()));
          },
          child: const Text(
            " Sign In",
            style: TextStyle(
                color: Colors.orangeAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Future addUserDetails(String userType, String email, String name) async {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .set({'user_type': userType, 'email': email, 'name': name, 'about_me': ''});
  }
}
