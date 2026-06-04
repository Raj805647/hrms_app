import 'package:flutter/material.dart';
import 'package:hrms_app/widget/help_widget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import 'attendance_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<AttendanceProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            context: context,
            title: "Attendance",
            action: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.calendar_month, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildAttendanceCard(context, provider, themeManager),
                  spaceHeight(10),
                  const SizedBox(height: 20),
                  _buildLocationCard(context, provider, themeManager),
                  const SizedBox(height: 20),
                  _buildSummaryCard(context, provider, themeManager),
                  const SizedBox(height: 20),
                  _buildQuickActionsSection(context, provider, themeManager),
                  const SizedBox(height: 20),
                  _buildHistorySection(context, provider, themeManager),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // App Bar
  // Main Attendance Card
  Widget _buildAttendanceCard(
    BuildContext context,
    AttendanceProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [themeManager.primary, themeManager.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
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
          // Status Icon
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              provider.isCheckedIn ? Icons.check_circle : Icons.access_time,
              size: 50,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),

          // Current Time
          Text(
            DateFormat("hh:mm:ss a").format(provider.currentTime),
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            DateFormat("EEEE, MMMM d, yyyy").format(provider.currentTime),
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),

          // Status Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: provider.isCheckedIn ? Colors.green : Colors.grey.shade800,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Text(
              provider.isCheckedIn ? "● CHECKED IN" : "● CHECKED OUT",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Punch Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: provider.isCheckedIn
                      ? null
                      : () => provider.punchIn(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: themeManager.primary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login_rounded, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Punch In",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: provider.isCheckedIn
                      ? () => provider.punchOut(context)
                      : null,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.1),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    side: BorderSide(color: Colors.white.withOpacity(0.5)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.logout_rounded, size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        "Punch Out",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Location & Working Hours Card
  Widget _buildLocationCard(
    BuildContext context,
    AttendanceProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: themeManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.location_on, color: themeManager.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Current Location",
                      style: TextStyle(
                        color: themeManager.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      provider.location,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeManager.text,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => provider.getLocation(),
                icon: Icon(
                  Icons.refresh,
                  color: themeManager.primary,
                  size: 20,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.timer, color: Colors.green),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Working Hours",
                      style: TextStyle(
                        color: themeManager.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      provider.isCheckedIn ? provider.workingHours : "00:00:00",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeManager.text,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              if (provider.isCheckedIn)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "Active",
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ),
            ],
          ),
          const Divider(height: 32),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.orange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.warning_amber, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Late Arrival Today",
                      style: TextStyle(
                        color: themeManager.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      "${provider.lateMinutes} minutes",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(Icons.access_time, color: Colors.orange, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  // Summary Card
  Widget _buildSummaryCard(
    BuildContext context,
    AttendanceProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Row(
            children: [
              Icon(Icons.summarize, color: themeManager.primary),
              const SizedBox(width: 8),
              Text(
                "Monthly Summary",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeManager.text,
                ),
              ),
              const Spacer(),
              Text(
                "Dec 2024",
                style: TextStyle(color: themeManager.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem(
                "Present",
                "${provider.presentDays}",
                Colors.green,
                "${(provider.presentDays / provider.totalWorkingDays * 100).toStringAsFixed(0)}%",
                themeManager,
              ),
              _buildSummaryItem(
                "Absent",
                "${provider.absentDays}",
                Colors.red,
                "${(provider.absentDays / provider.totalWorkingDays * 100).toStringAsFixed(0)}%",
                themeManager,
              ),
              _buildSummaryItem(
                "Leave",
                "${provider.leaveDays}",
                Colors.blue,
                "${(provider.leaveDays / provider.totalWorkingDays * 100).toStringAsFixed(0)}%",
                themeManager,
              ),
            ],
          ),
          const SizedBox(height: 16),
          LinearProgressIndicator(
            value: provider.presentDays / provider.totalWorkingDays,
            backgroundColor: Colors.grey.shade200,
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          const SizedBox(height: 8),
          Text(
            "Attendance Rate: ${(provider.presentDays / provider.totalWorkingDays * 100).toStringAsFixed(1)}%",
            style: TextStyle(color: themeManager.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Summary Item Helper
  Widget _buildSummaryItem(
    String title,
    String value,
    Color color,
    String percentage,
    ThemeManager themeManager,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(color: themeManager.textSecondary, fontSize: 12),
        ),
        Text(
          percentage,
          style: TextStyle(
            color: color,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Quick Actions Section
  Widget _buildQuickActionsSection(
    BuildContext context,
    AttendanceProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
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
          Text(
            "Quick Actions",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  Icons.face,
                  "Face Verify",
                  () => provider.verifyFace(context),
                  themeManager,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  Icons.location_on,
                  "Update Location",
                  () => provider.getLocation(),
                  themeManager,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  Icons.calendar_today,
                  "Leave Request",
                  () {},
                  themeManager,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Quick Action Button
  Widget _buildQuickAction(
    IconData icon,
    String label,
    VoidCallback onTap,
    ThemeManager themeManager,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: themeManager.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(icon, color: themeManager.primary, size: 28),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: themeManager.text,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Attendance History Section
  Widget _buildHistorySection(
    BuildContext context,
    AttendanceProvider provider,
    ThemeManager themeManager,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Attendance History",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: themeManager.text,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "View All",
                style: TextStyle(color: themeManager.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: provider.attendanceHistory.length,
          itemBuilder: (context, index) {
            final record = provider.attendanceHistory[index];
            return _buildHistoryItem(record, themeManager);
          },
        ),
      ],
    );
  }

  // History Item
  Widget _buildHistoryItem(
    Map<String, dynamic> record,
    ThemeManager themeManager,
  ) {
    Color statusColor;
    IconData statusIcon;

    switch (record['status']) {
      case "present":
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case "late":
        statusColor = Colors.orange;
        statusIcon = Icons.warning_amber;
        break;
      case "absent":
        statusColor = Colors.red;
        statusIcon = Icons.cancel;
        break;
      case "leave":
        statusColor = Colors.blue;
        statusIcon = Icons.beach_access;
        break;
      default:
        statusColor = Colors.grey;
        statusIcon = Icons.help;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      color: themeManager.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(statusIcon, color: statusColor),
        ),
        title: Text(
          record['date'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: themeManager.text,
          ),
        ),
        subtitle: Text(
          "${record['checkIn']} - ${record['checkOut']}",
          style: TextStyle(color: themeManager.textSecondary, fontSize: 12),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              record['hours'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: themeManager.text,
                fontSize: 14,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                record['status'].toUpperCase(),
                style: TextStyle(
                  color: statusColor,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
