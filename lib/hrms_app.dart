import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrms_app/routes/app_routes.dart';

import 'config/provider_config.dart';
import 'package:provider/provider.dart';

class HrmsApp extends StatefulWidget {
  const HrmsApp({super.key});

  static _HrmsAppState of(BuildContext context) {
    return context.findAncestorStateOfType<_HrmsAppState>()!;
  }

  @override
  State<HrmsApp> createState() => _HrmsAppState();
}

class _HrmsAppState extends State<HrmsApp> {
  ThemeMode themeMode = ThemeMode.system;
  Locale locale = const Locale('en');

  void changeTheme(ThemeMode mode) {
    setState(() {
      themeMode = mode;
    });
  }

  void changeLanguage(String languageCode) {
    setState(() {
      locale = Locale(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderConfig.providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'HRMS App',
        routerConfig: AppRoutes.router,

        themeMode: themeMode,

        theme: ThemeData(
          brightness: Brightness.light,
          textTheme: GoogleFonts.ubuntuTextTheme(),
        ),

        darkTheme: ThemeData(
          brightness: Brightness.dark,
          textTheme: GoogleFonts.ubuntuTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),

        locale: locale,

        supportedLocales: const [
          Locale('en'),
          Locale('hi'),
          Locale('gu'),
        ],
      ),
    );
  }
}