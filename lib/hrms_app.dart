import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms_app/routes/app_routes.dart';

import 'config/provider_config.dart';
import 'package:provider/provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_theme.dart';
import 'features/screens/app_setting/app_setting_provider.dart';

class HrmsApp extends StatelessWidget {
  const HrmsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderConfig.providers,
      child: Consumer<ThemeManager>(
        builder: (context, themeManager, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'HRMS App',
            routerConfig: AppRoutes.router,

            themeMode: themeManager.themeMode,

            // Language
            locale: Locale(
              context.watch<AppSettingsProvider>().language,
            ),

            supportedLocales: const [
              Locale('en'),
              Locale('hi'),
              Locale('gu'),
            ],

            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            // Smooth transition
            themeAnimationDuration: const Duration(milliseconds: 800),
            themeAnimationCurve: Curves.easeInOut,

            theme: ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: AppColors.lightBackground,
              textTheme: GoogleFonts.ubuntuTextTheme(),
            ),

            darkTheme: ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: AppColors.darkBackground,
              textTheme: GoogleFonts.ubuntuTextTheme(
                ThemeData.dark().textTheme,
              ),
            ),
          );
        },
      ),
    );
  }
}