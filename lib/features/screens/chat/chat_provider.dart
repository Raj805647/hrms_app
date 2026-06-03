import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

class ChatProvider extends BaseProvider {

  final TextEditingController messageController =
  TextEditingController();

  bool isTyping = false;

  List<Map<String, dynamic>> chats = [
    {
      "name": "John Doe",
      "message": "Good Morning",
      "time": "09:20 AM",
      "online": true,
      "unread": 2,
    },
    {
      "name": "HR Team",
      "message": "Meeting at 3 PM",
      "time": "08:10 AM",
      "online": false,
      "group": true,
      "unread": 5,
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "message": "Hello",
      "isMe": true,
      "seen": true,
      "time": "09:10",
    },
    {
      "message": "Good Morning",
      "isMe": false,
      "time": "09:12",
    },
  ];

  void sendMessage() {
    if (messageController.text.trim().isEmpty) {
      return;
    }

    messages.add({
      "message": messageController.text,
      "isMe": true,
      "seen": false,
      "time": "Now",
    });

    messageController.clear();
    notifyListeners();
  }

  void updateTyping(bool value) {
    isTyping = value;
    notifyListeners();
  }
}