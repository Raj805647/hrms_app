import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatProvider extends BaseProvider {
  final TextEditingController messageController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  bool isTyping = false;
  String searchQuery = "";

  List<Map<String, dynamic>> chats = [
    {
      "id": "1",
      "name": "John Doe",
      "message": "Good Morning",
      "time": "09:20 AM",
      "online": true,
      "unread": 2,
      "avatar": "JD",
      "typing": false,
    },
    {
      "id": "2",
      "name": "HR Team",
      "message": "Meeting at 3 PM",
      "time": "08:10 AM",
      "online": false,
      "group": true,
      "unread": 5,
      "avatar": "HR",
      "members": 8,
    },
    {
      "id": "3",
      "name": "Sarah Johnson",
      "message": "Can you review my code?",
      "time": "Yesterday",
      "online": true,
      "unread": 0,
      "avatar": "SJ",
    },
    {
      "id": "4",
      "name": "Development Team",
      "message": "Sprint planning at 2 PM",
      "time": "Yesterday",
      "online": false,
      "group": true,
      "unread": 12,
      "avatar": "DT",
      "members": 12,
    },
  ];

  List<Map<String, dynamic>> messages = [
    {
      "id": "1",
      "message": "Hello",
      "isMe": true,
      "seen": true,
      "time": "09:10 AM",
      "delivered": true,
    },
    {
      "id": "2",
      "message": "Hi there! How can I help you?",
      "isMe": false,
      "seen": true,
      "time": "09:11 AM",
      "delivered": true,
    },
    {
      "id": "3",
      "message": "I need help with the attendance module",
      "isMe": true,
      "seen": true,
      "time": "09:12 AM",
      "delivered": true,
    },
    {
      "id": "4",
      "message": "Sure, I'll help you with that. Let me check the documentation.",
      "isMe": false,
      "seen": true,
      "time": "09:13 AM",
      "delivered": true,
    },
  ];

  List<Map<String, dynamic>> get filteredChats {
    if (searchQuery.isEmpty) return chats;
    return chats.where((chat) =>
    chat["name"].toLowerCase().contains(searchQuery.toLowerCase()) ||
        chat["message"].toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }

  void sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    messages.add({
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "message": messageController.text,
      "isMe": true,
      "seen": false,
      "delivered": false,
      "time": DateFormat('hh:mm a').format(DateTime.now()),
    });

    messageController.clear();
    isTyping = false;
    notifyListeners();

    // Simulate reply after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      _simulateReply();
    });
  }

  void _simulateReply() {
    messages.add({
      "id": DateTime.now().millisecondsSinceEpoch.toString(),
      "message": "Thanks for your message! I'll get back to you shortly.",
      "isMe": false,
      "seen": true,
      "delivered": true,
      "time": DateFormat('hh:mm a').format(DateTime.now()),
    });
    notifyListeners();
  }

  void updateTyping(bool value) {
    isTyping = value;
    notifyListeners();
  }

  void updateSearch(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void markAsRead(String chatId) {
    final index = chats.indexWhere((chat) => chat["id"] == chatId);
    if (index != -1) {
      chats[index]["unread"] = 0;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    searchController.dispose();
    super.dispose();
  }
}