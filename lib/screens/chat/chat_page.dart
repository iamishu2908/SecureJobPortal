import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secure_job_portal/screens/chat/chat_bubble.dart';
import 'package:secure_job_portal/screens/chat/chat_service.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/add_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/work_exp/edit_experience.dart';
import 'package:secure_job_portal/screens/profile_stu/profilepage.dart';
import 'package:secure_job_portal/utils/color_utils.dart';
import 'package:secure_job_portal/reusable_widgets/reusable_widget.dart';

class ChatPage extends StatefulWidget {
  final String receiverUserName;
  final String receiverUserID;
  const ChatPage(
      {super.key,
      required this.receiverUserName,
      required this.receiverUserID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white70,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: primarytheme,
          leadingWidth: 80,
          titleSpacing: 5,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: 24,
                ),
                CircleAvatar(
                  child: Image.asset(
                    "assets/images/profile.png",
                    height: 36,
                    width: 36,
                  ),
                  radius: 20,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.all(6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.receiverUserName,
                    style: TextStyle(
                      fontSize: 18.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: _buildMessageList(),
          ),
          _buildMessageInput(),
          const SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
        stream: _chatService.getMessages(
            widget.receiverUserID, auth.currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error' + snapshot.error.toString());
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('Loading..');
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            child: ListView(
              children: snapshot.data!.docs
                  .map((document) => _buildMessageItem(document))
                  .toList(),
            ),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    print(data);

    var alignment = (data['senderId'] == auth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            mainAxisAlignment: (data['senderId'] == auth.currentUser!.uid)
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Text(data['senderEmail']),
              const SizedBox(height: 5),
              ChatBubble(message: data['message']),
            ],
          ),
        ));
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Expanded(
            child: Card(
                margin: EdgeInsets.only(left: 2, right: 2, bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  child: TextFormField(
                    controller: _messageController,
                    obscureText: false,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Type a message",
                      hintStyle: TextStyle(color: Colors.grey),
                      contentPadding: EdgeInsets.all(5),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            width: 5,
          ),
          CircleAvatar(
              radius: 23,
              backgroundColor: primarytheme,
              child: IconButton(
                onPressed: sendMessage,
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
              ))
        ],
      ),
    );
  }
}
