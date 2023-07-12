import 'package:secure_job_portal/screens/chatpage/ChatModel.dart';
import 'package:secure_job_portal/screens/chatpage/individualPage.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/utils/color_utils.dart';

import 'ChatModel.dart';

class customCard extends StatelessWidget {
  customCard({this.chatModel, this.sourchat});
  final ChatModel? chatModel;
  final ChatModel? sourchat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => IndividualPage(
                      chatModel: chatModel,
                      sourchat: sourchat,
                    )));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Image.asset(
                "assets/images/profile.png",
                height: 36,
                width: 36,
              ),
              backgroundColor: primarytheme,
            ),
            title: Text(
              chatModel!.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatModel!.currentMessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            trailing: Text(chatModel!.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
