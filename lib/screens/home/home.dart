import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';
import 'package:plasess/screens/home/drawer.dart';
import 'package:plasess/theme/app_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getCategories();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final categoryApi = CategoryApi();
  List<CateogryModel> cateogryList = [];
  bool isLoding = true;

  Future<void> getCategories() async {
    cateogryList = await categoryApi.getCategories();
    isLoding = false;
    setState(() {});
  }

  final CarouselSliderController sliderController = CarouselSliderController();
  int controller = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(AppIcons.menu),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          //slider
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
            ),
            child: Column(
              children: [
                CarouselSlider(
                  carouselController: sliderController,

                  items: [
                    Image.asset('assets/images/welcom1.png'),
                    Image.asset('assets/images/logo.png'),
                    Image.asset('assets/images/welcom2.png'),
                  ],
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        controller = index;
                      });
                    },
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 1),
                    enlargeCenterPage: true,
                  ),
                ),

                //anmatedSommthIndecator
                Center(
                  child: AnimatedSmoothIndicator(
                    count: 3,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                      spacing: 8.0,
                      radius: 50.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: Theme.of(context).colorScheme.primary,
                      activeDotColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    activeIndex: controller,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
          //gridview builder
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.0,
            ),
            itemCount: cateogryList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  final id = cateogryList[index].categoryId;
                  log('Tapped categoryId: $id'); // تيست
                  AppRouter.pushNamed(
                    Routes.institutions,
                    args: cateogryList[index].categoryId,
                  );
                },
                child: Card(
                  margin: EdgeInsets.all(5),
                  color: Theme.of(context).colorScheme.surface,
                  child: Column(
                    children: [
                      // Image.network(''),
                      Image.asset('assets/images/logo.png'),
                      SizedBox(height: 10),
                      Text(
                        cateogryList[index].name,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
      //navebar cured
      bottomNavigationBar: CurvedNavigationBar(
        items: [
          Icon(AppIcons.home, color: Theme.of(context).colorScheme.onError),
          Icon(AppIcons.heart, color: Theme.of(context).colorScheme.onError),
          Icon(AppIcons.profile, color: Theme.of(context).colorScheme.onError),
        ],
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
