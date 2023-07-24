import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import '../../../utils/color_utils.dart';
import 'dart:convert';
import 'add_skills.dart';

class CertificateVerification extends StatefulWidget {
  const CertificateVerification({super.key, required this.skill});
  final String skill;
  @override
  State<CertificateVerification> createState() =>
      _CertificateVerificationState();
}

class _CertificateVerificationState extends State<CertificateVerification> {
  String url = "";
  String skill = "";
  String username = "";

  Future<void> verifySkill() async {
    const String baseUrl = 'https://api.github.com';
    final String userReposEndpoint = '/users/$username/repos';

    try {
      final response = await http.get(Uri.parse(baseUrl + userReposEndpoint));
      if (response.statusCode == 200) {
        final List<dynamic> reposData = json.decode(response.body);
        List<String> usedLanguages = [];

        for (var repo in reposData) {
          if (repo['language'] != null) {
            usedLanguages.add(repo['language']);
          }
        }

        // Check if Flutter (Dart) is among the used languages
        if (usedLanguages.contains(skill) || (skill == 'Flutter' && usedLanguages.contains('Dart'))) {
          QuerySnapshot querySnapshot = await FirebaseFirestore.instance
              .collection("Users")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection('skills')
              .where('skill', isEqualTo: skill)
              .get();
          if (querySnapshot.docs.isNotEmpty && response.body.contains(skill)) {
            // Get the first document (you can choose how to handle multiple matches)
            DocumentSnapshot docSnapshot = await querySnapshot.docs[0];

            // Step 2: Use the `update` method to modify the document's fields
            docSnapshot.reference.update({
              'isVerified': true,
              // Add other fields and their updated values here
            });
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSkill()),
            );
          }
          print('User $username has Flutter-related repositories.');
        } else {
          // ignore: use_build_context_synchronously
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddSkill()),
            );
          print(
              'User $username does not have any Flutter-related repositories.');
        }
      } else {
        print(
            'Failed to fetch user repositories. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred while fetching user repositories: $e');
    }
  }

  Future<void> _makeSecureRequest() async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Request was successful, handle the response here
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('skills')
            .where('skill', isEqualTo: skill)
            .get();
        final dom.Document document = parser.parse(response.body);
        final String content = document.body?.text ?? '';
        if (querySnapshot.docs.isNotEmpty && response.body.contains(skill)) {
          DocumentSnapshot docSnapshot = await querySnapshot.docs[0];
          docSnapshot.reference.update({
            'isVerified': true,
          });
        }
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddSkill()),
        );
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    skill = widget.skill;
    print('hello');
    return Scaffold(
        appBar: AppBar(
          title: const Text("Certificate and Project Verfication"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(children: [
            Text(
              'Enter the url of your certificate in http format:',
              textAlign: TextAlign.left,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: primarytheme,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                // Customize the appearance and behavior of the TextField
                decoration: const InputDecoration(
                  labelText: 'certificate url', // Label text for the input
                  border: OutlineInputBorder(), // Border around the input
                ),
                onChanged: (value) {
                  // Callback function when the text input changes
                  setState(() {
                    url = value;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: _makeSecureRequest, child: const Text("Verify")),
            const SizedBox(height: 50.0),
            Text(
              'Enter the username of your github profile:',
              textAlign: TextAlign.left,
              style: GoogleFonts.dmSans(
                fontWeight: FontWeight.w700,
                color: primarytheme,
                fontSize: 20,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: TextField(
                // Customize the appearance and behavior of the TextField
                decoration: const InputDecoration(
                  labelText: 'username', // Label text for the input
                  border: OutlineInputBorder(), // Border around the input
                ),
                onChanged: (value) {
                  // Callback function when the text input changes
                  setState(() {
                    username = value;
                  });
                },
              ),
            ),
            TextButton(onPressed: verifySkill, child: const Text("Verify"))
          ]),
        ));
  }
}