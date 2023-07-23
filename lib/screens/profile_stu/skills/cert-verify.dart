import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import '../../../utils/color_utils.dart';
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
  Future<void> _makeSecureRequest() async {
    print('inside');
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
          // Get the first document (you can choose how to handle multiple matches)
          DocumentSnapshot docSnapshot = await querySnapshot.docs[0];

          // Step 2: Use the `update` method to modify the document's fields
          docSnapshot.reference.update({
            'isVerified': true,
            // Add other fields and their updated values here
          });
        }
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddSkill()),
        );
      } else {
        // Request failed, handle the error here
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Error occurred during the request, handle the exception here
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    skill = widget.skill;
    print('hello');
    return Scaffold(
        appBar: AppBar(
          title: const Text("Certificate Verfication"),
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
                  labelText: 'Enter your text', // Label text for the input
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
                onPressed: _makeSecureRequest, child: const Text("Verify"))
          ]),
        ));
  }
}
