// lib/features/meeting/providers/meeting_provider.dart

import 'dart:async';
import 'package:base_module/providers/base_providers.dart';
import 'package:flutter/material.dart';

class MeetingProvider extends BaseProvider {
  // Current state
  List<Map<String, dynamic>> upcomingMeetings = [];
  List<Map<String, dynamic>> pastMeetings = [];
  List<Map<String, dynamic>> meetingRequests = [];
  Map<String, dynamic>? currentMeeting;

  // Timer for reminders
  Timer? reminderTimer;

  // Filters
  String selectedFilter = "All";
  String searchQuery = "";

  void init() {
    _loadSampleData();
    _startReminderChecker();
  }

  void _loadSampleData() {
    upcomingMeetings = [
      {
        "id": "1",
        "title": "Weekly Team Sync",
        "description": "Discuss weekly progress and blockers",
        "date": DateTime.now().add(const Duration(days: 1)),
        "startTime": "10:00 AM",
        "endTime": "11:00 AM",
        "duration": "1 hour",
        "host": "John Doe",
        "hostId": "1",
        "meetingLink": "https://meet.hrms.com/john-doe-123",
        "meetingId": "jdoe-123-xyz",
        "password": "123456",
        "participants": [
          {"name": "Sarah Chen", "email": "sarah@company.com", "status": "confirmed"},
          {"name": "Mike Johnson", "email": "mike@company.com", "status": "pending"},
          {"name": "Priya Sharma", "email": "priya@company.com", "status": "confirmed"},
        ],
        "status": "scheduled",
        "reminderSent": false,
        "recurring": "weekly",
        "color": "blue",
      },
      {
        "id": "2",
        "title": "Project Review Meeting",
        "description": "Review Q1 project deliverables",
        "date": DateTime.now().add(const Duration(days: 3)),
        "startTime": "02:00 PM",
        "endTime": "03:30 PM",
        "duration": "1.5 hours",
        "host": "HR Manager",
        "hostId": "2",
        "meetingLink": "https://meet.hrms.com/hr-team-456",
        "meetingId": "hr-456-abc",
        "password": "789012",
        "participants": [
          {"name": "John Doe", "email": "john@company.com", "status": "confirmed"},
          {"name": "Lisa Wong", "email": "lisa@company.com", "status": "confirmed"},
        ],
        "status": "scheduled",
        "reminderSent": false,
        "recurring": "none",
        "color": "green",
      },
      {
        "id": "3",
        "title": "Client Demo",
        "description": "Demo new features to client",
        "date": DateTime.now().add(const Duration(days: 5)),
        "startTime": "11:00 AM",
        "endTime": "12:00 PM",
        "duration": "1 hour",
        "host": "John Doe",
        "hostId": "1",
        "meetingLink": "https://meet.hrms.com/client-demo-789",
        "meetingId": "demo-789-def",
        "password": "345678",
        "participants": [
          {"name": "Client Team", "email": "client@external.com", "status": "invited"},
        ],
        "status": "scheduled",
        "reminderSent": false,
        "recurring": "none",
        "color": "orange",
      },
    ];

    pastMeetings = [
      {
        "id": "4",
        "title": "Sprint Planning",
        "date": DateTime.now().subtract(const Duration(days: 5)),
        "startTime": "10:00 AM",
        "duration": "2 hours",
        "host": "John Doe",
        "participants": 12,
        "recording": "https://meet.hrms.com/recording/123",
      },
      {
        "id": "5",
        "title": "HR Policy Update",
        "date": DateTime.now().subtract(const Duration(days: 10)),
        "startTime": "03:00 PM",
        "duration": "1 hour",
        "host": "HR Manager",
        "participants": 45,
        "recording": "https://meet.hrms.com/recording/456",
      },
    ];

    meetingRequests = [
      {
        "id": "6",
        "title": "Interview Round 2",
        "requester": "Tech Lead",
        "date": DateTime.now().add(const Duration(days: 2)),
        "time": "11:00 AM",
        "duration": "1 hour",
        "status": "pending",
      },
    ];

    notifyListeners();
  }

