import 'package:flutter/material.dart';
import 'package:hrms_app/features/screens/chat/chat_screen.dart';
import 'package:hrms_app/features/screens/dashboard/dashboard_screen.dart';
import 'package:hrms_app/features/screens/task/task_screen.dart';
import 'package:provider/provider.dart';
import '../attendance/attendance_screen.dart';
import 'bottom_nav_bar_provider.dart';

class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavBarProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          body: IndexedStack(
            index: provider.currentIndex,
            children: const [
              DashboardScreen(),
              AttendanceScreen(),
              TaskScreen(),
              ChatScreen(),
              DashboardScreen(),
            /*  AttendanceScreen(),
              TaskScreen(),
              ChatScreen(),
              ProfileScreen(),*/
            ],
          ),

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Theme.of(context).colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.08),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                _item(
                  context,
                  icon: Icons.home_rounded,
                  label: "Home",
                  index: 0,
                  selected:
                  provider.currentIndex == 0,
                  onTap: () =>
                      provider.changeIndex(0),
                ),

                _item(
                  context,
                  icon: Icons.fingerprint_rounded,
                  label: "Attendance",
                  index: 1,
                  selected:
                  provider.currentIndex == 1,
                  onTap: () =>
                      provider.changeIndex(1),
                ),

                _item(
                  context,
                  icon: Icons.task_alt_rounded,
                  label: "Tasks",
                  index: 2,
                  selected:
                  provider.currentIndex == 2,
                  onTap: () =>
                      provider.changeIndex(2),
                ),

                _item(
                  context,
                  icon: Icons.chat_rounded,
                  label: "Chat",
                  index: 3,
                  selected:
                  provider.currentIndex == 3,
                  onTap: () =>
                      provider.changeIndex(3),
                ),

                _item(
                  context,
                  icon: Icons.person_rounded,
                  label: "Profile",
                  index: 4,
                  selected:
                  provider.currentIndex == 4,
                  onTap: () =>
                      provider.changeIndex(4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _item(
      BuildContext context, {
        required IconData icon,
        required String label,
        required int index,
        required bool selected,
        required VoidCallback onTap,
      }) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: AnimatedContainer(
          duration: const Duration(
            milliseconds: 300,
          ),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(18),
            gradient: selected
                ? LinearGradient(
              colors: [
                colorScheme.primary,
                colorScheme.secondary,
              ],
            )
                : null,
          ),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: selected
                    ? Colors.white
                    : colorScheme.onSurface
                    .withOpacity(.6),
              ),

              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: selected
                      ? Colors.white
                      : colorScheme.onSurface
                      .withOpacity(.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}