import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/Riverpod/navebar.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';
import 'package:plasess/screens/home/drawer.dart';
import 'package:plasess/screens/profile/profile.dart';
import 'package:plasess/theme/app_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String role = "User";
  // Get user role from Firestore
  Future<void> getRole() async {
    final user = FirebaseAuth.instance.currentUser!;
    final doc = await FirebaseFirestore.instance
        .collection('Core Collections')
        .doc('lWGLG8VymCuLNpfF3ovm')
        .collection('User')
        .doc(user.uid)
        .get();
    setState(() {
      role = doc.data()!['Role'];
    });
    log("User Role: $role");
  }

  // Get categories from API
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    getCategories();
    getRole();
  }

  // Dispose the animation
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
    // log('roooooooooooll :' + role);
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
      body: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(navbarPorvider);
          switch (index) {
            case 1:
              return Profile();
            case 0:
              return ListView(
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
                              activeDotColor: Theme.of(
                                context,
                              ).colorScheme.onPrimary,
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
                      return Stack(
                        children: [
                          InkWell(
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
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (role == "Admin")
                            // Edit button for admin
                            Positioned(
                              top: 5,
                              right: 5,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Delete Category'),

                                        content: const Text(
                                          'Are you sure you want to delete this category?',
                                        ),

                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              categoryApi.deleteCategory(
                                                cateogryList[index].categoryId,
                                              );
                                              setState(() {});
                                            },

                                            child: const Text('Close'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          // Edit button for admin
                          Positioned(
                            top: 5,
                            left: 5,
                            child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.red),
                              onPressed: () {
                                final controller = TextEditingController(
                                  text: cateogryList[index].name,
                                );

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Edit Category'),

                                      content: TextField(
                                        controller: controller,

                                        decoration: const InputDecoration(
                                          hintText: 'Enter new name',
                                        ),
                                      ),

                                      actions: [
                                        // SAVE
                                        TextButton(
                                          onPressed: () async {
                                            await categoryApi.updateCategory(
                                              cateogryList[index].categoryId,
                                              controller.text,
                                            );

                                            Navigator.pop(context);

                                            getCategories();
                                          },

                                          child: const Text('Save'),
                                        ),

                                        // CANCEL
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },

                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              );
            default:
              return Home();
          }
        },
      ),

      //navebar cured
      bottomNavigationBar: Consumer(
        builder: (context, ref, child) {
          final index = ref.watch(navbarPorvider);
          return CurvedNavigationBar(
            index: index,
            items: [
              Icon(AppIcons.home, color: Theme.of(context).colorScheme.onError),
              Icon(
                AppIcons.profile,
                color: Theme.of(context).colorScheme.onError,
              ),
            ],
            backgroundColor: Theme.of(context).colorScheme.onPrimary,
            color: Theme.of(context).colorScheme.primary,
            onTap: (value) => ref.read(navbarPorvider.notifier).state = value,
          );
        },
      ),
    );
  }
}
