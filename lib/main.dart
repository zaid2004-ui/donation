import 'package:flutter/material.dart';
import 'package:plasess/Riverpod/localizations.dart';
import 'package:plasess/Riverpod/theme_provider.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/screens/onboarding/splash_screen.dart';
import 'package:plasess/theme/app_theme.dart';
import 'i18n/generated/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() => runApp(ProviderScope(child: const MyApp()));

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final locales = ref.watch(localeProvider);
    final resultTheme = ref.watch(stateTheme);

    return ValueListenableBuilder<Locale>(
      valueListenable: locales.localNotefier,
      builder: (BuildContext context, Locale value, Widget? child) {
        return MaterialApp(
          navigatorKey: AppRouter.navigatorKey,
          onGenerateRoute: AppRouter.generateRoute,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: value,
          darkTheme: AppTheme.darkTheme,
          theme: AppTheme.lightTheme,
          themeMode: resultTheme.isDark ? ThemeMode.dark : ThemeMode.light,

          home: SplashScreen(),
        );
      },
    );
  }
}
