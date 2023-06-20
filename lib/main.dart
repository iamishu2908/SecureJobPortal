import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:secure_job_portal/screens/signin_student.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  runApp(MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SignInStuScreen(),
    );
  }
}
