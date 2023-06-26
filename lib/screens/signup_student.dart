import 'package:firebase_auth/firebase_auth.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';
import 'package:secure_job_portal/screens/home.dart';
import 'package:secure_job_portal/screens/signin_student.dart';
import 'package:secure_job_portal/screens/signup_company.dart';
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
  String UserType = "";
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
                        UserType = "Student";},
                        child: Text("Student"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.indigo[900],
                          side: BorderSide(color: Colors.indigo.shade900, width: 1),
                          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                        ),
                      )
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: FilledButton(onPressed: () {
                        UserType = "Company";
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignUpComScreen()),
                        );
                      },child: Text("Company"),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.indigo[900],
                          backgroundColor: Colors.white,
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
                reusableTextContainer("Email", MediaQuery.of(context).size.width),
                reusableTextField("Enter Email", false,
                    _emailTextController),
                const SizedBox(
                  height: 20,
                ),
                reusableTextContainer("Password", MediaQuery.of(context).size.width),
                reusableTextField("Enter Password", true,
                    _passwordTextController),
                const SizedBox(
                  height: 20,
                ),

                firebaseUIButton(context, "Sign Up", () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                      .then((value) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
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
                MaterialPageRoute(builder: (context) => SignInStuScreen()));
          },
          child: const Text(
            " Sign In",
            style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

}