
import 'package:base_module/providers/base_providers.dart';

class TaskProvider extends BaseProvider {

  int selectedTab = 0;

  final List<String> tabs = [
    "All",
    "Pending",
    "Progress",
    "Completed",
  ];

  void changeTab(int index) {
    selectedTab = index;
    notifyListeners();
  }

  final List<Map<String, dynamic>> tasks = [
    {
      "title": "Create Employee Report",
      "priority": "High",
      "status": "Pending",
      "assignedBy": "HR Manager",
      "dueDate": "20 Jul 2025",
      "comments": 5,
      "attachments": 2,
    },
    {
      "title": "Update Attendance Module",
      "priority": "Medium",
      "status": "Progress",
      "assignedBy": "Admin",
      "dueDate": "22 Jul 2025",
      "comments": 2,
      "attachments": 1,
    },
  ];
}