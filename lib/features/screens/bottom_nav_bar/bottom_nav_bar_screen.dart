import 'package:flutter/material.dart';
import 'package:hrms_app/features/screens/chat/chat_screen.dart';
import 'package:hrms_app/features/screens/dashboard/dashboard_screen.dart';
import 'package:hrms_app/features/screens/profile/profile_screen.dart';
import 'package:hrms_app/features/screens/task/task_screen.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../attendance/attendance_screen.dart';
import 'bottom_nav_bar_provider.dart';


class BottomNavBarScreen extends StatelessWidget {
  const BottomNavBarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Consumer<BottomNavBarProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          body: IndexedStack(
            index: provider.currentIndex,
            children: const [
              DashboardScreen(),
              AttendanceScreen(),
              TaskScreen(),
              ChatScreen(),
              ProfileScreen(),
            ],
          ),

          bottomNavigationBar: Container(
            margin: const EdgeInsets.all(16),
            height: 72,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: themeManager.surface,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(themeManager.isDarkMode ? 0.3 : 0.08),
                  blurRadius: 25,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                _buildNavItem(
                  context,
                  icon: Icons.home_rounded,
                  label: "Home",
                  index: 0,
                  selected: provider.currentIndex == 0,
                  onTap: () => provider.changeIndex(0),
                ),

                _buildNavItem(
                  context,
                  icon: Icons.fingerprint_rounded,
                  label: "Attendance",
                  index: 1,
                  selected: provider.currentIndex == 1,
                  onTap: () => provider.changeIndex(1),
                ),

                _buildNavItem(
                  context,
                  icon: Icons.task_alt_rounded,
                  label: "Tasks",
                  index: 2,
                  selected: provider.currentIndex == 2,
                  onTap: () => provider.changeIndex(2),
                ),

                _buildNavItem(
                  context,
                  icon: Icons.chat_rounded,
                  label: "Chat",
                  index: 3,
                  selected: provider.currentIndex == 3,
                  onTap: () => provider.changeIndex(3),
                ),

                _buildNavItem(
                  context,
                  icon: Icons.person_rounded,
                  label: "Profile",
                  index: 4,
                  selected: provider.currentIndex == 4,
                  onTap: () => provider.changeIndex(4),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
      BuildContext context, {
        required IconData icon,
        required String label,
        required int index,
        required bool selected,
        required VoidCallback onTap,
      }) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        splashColor: themeManager.primary.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: selected
                ? LinearGradient(
              colors: [
                themeManager.primary,
                themeManager.secondary,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )
                : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Icon
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 1.0, end: selected ? 1.1 : 1.0),
                duration: const Duration(milliseconds: 200),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: Icon(
                      icon,
                      color: selected
                          ? Colors.white
                          : themeManager.textSecondary.withOpacity(0.6),
                      size: selected ? 24 : 22,
                    ),
                  );
                },
              ),

              const SizedBox(height: 4),

              // Label with animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                  color: selected
                      ? Colors.white
                      : themeManager.textSecondary.withOpacity(0.6),
                ),
                child: Text(label),
              ),

              // Active indicator dot for selected item
              if (selected)
                Container(
                  margin: const EdgeInsets.only(top: 2),
                  height: 3,
                  width: 12,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}