  void _startReminderChecker() {
    reminderTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _checkReminders();
    });
  }

  void _checkReminders() {
    final now = DateTime.now();
    for (var meeting in upcomingMeetings) {
      final meetingDate = meeting['date'] as DateTime;
      final diff = meetingDate.difference(now);

      // Send reminder 30 minutes before meeting
      if (diff <= const Duration(minutes: 30) &&
          diff > const Duration(minutes: 29) &&
          !meeting['reminderSent']) {
        meeting['reminderSent'] = true;
        notifyListeners();
        _showReminderNotification(meeting);
      }
    }
  }

  void _showReminderNotification(Map<String, dynamic> meeting) {
    // Show in-app notification
    // You can also use flutter_local_notifications package
    debugPrint("Reminder: Meeting '${meeting['title']}' starts in 30 minutes");
  }

  Future<void> scheduleMeeting(Map<String, dynamic> meetingData) async {
    setLoading(true);

    try {
      // Generate meeting link
      final meetingId = _generateMeetingId();
      final meetingLink = "https://meet.hrms.com/$meetingId";

      final newMeeting = {
        "id": DateTime.now().millisecondsSinceEpoch.toString(),
        "title": meetingData['title'],
        "description": meetingData['description'],
        "date": meetingData['date'],
        "startTime": meetingData['startTime'],
        "endTime": meetingData['endTime'],
        "duration": meetingData['duration'],
        "host": meetingData['host'],
        "hostId": meetingData['hostId'],
        "meetingLink": meetingLink,
        "meetingId": meetingId,
        "password": meetingData['password'],
        "participants": meetingData['participants'] ?? [],
        "status": "scheduled",
        "reminderSent": false,
        "recurring": meetingData['recurring'] ?? "none",
        "color": meetingData['color'] ?? "blue",
      };

      upcomingMeetings.insert(0, newMeeting);
      notifyListeners();

      // TODO: Send invitations to participants
      // await sendInvitations(newMeeting);

    } finally {
      setLoading(false);
    }
  }

  String _generateMeetingId() {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = DateTime.now().millisecondsSinceEpoch.toString();
    return "meet-${random.substring(random.length - 6)}";
  }

  void joinMeeting(Map<String, dynamic> meeting) {
    currentMeeting = meeting;
    notifyListeners();
    // Navigate to meeting room
  }

  void endMeeting() {
    if (currentMeeting != null) {
      // Add to past meetings
      pastMeetings.insert(0, {
        "id": currentMeeting!['id'],
        "title": currentMeeting!['title'],
        "date": DateTime.now(),
        "duration": "1 hour",
        "host": currentMeeting!['host'],
        "participants": currentMeeting!['participants']?.length ?? 0,
      });
      currentMeeting = null;
      notifyListeners();
    }
  }

  void cancelMeeting(String meetingId) {
    upcomingMeetings.removeWhere((meeting) => meeting['id'] == meetingId);
    notifyListeners();
  }

  void updateParticipantStatus(String meetingId, String participantEmail, String status) {
    final meetingIndex = upcomingMeetings.indexWhere((m) => m['id'] == meetingId);
    if (meetingIndex != -1) {
      final participants = upcomingMeetings[meetingIndex]['participants'] as List;
      final participantIndex = participants.indexWhere((p) => p['email'] == participantEmail);
      if (participantIndex != -1) {
        participants[participantIndex]['status'] = status;
        notifyListeners();
      }
    }
  }

  List<Map<String, dynamic>> getFilteredMeetings() {
    var filtered = upcomingMeetings;

    if (selectedFilter != "All") {
      filtered = filtered.where((m) => m['recurring'] == selectedFilter.toLowerCase()).toList();
    }

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((m) =>
      m['title'].toLowerCase().contains(searchQuery.toLowerCase()) ||
          m['host'].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  int getMeetingCountForDate(DateTime date) {
    return upcomingMeetings.where((meeting) =>
    meeting['date'].year == date.year &&
        meeting['date'].month == date.month &&
        meeting['date'].day == date.day
    ).length;
  }

  void updateSearch(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void setFilter(String filter) {
    selectedFilter = filter;
    notifyListeners();
  }

  @override
  void dispose() {
    reminderTimer?.cancel();
    super.dispose();
  }
}