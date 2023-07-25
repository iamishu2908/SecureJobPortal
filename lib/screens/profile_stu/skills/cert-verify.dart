import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
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
  String username = "";

  Future<void> _makeSecureRequest() async {
    try {
      final http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection("Users")
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('skills')
            .where('skill', isEqualTo: skill)
            .get();
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
                decoration: const InputDecoration(
                  labelText: 'certificate url',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {
                    url = value;
                  });
                },
              ),
            ),
            TextButton(
                onPressed: _makeSecureRequest, child: const Text("Verify")),
          ]),
        ));
  }
}
