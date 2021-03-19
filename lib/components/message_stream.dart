import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bubble_message.dart';

class MessageStream extends StatelessWidget {
  final stream;
  final User loggedInUser;
  final scrollController;

  MessageStream({this.stream, this.loggedInUser, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final messages = snapshot.data.docs;
          messages
              .sort((a, b) => a.data()['timestamp'] - b.data()['timestamp']);
          List<BubbleMessage> bubbleMessages = [];

          for (var message in messages) {
            final messageText = message.data()['text'];
            final messageSender = message.data()['sender'];

            bubbleMessages.add(BubbleMessage(
              text: messageText,
              sender: messageSender,
              isMe: messageSender == loggedInUser.email,
            ));
          }

          return Expanded(
            child: ListView(
              children: bubbleMessages,
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              controller: scrollController,
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      },
    );
  }
}
