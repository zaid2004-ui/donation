import 'dart:async';

import 'package:flutter/material.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeanimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _fadeanimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    Timer(const Duration(seconds: 5), () {
      AppRouter.pushNamed(Routes.sliderscreen);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
      body: FadeTransition(
        opacity: _fadeanimation,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 200, height: 200),
              Text(
                AppLocalizations.of(context)!.donation,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
