import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/chat/chat_page.dart';
import 'package:secure_job_portal/screens/homepage/student/mainpage.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/add_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/edit_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/profilepage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class ChatHomePage extends StatefulWidget {
  const ChatHomePage({super.key});

  @override
  State<ChatHomePage> createState() => _ChatHomePageState();
}

class _ChatHomePageState extends State<ChatHomePage> {
  final currentUser = FirebaseAuth.instance.currentUser;
  final ref = FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser?.uid).collection('work_exp');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: TextButton(
          style: TextButton.styleFrom(iconColor: Colors.indigo[900]),
          child: Icon(
            Icons.arrow_back,
            size: 23,
          ),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => mainpage())),
        ),
        title: Text("Chats",
          style: TextStyle(
              fontFamily: 'Playfair Display',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.indigo[900]),
        ),
      ),
      body: _buildUserList(),

    );
  }

  Widget _buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('Users').snapshots(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return const Text('error');
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: ListView(
            children: snapshot.data!.docs
                .map<Widget>((doc) => _buildUserListItem(doc))
                .toList(),
          ),
        );
      }
    );
  }

  Widget _buildUserListItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

    if(currentUser!.email != data['email']) {
      return Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 25,
              child: Image.asset(
                "assets/images/profile.png",
                height: 42,
                width: 42,
              ),
              backgroundColor: secondarytheme,
            ),
            title: Text(
              data['email'],
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage(receiverUserEmail: data['email'], receiverUserID: data['uid']),),);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      );
    }
    else {
      return Container();
    }
  }
}
