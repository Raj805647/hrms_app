import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:hrms_app/features/screens/profile/profile_provider.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/help_widget.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late ProfileProvider _provider;
  int _selectedTab = 0;

  final List<String> _tabs = [
    "Personal",
    "Professional",
    "Bank",
  ];

  @override
  void initState() {
    super.initState();
    _provider = Provider.of<ProfileProvider>(context, listen: false);
    _provider.initializeControllers();
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            isLeading: true,
            context: context,
            title: 'Edit Profile',
            action: [
              TextButton(
                onPressed: (){},
                child: provider.isLoaded
                    ? SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: themeManager.primary,
                  ),
                )
                    : Text(
                  "Save",
                  style: TextStyle(
                    color: themeManager.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ]
          ),
          body: Column(
            children: [
              _buildTabs(themeManager),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildProfileImage(themeManager, provider),
                      const SizedBox(height: 20),
                      _buildFormContent(provider, themeManager),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // App Bar
  // Tabs
  Widget _buildTabs(ThemeManager themeManager) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedTab = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                    colors: [themeManager.primary, themeManager.secondary],
                  )
                      : null,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color: isSelected ? Colors.white : themeManager.textSecondary,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Profile Image
  Widget _buildProfileImage(ThemeManager themeManager, ProfileProvider provider) {
    return Center(
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: themeManager.primary, width: 3),
              boxShadow: [
                BoxShadow(
                  color: themeManager.primary.withOpacity(0.3),
                  blurRadius: 20,
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 60,
                color: Colors.grey,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [themeManager.primary, themeManager.secondary],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: themeManager.surface, width: 2),
              ),
              child: const Icon(
                Icons.camera_alt,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Form Content based on selected tab
  Widget _buildFormContent(ProfileProvider provider, ThemeManager themeManager) {
    switch (_selectedTab) {
      case 0:
        return _buildPersonalInfoForm(provider, themeManager);
      case 1:
        return _buildProfessionalInfoForm(provider, themeManager);
      case 2:
        return _buildBankInfoForm(provider, themeManager);
      default:
        return const SizedBox();
    }
  }

  // Personal Information Form
  Widget _buildPersonalInfoForm(ProfileProvider provider, ThemeManager themeManager) {
    return Column(
      children: [
        _buildTextField(
          controller: provider.controllers['name']!,
          label: "Full Name",
          icon: Icons.person_outline,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['email']!,
          label: "Email Address",
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['mobile']!,
          label: "Mobile Number",
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['alternateMobile']!,
          label: "Alternate Mobile",
          icon: Icons.phone_android_outlined,
          keyboardType: TextInputType.phone,
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['gender']!.text,
          label: "Gender",
          icon: Icons.person_outline,
          items: ["Male", "Female", "Other"],
          onChanged: (value) => provider.controllers['gender']!.text = value!,
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['maritalStatus']!.text,
          label: "Marital Status",
          icon: Icons.favorite_outline,
          items: ["Single", "Married", "Divorced", "Widowed"],
          onChanged: (value) => provider.controllers['maritalStatus']!.text = value!,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['dob']!,
          label: "Date of Birth",
          icon: Icons.cake_outlined,
          readOnly: true,
          onTap: () => _selectDate(context, provider, themeManager),
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['bloodGroup']!.text,
          label: "Blood Group",
          icon: Icons.water_drop_outlined,
          items: ["A+", "A-", "B+", "B-", "O+", "O-", "AB+", "AB-"],
          onChanged: (value) => provider.controllers['bloodGroup']!.text = value!,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['address']!,
          label: "Address",
          icon: Icons.location_on_outlined,
          maxLines: 3,
          themeManager: themeManager,
        ),
      ],
    );
  }

  // Professional Information Form
  Widget _buildProfessionalInfoForm(ProfileProvider provider, ThemeManager themeManager) {
    return Column(
      children: [
        _buildTextField(
          controller: provider.controllers['branch']!,
          label: "Branch",
          icon: Icons.business_outlined,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['department']!,
          label: "Department",
          icon: Icons.groups_outlined,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['designation']!,
          label: "Designation",
          icon: Icons.work_outline,
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['employeeType']!.text,
          label: "Employee Type",
          icon: Icons.badge_outlined,
          items: ["Permanent", "Contract", "Intern", "Temporary"],
          onChanged: (value) => provider.controllers['employeeType']!.text = value!,
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['workspace']!.text,
          label: "Workspace",
          icon: Icons.laptop_outlined,
          items: ["Work from Home", "Work from Office", "Hybrid"],
          onChanged: (value) => provider.controllers['workspace']!.text = value!,
          themeManager: themeManager,
        ),
      ],
    );
  }

  // Bank Information Form
  Widget _buildBankInfoForm(ProfileProvider provider, ThemeManager themeManager) {
    return Column(
      children: [
        _buildTextField(
          controller: provider.controllers['bankName']!,
          label: "Bank Name",
          icon: Icons.account_balance_outlined,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['accountHolder']!,
          label: "Account Holder Name",
          icon: Icons.person_outline,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['accountNumber']!,
          label: "Account Number",
          icon: Icons.credit_card_outlined,
          keyboardType: TextInputType.number,
          themeManager: themeManager,
        ),
        _buildDropdownField(
          value: provider.controllers['accountType']!.text,
          label: "Account Type",
          icon: Icons.wallet_outlined,
          items: ["Savings", "Current", "Salary"],
          onChanged: (value) => provider.controllers['accountType']!.text = value!,
          themeManager: themeManager,
        ),
        _buildTextField(
          controller: provider.controllers['ifsc']!,
          label: "IFSC Code",
          icon: Icons.code,
          keyboardType: TextInputType.text,
          themeManager: themeManager,
        ),
      ],
    );
  }

  // Text Field Widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    bool readOnly = false,
    VoidCallback? onTap,
    required ThemeManager themeManager,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        readOnly: readOnly,
        onTap: onTap,
        style: TextStyle(color: themeManager.text),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: themeManager.textSecondary),
          prefixIcon: Icon(icon, color: themeManager.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: themeManager.textSecondary.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: themeManager.textSecondary.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: themeManager.primary, width: 2),
          ),
          filled: true,
          fillColor: themeManager.surface,
        ),
      ),
    );
  }

  // Dropdown Field Widget
  Widget _buildDropdownField({
    required String value,
    required String label,
    required IconData icon,
    required List<String> items,
    required Function(String?) onChanged,
    required ThemeManager themeManager,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: DropdownButtonFormField<String>(
        value: value.isNotEmpty ? value : null,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: themeManager.textSecondary),
          prefixIcon: Icon(icon, color: themeManager.primary),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: themeManager.textSecondary.withOpacity(0.2),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: themeManager.textSecondary.withOpacity(0.2),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: themeManager.primary, width: 2),
          ),
          filled: true,
          fillColor: themeManager.surface,
        ),
        items: items.map((item) {
          return DropdownMenuItem(
            value: item,
            child: Text(item, style: TextStyle(color: themeManager.text)),
          );
        }).toList(),
        onChanged: onChanged,
        style: TextStyle(color: themeManager.text),
      ),
    );
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context, ProfileProvider provider, ThemeManager themeManager) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1960),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: themeManager.primary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final formattedDate = "${picked.day} ${_getMonthName(picked.month)} ${picked.year}";
      provider.controllers['dob']!.text = formattedDate;
    }
  }

  // Get Month Name
  String _getMonthName(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

}
