
import 'package:base_module/providers/base_providers.dart';

import 'package:flutter/material.dart';

class TaskProvider extends BaseProvider {
  int selectedTab = 0;
  String searchQuery = "";

  final List<String> tabs = [
    "All",
    "Pending",
    "In Progress",
    "Completed",
  ];

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  void updateSearch(String query) {
    searchQuery = query;
    notifyListeners();
  }

  final List<Map<String, dynamic>> tasks = [
    {
      "id": "1",
      "title": "Create Employee Report",
      "priority": "High",
      "status": "Pending",
      "assignedBy": "HR Manager",
      "assignedTo": "John Doe",
      "dueDate": "20 Jul 2025",
      "comments": 5,
      "attachments": 2,
      "description": "Prepare monthly employee performance report",
    },
    {
      "id": "2",
      "title": "Update Attendance Module",
      "priority": "Medium",
      "status": "In Progress",
      "assignedBy": "Admin",
      "assignedTo": "Sarah Chen",
      "dueDate": "22 Jul 2025",
      "comments": 2,
      "attachments": 1,
      "description": "Fix bugs and add new features",
    },
    {
      "id": "3",
      "title": "Design UI Components",
      "priority": "Low",
      "status": "Completed",
      "assignedBy": "Design Lead",
      "assignedTo": "Mike Johnson",
      "dueDate": "15 Jul 2025",
      "comments": 8,
      "attachments": 5,
      "description": "Create reusable UI components",
    },
    {
      "id": "4",
      "title": "Team Meeting Notes",
      "priority": "Medium",
      "status": "Pending",
      "assignedBy": "Team Lead",
      "assignedTo": "John Doe",
      "dueDate": "18 Jul 2025",
      "comments": 1,
      "attachments": 0,
      "description": "Document weekly team meeting",
    },
    {
      "id": "5",
      "title": "API Integration",
      "priority": "High",
      "status": "In Progress",
      "assignedBy": "CTO",
      "assignedTo": "Alex Kumar",
      "dueDate": "25 Jul 2025",
      "comments": 12,
      "attachments": 3,
      "description": "Integrate third-party APIs",
    },
  ];

  List<Map<String, dynamic>> get filteredTasks {
    List<Map<String, dynamic>> filtered = tasks;

    // Filter by status
    if (selectedTab != 0) {
      filtered = filtered.where((task) => task["status"] == tabs[selectedTab]).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((task) =>
      task["title"].toLowerCase().contains(searchQuery.toLowerCase()) ||
          task["assignedBy"].toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  int get pendingCount => tasks.where((task) => task["status"] == "Pending").length;
  int get inProgressCount => tasks.where((task) => task["status"] == "In Progress").length;
  int get completedCount => tasks.where((task) => task["status"] == "Completed").length;
}