import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/localization/localization.dart';

import '../core/di/app_di.dart';

class NotyApp extends StatefulWidget {
  const NotyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<NotyApp> createState() => _NotyAppState();
}

class _NotyAppState extends State<NotyApp> {
  late final AppRouterDelegate appRouter;
  late final RouteInformationParser<RouteConfiguration> routeInformationParser;

  @override
  void initState() {
    appRouter = appLocator.get<AppRouterDelegate>();
    routeInformationParser = appLocator.get<AppRouteInformationParser>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback:
          (Locale? deviceLocale, Iterable<Locale> supportedLocales) {
        return AppLocalizations.resolveLocale(deviceLocale!, supportedLocales);
      },
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter,
      routeInformationParser: routeInformationParser,
    );
  }
}
