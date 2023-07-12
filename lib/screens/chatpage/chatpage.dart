import 'package:flutter/material.dart';
import 'package:secure_job_portal/screens/chatpage/ChatModel.dart';
import 'package:secure_job_portal/screens/chatpage/customcard.dart';

class chatpage extends StatefulWidget {
  chatpage({this.chatmodels, this.sourchat});
  final List<ChatModel>? chatmodels;
  final ChatModel? sourchat;

  @override
  State<chatpage> createState() => _chatpageState();
}

class _chatpageState extends State<chatpage> {
  List<ChatModel> chatmodels = [
    ChatModel(
        name: "Ishwarya",
        currentMessage: "Hi Everyone",
        time: "4:00",
        icon: "assets/images/profile.png",
        id: '2fn0mWDaIVTC2AfDtnwqK2ugA4r2'),
    // ChatModel(
    //   name: "Kishor",
    //   currentMessage: "Hi Kishor",
    //   time: "13:00",
    //   icon: "assets/images/profile.png",
    //   id: 'ababaaa',
    // ),

    // ChatModel(
    //   name: "testabc",
    //   currentMessage: "Hi Dev Stack",
    //   time: "8:00",
    //   icon: "assets/images/profile.png",
    //   id: 'vy1vccMZW8UjSL8D66LqbDe8DWE3',
    // ),

    // ChatModel(
    //   name: "Balram Rathore",
    //   currentMessage: "Hi Dev Stack",
    //   time: "2:00",
    //   icon: "assets/images/profile.png",
    //   id: 'ababa',
    // ),

    // ChatModel(
    //   name: "NodeJs Group",
    //   isGroup: true,
    //   currentMessage: "New NodejS Post",
    //   time: "2:00",
    //   icon: "group.svg",
    // ),
  ];
  @override
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
