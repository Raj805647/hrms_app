import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

class NotificationProvider extends BaseProvider {
  List<Map<String, dynamic>> notifications = [];
  int unreadCount = 0;
  String selectedFilter = "All";

  void init() {
    _loadNotifications();
  }

  void _loadNotifications() {
    notifications = [
      {
        "id": "1",
        "title": "Meeting Reminder",
        "message": "Team meeting in 30 minutes",
        "type": "reminder",
        "time": DateTime.now().subtract(const Duration(minutes: 15)),
        "isRead": false,
        "action": "join_meeting",
        "actionData": {"meetingId": "123"},
        "icon": Icons.videocam,
        "color": "blue",
      },
      {
        "id": "2",
        "title": "Leave Request Approved",
        "message": "Your leave request for Dec 25-27 has been approved",
        "type": "approval",
        "time": DateTime.now().subtract(const Duration(hours: 2)),
        "isRead": false,
        "action": "view_leave",
        "actionData": {"leaveId": "456"},
        "icon": Icons.event_available,
        "color": "green",
      },
      {
        "id": "3",
        "title": "New Task Assigned",
        "message": "You have been assigned a new task: Update UI components",
        "type": "task",
        "time": DateTime.now().subtract(const Duration(days: 1)),
        "isRead": true,
        "action": "view_task",
        "actionData": {"taskId": "789"},
        "icon": Icons.task,
        "color": "orange",
      },
      {
        "id": "4",
        "title": "Attendance Reminder",
        "message": "Don't forget to mark your attendance",
        "type": "reminder",
        "time": DateTime.now().subtract(const Duration(days: 1, hours: 5)),
        "isRead": true,
        "action": "mark_attendance",
        "actionData": {},
        "icon": Icons.fingerprint,
        "color": "purple",
      },
      {
        "id": "5",
        "title": "Salary Slip Generated",
        "message": "Your salary slip for December is ready to download",
        "type": "finance",
        "time": DateTime.now().subtract(const Duration(days: 2)),
        "isRead": false,
        "action": "download_salary",
        "actionData": {"month": "Dec"},
        "icon": Icons.receipt,
        "color": "red",
      },
    ];

    _updateUnreadCount();
    notifyListeners();
  }

  void _updateUnreadCount() {
    unreadCount = notifications.where((n) => n['isRead'] == false).length;
  }

  void markAsRead(String id) {
    final index = notifications.indexWhere((n) => n['id'] == id);
    if (index != -1) {
      notifications[index]['isRead'] = true;
      _updateUnreadCount();
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (var notification in notifications) {
      notification['isRead'] = true;
    }
    _updateUnreadCount();
    notifyListeners();
  }

  void deleteNotification(String id) {
    notifications.removeWhere((n) => n['id'] == id);
    _updateUnreadCount();
    notifyListeners();
  }

  void clearAll() {
    notifications.clear();
    unreadCount = 0;
    notifyListeners();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  List<Map<String, dynamic>> get filteredNotifications {
    if (selectedFilter == "All") return notifications;
    if (selectedFilter == "Unread") {
      return notifications.where((n) => n['isRead'] == false).toList();
    }
    return notifications.where((n) => n['type'] == selectedFilter.toLowerCase()).toList();
  }

  List<String> get filterOptions => ["All", "Unread", "Reminder", "Approval", "Task", "Finance"];
}