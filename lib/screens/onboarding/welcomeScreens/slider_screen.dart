import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/onboarding/welcomeScreens/welcome_1.dart';

class Sliderscreen extends StatefulWidget {
  const Sliderscreen({super.key});

  @override
  State<Sliderscreen> createState() => _SliderscreenState();
}

class _SliderscreenState extends State<Sliderscreen> {
  int count = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CarouselSlider(
        carouselController: _controller,
        options: CarouselOptions(
          onPageChanged: (index, reason) => setState(() {
            count = index;
          }),
          height: 800,
          initialPage: 0,
          autoPlay: false,
          enableInfiniteScroll: false,
          enlargeCenterPage: true,
          viewportFraction: 1.0,
          autoPlayInterval: Duration(seconds: 1),
        ),
        items: [
          Welcome1(
            img: 'assets/images/welcom1.png',
            title: AppLocalizations.of(context)!.welcome,
            subtitle: AppLocalizations.of(context)!.supWelcom,
            index: count,
            controller: _controller,
          ),
          Welcome1(
            img: 'assets/images/welcom2.png',
            title: AppLocalizations.of(context)!.joinUs,
            subtitle: AppLocalizations.of(context)!.subJoin,
            index: count,
            controller: _controller,
          ),
        ],
      ),
    );
  }
}
