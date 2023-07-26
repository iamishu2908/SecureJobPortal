import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/homepage/student/home.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/reset_password.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signin_company.dart';
import 'package:secure_job_portal/screens/login%20+%20signup/signup_student.dart';
import 'package:flutter/material.dart';

class SignInStuScreen extends StatefulWidget {
  const SignInStuScreen({Key? key}) : super(key: key);

  @override
  _SignInStuScreenState createState() => _SignInStuScreenState();
}

class _SignInStuScreenState extends State<SignInStuScreen> {
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
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Container(
                  child: Text(
                    "Welcome Back",
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
                                builder: (context) => const SignInComScreen()),
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
                    "Email", MediaQuery.of(context).size.width),
                reusableTextField("Enter Email", false, _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer(
                    "Password", MediaQuery.of(context).size.width),
                reusableTextField(
                    "Enter Password", true, _passwordTextController),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                firebaseUIButton(context, "Sign In", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: _emailTextController.text,
                          password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  }).onError((error, stackTrace) {
                      if (error.toString() ==
                        '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Email not registered.'),
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
                    else if (_passwordTextController.text.length < 6) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Password should be at least 6 characters.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }
                    else if (error != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password or email is invalid'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                    print("Error ${error.toString()}");
                  });
                }),
                signUpOption()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have account?",
            style: TextStyle(color: Colors.indigo[900])),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpStuScreen()));
          },
          child: const Text(
            " Sign Up",
            style: TextStyle(
                color: Colors.orangeAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.indigo.shade900),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => ResetPassword())),
      ),
    );
  }
}
