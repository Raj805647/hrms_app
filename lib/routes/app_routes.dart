import 'package:hrms_app/features/screens/chat/chat_details.dart';
import 'package:hrms_app/features/screens/chat/chat_screen.dart';
import 'package:hrms_app/features/screens/task/task_screen.dart';

import '../features/auth/forgot_password/forgot_password_screen.dart';
import '../features/auth/onboarding/onboarding_screen.dart';
import '../features/auth/sign_in/sign_in_screen.dart';
import '../features/auth/splash/splash_screen.dart';
import '../features/screens/app_setting/app_setting_screen.dart';
import '../features/screens/attendance/attendance_screen.dart';
import '../features/screens/bottom_nav_bar/bottom_nav_bar_screen.dart';
import '../features/screens/dashboard/dashboard_screen.dart';
import '../features/screens/meeting_room/meeting_room_screen.dart';
import '../features/screens/meeting_schedule/meeting_schedule_screen.dart';
import '../features/screens/metting/meeting_screen.dart';
import '../features/screens/notification/notification_screen.dart';
import '../features/screens/profile/profile_edit_screen.dart';
import '../features/screens/profile/profile_screen.dart';
import 'route_names.dart';

import 'package:go_router/go_router.dart';

class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splashScreen,
    routes: [
      //auth screens
      GoRoute(
        path: RouteNames.splashScreen,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onBoardingScreen,
        builder: (context, state) => OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.signInScreen,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RouteNames.forgotPasswordScreen,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),

      //screens
      GoRoute(
        path: RouteNames.bottomNavigationScreen,
        builder: (context, state) => const BottomNavBarScreen(),
      ),
      GoRoute(
        path: RouteNames.dashBoardScreen,
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: RouteNames.profileScreen,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: RouteNames.profileEditScreen,
        builder: (context, state) => const ProfileEditScreen(),
      ),
      GoRoute(
        path: RouteNames.attendanceScreen,
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: RouteNames.taskScreen,
        builder: (context, state) => const TaskScreen(),
      ),
      GoRoute(
        path: RouteNames.chatScreen,
        builder: (context, state) => const ChatScreen(),
      ),
      GoRoute(
        path: RouteNames.chatDetailsScreen,
        builder: (context, state) => const ChatDetailScreen(),
      ),
      GoRoute(
        path: RouteNames.notificationScreen,
        builder: (context, state) => const NotificationScreen(),
      ),
      GoRoute(
        path: RouteNames.meetingScreen,
        builder: (context, state) => const MeetingScreen(),
      ),
      GoRoute(
        path: RouteNames.meetingRoomScreen,
        builder: (context, state) => const MeetingRoomScreen(),
      ),
      GoRoute(
        path: RouteNames.meetingScheduleScreen,
        builder: (context, state) => const ScheduleMeetingScreen(),
      ),
      GoRoute(
        path: RouteNames.appSettingScreen,
        builder: (context, state) => const AppSettingScreen(),
      ),
    ],
  );
}
