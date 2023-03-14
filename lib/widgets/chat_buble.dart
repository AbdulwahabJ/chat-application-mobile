// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../constent.dart';
import '../models/message.dart';

class ChatBubule extends StatelessWidget {
  ChatBubule({
    required this.message,
    super.key,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 16, top: 16, bottom: 16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}

class ChatBubuleForFriend extends StatelessWidget {
  ChatBubuleForFriend({
    required this.message,
    super.key,
  });
  final Message message;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 14, right: 16, top: 16, bottom: 16),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
            color: Color(0xff006D84),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: Text(
          message.message,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
