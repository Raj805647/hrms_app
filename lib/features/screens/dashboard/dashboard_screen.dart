import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/help_widget.dart';
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
    return Consumer<DashboardProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          backgroundColor: context.bgColor,

          drawer: const DashboardDrawer(),

          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const DashboardHeader(),

                  spaceHeight(20),

                  const EmployeeCard(),

                  spaceHeight(20),

                  AttendanceCard(currentTime: provider.currentTime),

                  spaceHeight(20),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: "Attendance",
                          value: "98%",
                          icon: Icons.fingerprint,
                        ),
                      ),

                      spaceWidth(12),

                      Expanded(
                        child: StatCard(
                          title: "Leave",
                          value: "12",
                          icon: Icons.event,
                        ),
                      ),
                    ],
                  ),

                  spaceHeight(12),

                  Row(
                    children: [
                      Expanded(
                        child: StatCard(
                          title: "Hours",
                          value: "8.5",
                          icon: Icons.access_time,
                        ),
                      ),

                      spaceWidth(12),

                      Expanded(
                        child: StatCard(
                          title: "Tasks",
                          value: "5",
                          icon: Icons.task,
                        ),
                      ),
                    ],
                  ),

                  spaceHeight(25),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Quick Actions",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),

                  spaceHeight(15),

                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.quickActions.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemBuilder: (_, index) {
                      final item = provider.quickActions[index];

                      return QuickActionCard(
                        title: item["title"],
                        icon: item["icon"],
                      );
                    },
                  ),

                  spaceHeight(25),

                  const MeetingCard(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu_rounded),
            );
          },
        ),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Good Morning 👋",
                style: TextStyle(color: Colors.grey.shade600),
              ),

              const Text(
                "John Doe",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),

        const CircleAvatar(radius: 24, child: Text("JD")),
      ],
    );
  }
}

class EmployeeCard extends StatelessWidget {
  const EmployeeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.secondary],
        ),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Employee ID", style: TextStyle(color: Colors.white70)),

          SizedBox(height: 8),

          Text(
            "EMP-1025",
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class AttendanceCard extends StatelessWidget {
  final DateTime currentTime;

  const AttendanceCard({super.key, required this.currentTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Text(
            DateFormat('hh:mm:ss a').format(currentTime),
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),

          spaceHeight(20),

          Row(
            children: [
              Expanded(
                child: AppButton(
                  title: "Punch In",
                  icon: Icons.login_rounded,
                  onPressed: () {},
                ),
              ),

              spaceWidth(12),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.logout_rounded),
                  label: const Text("Punch Out"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Icon(icon),

          spaceHeight(10),

          Text(
            value,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Text(title),
        ],
      ),
    );
  }
}

class QuickActionCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const QuickActionCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.primary),

          spaceHeight(8),

          Text(title),
        ],
      ),
    );
  }
}

class MeetingCard extends StatelessWidget {
  const MeetingCard({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius:
        BorderRadius.circular(20),
      ),
      child: const ListTile(
        leading: Icon(
          Icons.video_call_rounded,
        ),
        title: Text(
          "Weekly HR Meeting",
        ),
        subtitle: Text(
          "Today • 03:00 PM",
        ),
      ),
    );
  }
}

class DashboardDrawer extends StatelessWidget {
  const DashboardDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text("John Doe"),
            accountEmail: const Text("john@company.com"),
            currentAccountPicture: const CircleAvatar(child: Text("JD")),
          ),

          _item(Icons.person, "Profile"),

          _item(Icons.event_available, "Leave Requests"),

          _item(Icons.task_alt, "Tasks"),

          _item(Icons.notifications, "Notifications"),

          _item(Icons.settings, "Settings"),

          const Spacer(),

          _item(Icons.logout, "Logout"),
        ],
      ),
    );
  }

  Widget _item(IconData icon, String title) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: () {});
  }
}
