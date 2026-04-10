import 'package:flutter/material.dart';
import 'package:plasess/firstpalge.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/home/home.dart';
import 'package:plasess/screens/institutions/institutions.dart';
import 'package:plasess/screens/login&regestr/login/login.dart';
import 'package:plasess/screens/login&regestr/regester/regester.dart';
import 'package:plasess/screens/login&regestr/reset_passowrd/reset.dart';
import 'package:plasess/screens/onboarding/welcomeScreens/slider_screen.dart';
import 'package:plasess/screens/onboarding/welcomeScreens/welcome_1.dart';
import 'package:plasess/screens/screens_drawer/fa_questions.dart';
import 'package:plasess/secondpage.dart';

class AppRouter {
  const AppRouter._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final object = settings.arguments;

    switch (settings.name) {
      case Routes.firstpalge:
        return MaterialPageRoute(builder: (_) => const Firstpalge());
      case Routes.secondpage:
        return MaterialPageRoute(builder: (_) => const Secondpage());
      case Routes.welcome1:
        return MaterialPageRoute(builder: (_) => const Welcome1());
      case Routes.sliderscreen:
        return MaterialPageRoute(builder: (_) => const Sliderscreen());
      case Routes.login:
        return MaterialPageRoute(builder: (_) => const Login());
      case Routes.regester:
        return MaterialPageRoute(builder: (_) => const Regester());
      case Routes.reset:
        return MaterialPageRoute(builder: (_) => const Reset());
      case Routes.home:
        return MaterialPageRoute(builder: (_) => const Home());
      case Routes.faQuestions:
        return MaterialPageRoute(builder: (_) => const FaQuestions());
      case Routes.institutions:
        final categoryId = settings.arguments as String;
        return MaterialPageRoute(builder: (_) => Institutions(categoryId));

      default:
        return _errorRoute();
    }
  }

  ///Use the empty page we can handle it later
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Unknown Route')),
        body: const Center(child: Text('Unknown Route')),
      ),
    );
  }

  static Future<dynamic> pushNamed(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamed(routeName, arguments: args);
  }

  static Future<dynamic> pushNamedAndRemoveUntil(
    String routeName,
    String untilRoute, {
    dynamic args,
  }) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      ModalRoute.withName(untilRoute),
      arguments: args,
    );
  }

  static void back() {
    navigatorKey.currentState!.pop();
  }

  static void backToRoot() {
    navigatorKey.currentState!.popUntil(
      (Route<dynamic> route) => route.isFirst,
    );
  }

  static Future<dynamic> startNewRoute(String routeName, {dynamic args}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (Route<dynamic> route) => false,
      arguments: args,
    );
  }
}
