import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import 'dashboard_provider.dart';
import 'package:intl/intl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<DashboardProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<DashboardProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          backgroundColor: themeManager.background,
          drawer: _buildDrawer(context, themeManager),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildDashboardHeader(context, themeManager),
                  const SizedBox(height: 20),
                  _buildEmployeeCard(themeManager),
                  const SizedBox(height: 20),
                  _buildStatisticsRow(provider, themeManager),
                  const SizedBox(height: 25),
                  _buildTodayTasksSection(context, provider, themeManager),
                  const SizedBox(height: 25),
                  _buildUpcomingHolidaysSection(provider, themeManager),
                  const SizedBox(height: 25),
                  _buildAnnouncementsSection(provider, themeManager),
                  const SizedBox(height: 25),
                  _buildPendingLeaveRequestsSection(provider, themeManager),
                  const SizedBox(height: 25),
                  _buildQuickActionsSection(provider, themeManager),
                  const SizedBox(height: 25),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Dashboard Header
  Widget _buildDashboardHeader(
    BuildContext context,
    ThemeManager themeManager,
  ) {
    final hour = DateTime.now().hour;
    String greeting = "Good Morning";

    if (hour >= 12 && hour < 17) {
      greeting = "Good Afternoon";
    } else if (hour >= 17) {
      greeting = "Good Evening";
    }

    return Row(
      children: [
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu_rounded, color: themeManager.text),
            );
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$greeting 👋",
                style: TextStyle(
                  color: themeManager.textSecondary,
                  fontSize: 14,
                ),
              ),
              Text(
                "John Doe",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: themeManager.text,
                ),
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: themeManager.primary,
          child: const Text("JD", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }

  // Employee Card
  Widget _buildEmployeeCard(ThemeManager themeManager) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [themeManager.primary, themeManager.secondary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Employee ID", style: TextStyle(color: Colors.white70)),
          const SizedBox(height: 8),
          const Text(
            "EMP-1025",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(
                Icons.business_center,
                color: Colors.white70,
                size: 16,
              ),
              const SizedBox(width: 4),
              const Text(
                "Senior Developer",
                style: TextStyle(color: Colors.white70),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  "Full Time",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Statistics Row
  Widget _buildStatisticsRow(
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                "Attendance",
                "${provider.attendancePercentage.toStringAsFixed(1)}%",
                Icons.fingerprint,
                Colors.blue,
                themeManager,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                "Leaves Left",
                "${provider.totalLeaves - provider.leavesTaken}",
                Icons.event_busy,
                Colors.orange,
                themeManager,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                "Tasks Done",
                "${provider.completedTasks}/${provider.totalTasks}",
                Icons.task_alt,
                Colors.green,
                themeManager,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                "Pending Leaves",
                "${provider.pendingLeavesCount}",
                Icons.pending_actions,
                Colors.red,
                themeManager,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Stat Card
  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  // Today's Tasks Section
  Widget _buildTodayTasksSection(
    BuildContext context,
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.task_alt, color: themeManager.primary),
                const SizedBox(width: 8),
                Text(
                  "Today's Tasks",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeManager.text,
                  ),
                ),
                const Spacer(),
                Text(
                  "${provider.todayTasks.where((t) => t['isCompleted'] == true).length}/${provider.todayTasks.length} Completed",
                  style: TextStyle(
                    color: themeManager.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ...List.generate(provider.todayTasks.length, (index) {
            final task = provider.todayTasks[index];
            return CheckboxListTile(
              value: task['isCompleted'],
              onChanged: (_) => provider.toggleTaskCompletion(index),
              title: Text(
                task['title'],
                style: TextStyle(
                  decoration: task['isCompleted']
                      ? TextDecoration.lineThrough
                      : null,
                  color: task['isCompleted']
                      ? themeManager.textSecondary
                      : themeManager.text,
                ),
              ),
              secondary: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: task['priority'] == 'high'
                      ? Colors.red.withOpacity(0.1)
                      : task['priority'] == 'medium'
                      ? Colors.orange.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  task['priority'],
                  style: TextStyle(
                    color: task['priority'] == 'high'
                        ? Colors.red
                        : task['priority'] == 'medium'
                        ? Colors.orange
                        : Colors.green,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              controlAffinity: ListTileControlAffinity.leading,
            );
          }),
        ],
      ),
    );
  }

  // Upcoming Holidays Section
  Widget _buildUpcomingHolidaysSection(
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.card_giftcard, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  "Upcoming Holidays",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          ...List.generate(provider.upcomingHolidays.length, (index) {
            final holiday = provider.upcomingHolidays[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Colors.orange,
                  size: 20,
                ),
              ),
              title: Text(
                holiday['name'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text("${holiday['date']} • ${holiday['day']}"),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            );
          }),
        ],
      ),
    );
  }

  // Announcements Section
  Widget _buildAnnouncementsSection(
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.campaign, color: Colors.blue),
                SizedBox(width: 8),
                Text(
                  "Announcements",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          ...List.generate(provider.announcements.length, (index) {
            final announcement = provider.announcements[index];
            return ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: announcement['priority'] == 'high'
                      ? Colors.red.withOpacity(0.1)
                      : Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.notifications_active,
                  color: announcement['priority'] == 'high'
                      ? Colors.red
                      : Colors.blue,
                  size: 20,
                ),
              ),
              title: Text(
                announcement['title'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    announcement['description'],
                    style: const TextStyle(fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    announcement['date'],
                    style: const TextStyle(fontSize: 11),
                  ),
                ],
              ),
              isThreeLine: true,
            );
          }),
        ],
      ),
    );
  }

  // Pending Leave Requests Section
  Widget _buildPendingLeaveRequestsSection(
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    final pendingLeaves = provider.pendingLeaveRequests
        .where((leave) => leave['status'] == 'pending')
        .toList();

    if (pendingLeaves.isEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: themeManager.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: const Padding(
          padding: EdgeInsets.all(32),
          child: Center(
            child: Column(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 48),
                SizedBox(height: 12),
                Text("No pending leave requests"),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.pending_actions, color: Colors.orange),
                SizedBox(width: 8),
                Text(
                  "Pending Leave Requests",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const Divider(),
          ...List.generate(pendingLeaves.length, (index) {
            final leave = pendingLeaves[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange.withOpacity(0.1),
                child: Text(leave['employee'][0]),
              ),
              title: Text(
                leave['employee'],
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                "${leave['type']} • ${leave['days']} day(s) • ${leave['date']}",
              ),
              trailing: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "Pending",
                  style: TextStyle(color: Colors.orange, fontSize: 12),
                ),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.all(12),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text("View All Requests"),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Actions Section
  Widget _buildQuickActionsSection(
    DashboardProvider provider,
    ThemeManager themeManager,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: themeManager.text,
          ),
        ),
        const SizedBox(height: 15),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.quickActions.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.1,
          ),
          itemBuilder: (context, index) {
            final item = provider.quickActions[index];
            return _buildQuickActionCard(
              item["title"],
              item["icon"],
              themeManager,
            );
          },
        ),
      ],
    );
  }

  // Quick Action Card
  Widget _buildQuickActionCard(
    String title,
    IconData icon,
    ThemeManager themeManager,
  ) {
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: themeManager.surface,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: themeManager.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: themeManager.primary, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: themeManager.text,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Dashboard Drawer
  Widget _buildDrawer(BuildContext context, ThemeManager themeManager) {
    final provider = context.read<DashboardProvider>();
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [themeManager.primary, themeManager.secondary],
              ),
            ),
            accountName: const Text("John Doe"),
            accountEmail: const Text("john.doe@company.com"),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("JD", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
          _buildDrawerItem(Icons.person, "Profile", themeManager, () {}),
          _buildDrawerItem(
            Icons.event_available,
            "Leave Requests",
            themeManager,
            () {},
          ),
          _buildDrawerItem(Icons.task_alt, "Tasks", themeManager, () {}),
          _buildDrawerItem(
            Icons.notifications,
            "Notifications",
            themeManager,
            () {
              provider.navigateTo(context, RouteNames.notificationScreen);
              provider.back(context);
            },
          ),
          _buildDrawerItem(Icons.meeting_room, "Meeting", themeManager, () {
            provider.navigateTo(context, RouteNames.meetingScreen);
            provider.back(context);
          }),
          _buildDrawerItem(
            Icons.calendar_today,
            "Holidays",
            themeManager,
            () {},
          ),
          _buildDrawerItem(Icons.note_outlined, "Notice", themeManager, () {}),
          _buildDrawerItem(Icons.settings, "Settings", themeManager, () {
            provider.navigateTo(context, RouteNames.appSettingScreen);
            provider.back(context);
          }),
          const Spacer(),
          _buildDrawerItem(
            Icons.logout,
            "Logout",
            themeManager,
            () {},
            isLogout: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // Drawer Item
  Widget _buildDrawerItem(
    IconData icon,
    String title,
    ThemeManager themeManager,
    VoidCallback onTap, {
    bool isLogout = false,
  }) {
    return ListTile(
      leading: Icon(icon, color: isLogout ? Colors.red : themeManager.text),
      title: Text(
        title,
        style: TextStyle(color: isLogout ? Colors.red : themeManager.text),
      ),
      onTap: onTap,
      hoverColor: themeManager.primary.withOpacity(0.05),
    );
  }
}
