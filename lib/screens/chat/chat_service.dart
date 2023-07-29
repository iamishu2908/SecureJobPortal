import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:secure_job_portal/screens/chat/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverID, String message) async {

    final String currentUserId = auth.currentUser!.uid;
    final String currentUserEmail = auth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();

    Message newMessage = Message(
      senderId: currentUserId,
      senderEmail: currentUserEmail,
      receiverId: receiverID,
      timestamp: timestamp,
      message: message,
    );

    List<String> ids = [currentUserId, receiverID];
    ids.sort();
    String chatRoomId = ids.join("_");

    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId).set({'created': "yes"});

    await firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoomId = ids.join("_");

    return firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}