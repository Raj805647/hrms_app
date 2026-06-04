import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/help_widget.dart';

import 'package:provider/provider.dart';
import 'profile_provider.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<ProfileProvider>(
      builder: (context, provider, _) {
        final data = provider.profile;

        return Scaffold(
          appBar: buildProfileAppBar(
          context: context,
          title: "My Profile",
          action: [
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: IconButton(
                onPressed: ()=> provider.navigateTo(context, RouteNames.profileEditScreen),
                icon: const Icon(Icons.edit_outlined, color: Colors.white),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.white.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            )
          ],
        ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHeader(context, data, themeManager, provider),
                const SizedBox(height: 20),
                _buildStatsSection(data, themeManager),
                const SizedBox(height: 20),
                _buildPersonalInfo(context, data, themeManager),
                const SizedBox(height: 20),
                _buildSkillsSection(data, themeManager),
                const SizedBox(height: 20),
                _buildOfficeInfo(context, data, themeManager),
                const SizedBox(height: 20),
                _buildBankInfo(context, data, themeManager),
                const SizedBox(height: 20),
                _buildActions(context, themeManager, provider),
              ],
            ),
          ),
        );
      },
    );
  }

  // Header Section
  Widget _buildHeader(BuildContext context, Map<String, dynamic> data, ThemeManager themeManager, ProfileProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: LinearGradient(
          colors: [themeManager.primary, themeManager.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: themeManager.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Profile Image with Edit Button
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 55,
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
                child: GestureDetector(
                  onTap: () => provider.updateProfilePicture(),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: themeManager.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name
          Text(
            data["name"],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),

          // Employee ID
          Text(
            "ID: ${data["employeeId"]}",
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),

          // Role Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              data["role"],
              style: TextStyle(
                color: themeManager.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Active Status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 6),
                const Text(
                  "Active",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Stats Section
  Widget _buildStatsSection(Map<String, dynamic> data, ThemeManager themeManager) {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            "Experience",
            data["totalExperience"],
            Icons.work_history,
            themeManager,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            "Projects",
            "24+",
            Icons.padding_outlined,
            themeManager,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildStatCard(
            "Certificates",
            "8",
            Icons.verified,
            themeManager,
          ),
        ),
      ],
    );
  }

  // Stat Card
  Widget _buildStatCard(String title, String value, IconData icon, ThemeManager themeManager) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: themeManager.primary, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: themeManager.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  // Section Builder
  Widget _buildSection(String title, List<Widget> children, ThemeManager themeManager) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: themeManager.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 4,
                height: 24,
                decoration: BoxDecoration(
                  color: themeManager.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeManager.text,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    );
  }

  // Personal Information
  Widget _buildPersonalInfo(BuildContext context, Map<String, dynamic> data, ThemeManager themeManager) {
    return _buildSection("Personal Information", [
      _buildInfoTile("Email", data["email"], Icons.email, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Mobile", data["mobile"], Icons.phone, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Alternate Mobile", data["alternateMobile"], Icons.phone_android, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Gender", data["gender"], Icons.person, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Marital Status", data["maritalStatus"], Icons.favorite, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Date of Birth", data["dob"], Icons.cake, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Blood Group", data["bloodGroup"], Icons.water_drop, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Address", data["address"], Icons.location_on, themeManager),
    ], themeManager);
  }

  // Skills Section
  Widget _buildSkillsSection(Map<String, dynamic> data, ThemeManager themeManager) {
    return _buildSection("Skills & Expertise", [
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: (data["skills"] as List).map((skill) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeManager.primary, themeManager.secondary],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              skill,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
          );
        }).toList(),
      ),
    ], themeManager);
  }

  // Office Information
  Widget _buildOfficeInfo(BuildContext context, Map<String, dynamic> data, ThemeManager themeManager) {
    return _buildSection("Office Information", [
      _buildInfoTile("Joining Date", data["joiningDate"], Icons.calendar_today, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Branch", data["branch"], Icons.business, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Department", data["department"], Icons.groups, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Designation", data["designation"], Icons.work, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Employee Type", data["employeeType"], Icons.badge, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Workspace", data["workspace"], Icons.laptop, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Reporting Manager", data["manager"], Icons.supervisor_account, themeManager),
    ], themeManager);
  }

  // Bank Information
  Widget _buildBankInfo(BuildContext context, Map<String, dynamic> data, ThemeManager themeManager) {
    return _buildSection("Bank Information", [
      _buildInfoTile("Bank Name", data["bankName"], Icons.account_balance, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Account Holder", data["accountHolder"], Icons.person_outline, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Account Number", data["accountNumber"], Icons.credit_card, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("Account Type", data["accountType"], Icons.wallet, themeManager),
      _buildDivider(themeManager),
      _buildInfoTile("IFSC Code", data["ifsc"], Icons.code, themeManager),
    ], themeManager);
  }

  // Info Tile
  Widget _buildInfoTile(String title, String value, IconData icon, ThemeManager themeManager) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: themeManager.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: themeManager.primary, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: themeManager.textSecondary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: themeManager.text,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Divider
  Widget _buildDivider(ThemeManager themeManager) {
    return Divider(
      height: 24,
      color: themeManager.textSecondary.withOpacity(0.1),
    );
  }

  // Actions Section
  Widget _buildActions(BuildContext context, ThemeManager themeManager, ProfileProvider provider) {
    return Column(
      children: [
        AppButton(
          title: "Update Profile",
          icon: Icons.edit,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppButton(
          title: "Change Password",
          icon: Icons.lock,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppButton(
          title: "Documents",
          icon: Icons.folder,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppButton(
          title: "Settings",
          icon: Icons.settings,
          onPressed: () {},
        ),
        const SizedBox(height: 12),
        AppButton(
          title: "Logout",
          icon: Icons.logout,
          onPressed: () => provider.logout(context),
          isOutlined: true,
        ),
      ],
    );
  }
}