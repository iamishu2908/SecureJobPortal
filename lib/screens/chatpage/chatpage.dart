import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/screens/chatpage/ChatModel.dart';
import 'package:secure_job_portal/screens/chatpage/customcard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class chatpage extends StatefulWidget {
  chatpage({this.chatmodels, this.sourchat});
  final List<ChatModel>? chatmodels;
  final ChatModel? sourchat;

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  List<ChatModel> chatmodels = [];
  @override
  void initState() {
    super.initState();
    fetchChatModels();
  }

  void fetchChatModels() async {
    // Retrieve the current user
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      await Firebase.initializeApp();

      // Retrieve user details from Firestore
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('users_msg').get();
      querySnapshot.docs.forEach((doc) {
        String name = doc['name'];
        String currentMessage = doc['currentmsg'];
        String time = doc['time'];
        String icon = doc['icon'];
        String id = doc.id;

        ChatModel chatModel = ChatModel(
          name: name,
          currentMessage: currentMessage,
          time: time,
          icon: icon,
          id: id,
        );

        setState(() {
          chatmodels.add(chatModel);
        });
        print(chatmodels);
      });
    }
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        itemCount: chatmodels.length,
        itemBuilder: (contex, index) => customCard(
          chatModel: chatmodels[index],
          sourchat: chatmodels.removeAt(index),
        ),
      ),
    );
  }
}
