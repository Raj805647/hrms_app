import 'package:hrms_app/core/theme/app_theme.dart';
import 'package:hrms_app/features/auth/forgot_password/forgot_password_screen.dart';
import 'package:hrms_app/features/screens/attendance/attendance_provider.dart';
import 'package:hrms_app/features/screens/dashboard/dashboard_provider.dart';
import 'package:hrms_app/features/screens/metting/metting_provider.dart';
import 'package:hrms_app/features/screens/task/task_provider.dart';

import '../features/auth/forgot_password/forgot_password_provider.dart';
import '../features/auth/onboarding/onboarding_provider.dart';
import '../features/auth/sign_in/sign_in_provider.dart';
import '../features/auth/splash/splash_provider.dart';
import 'package:provider/provider.dart';

import '../features/screens/app_setting/app_setting_provider.dart';
import '../features/screens/bottom_nav_bar/bottom_nav_bar_provider.dart';
import '../features/screens/chat/chat_provider.dart';
import '../features/screens/notification/notification_provider.dart';
import '../features/screens/profile/profile_provider.dart';

class ProviderConfig {
  static List<ChangeNotifierProvider> providers = [
    // auth provider
    ChangeNotifierProvider<ThemeManager>(create: (_) => ThemeManager()),
    ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
    ChangeNotifierProvider<OnboardingProvider>(create: (_) => OnboardingProvider()),
    ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
    ChangeNotifierProvider<ForgotPasswordProvider>(create: (_) => ForgotPasswordProvider()),

    //screen
    ChangeNotifierProvider<BottomNavBarProvider>(create: (_) => BottomNavBarProvider()),
    ChangeNotifierProvider<DashboardProvider>(create: (_) => DashboardProvider()),
    ChangeNotifierProvider<ProfileProvider>(create: (_) => ProfileProvider()),
    ChangeNotifierProvider<AttendanceProvider>(create: (_) => AttendanceProvider()),
    ChangeNotifierProvider<TaskProvider>(create: (_) => TaskProvider()),
    ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
    ChangeNotifierProvider<MeetingProvider>(create: (_) => MeetingProvider()),
    ChangeNotifierProvider<AppSettingsProvider>(create: (_) => AppSettingsProvider()),
    ChangeNotifierProvider<NotificationProvider>(create: (_) => NotificationProvider()),
  ];
}
