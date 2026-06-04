import 'package:base_module/base_module.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
class ProfileProvider extends BaseProvider {
  bool isEditing = false;
  bool isDarkMode = false;

  final Map<String, TextEditingController> controllers = {};

  // Initialize controllers with current profile data
  void initializeControllers() {
    controllers['name'] = TextEditingController(text: profile['name']);
    controllers['email'] = TextEditingController(text: profile['email']);
    controllers['mobile'] = TextEditingController(text: profile['mobile']);
    controllers['alternateMobile'] = TextEditingController(text: profile['alternateMobile']);
    controllers['gender'] = TextEditingController(text: profile['gender']);
    controllers['maritalStatus'] = TextEditingController(text: profile['maritalStatus']);
    controllers['dob'] = TextEditingController(text: profile['dob']);
    controllers['bloodGroup'] = TextEditingController(text: profile['bloodGroup']);
    controllers['address'] = TextEditingController(text: profile['address']);
    controllers['branch'] = TextEditingController(text: profile['branch']);
    controllers['department'] = TextEditingController(text: profile['department']);
    controllers['designation'] = TextEditingController(text: profile['designation']);
    controllers['employeeType'] = TextEditingController(text: profile['employeeType']);
    controllers['workspace'] = TextEditingController(text: profile['workspace']);
    controllers['bankName'] = TextEditingController(text: profile['bankName']);
    controllers['accountHolder'] = TextEditingController(text: profile['accountHolder']);
    controllers['accountNumber'] = TextEditingController(text: profile['accountNumber']);
    controllers['accountType'] = TextEditingController(text: profile['accountType']);
    controllers['ifsc'] = TextEditingController(text: profile['ifsc']);
  }

  final Map<String, dynamic> profile = {
    "image": "",
    "name": "John Doe",
    "employeeId": "EMP-1001",
    "email": "john.doe@company.com",
    "mobile": "+91 98765 43210",
    "alternateMobile": "+91 91234 56780",
    "gender": "Male",
    "maritalStatus": "Married",
    "dob": "10 Jan 1998",
    "bloodGroup": "O+",
    "address": "Ahmedabad, Gujarat, India",
    "role": "Senior Software Engineer",
    "isActive": true,
    "joiningDate": "15 Jun 2023",
    "branch": "Ahmedabad Branch",
    "department": "Information Technology",
    "designation": "Flutter Developer",
    "employeeType": "Permanent",
    "workspace": "Hybrid",
    "manager": "Rahul Sharma",
    "bankName": "HDFC Bank",
    "accountNumber": "XXXX XXXX 1234",
    "accountType": "Savings",
    "accountHolder": "John Doe",
    "ifsc": "HDFC0001234",
    "skills": ["Flutter", "Dart", "Firebase", "REST API"],
    "totalExperience": "4.5 years",
  };

  void toggleEdit() {
    isEditing = !isEditing;
    notifyListeners();
  }

  void updateProfile(Map<String, dynamic> updatedData) {
    profile.addAll(updatedData);
    notifyListeners();
  }

  Future<void> updateProfilePicture() async {
    // Implement image picker
    notifyListeners();
  }

  Future<void> logout(BuildContext context) async {
    // Implement logout logic
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Navigate to login screen
            },
            child: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}