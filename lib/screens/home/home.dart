import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:plasess/Riverpod/navebar.dart';
import 'package:plasess/core/router/app_route.dart';
import 'package:plasess/core/router/route.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/screens/Donation_process/my_donation.dart';
import 'package:plasess/screens/campaign/campaign_reels.dart';
import 'package:plasess/screens/home/api_category/category_api.dart';
import 'package:plasess/screens/home/api_category/category_model.dart';
import 'package:plasess/screens/home/drawer.dart';
import 'package:plasess/screens/profile/profile.dart';
import 'package:plasess/core/theme/app_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  // Admin actions for category card
  Widget buildAdminActions(int index) {
    return Positioned(
      top: 5,
      right: 5,
      left: 5,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(
              AppIcons.delete,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () async {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.delete_category),
                    content: Text(
                      AppLocalizations.of(context)!.confirm_delete_category,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await categoryApi.deleteCategory(
                            cateogryList[index].categoryId,
                          );

                          if (!context.mounted) return;

                          Navigator.pop(context);
                          await getCategories();
                        },
                        child: Text(
                          AppLocalizations.of(context)!.delete_category,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Spacer(),
          IconButton(
            icon: Icon(
              AppIcons.edit,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            onPressed: () {
              final controller = TextEditingController(
                text: cateogryList[index].name,
              );

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(AppLocalizations.of(context)!.edit_category),
                    content: TextField(controller: controller),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await categoryApi.updateCategory(
                            cateogryList[index].categoryId,
                            controller.text,
                          );

                          if (!context.mounted) return;

                          Navigator.pop(context);
                          await getCategories();
                        },
                        child: Text(AppLocalizations.of(context)!.save),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(AppLocalizations.of(context)!.cancel),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

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

  // API and data for categories
  final categoryApi = CategoryApi();
  List<CateogryModel> cateogryList = [];
  bool isLoding = true;

  Future<void> getCategories() async {
    cateogryList = await categoryApi.getCategories();
    isLoding = false;
    setState(() {});
  }

  //slider controler
  final CarouselSliderController sliderController = CarouselSliderController();
  int controller = 0;
  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

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
            case 3:
              return CampaignReelsPage();
            case 2:
              return Profile();
            case 1:
              return MyDonations();
            case 0:
              return ListView(
                children: [
                  //slider
                  Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),

                      // color: Theme.of(context).colorScheme.surface,
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            // color: Theme.of(context).colorScheme.surface,
                          ),
                          child: Column(
                            children: [
                              CarouselSlider(
                                carouselController: sliderController,
                                items: [
                                  Image.asset(
                                    'assets/images/1.jpeg',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Image.asset(
                                    'assets/images/imgae4.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                  Image.asset(
                                    'assets/images/image3.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),

                                  Image.asset(
                                    'assets/images/imgae6.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: 200,
                                  viewportFraction: 1.0,
                                  autoPlay: true,
                                  enlargeCenterPage: false,
                                  autoPlayAnimationDuration: const Duration(
                                    seconds: 1,
                                  ),
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      controller = index;
                                    });
                                  },
                                ),
                              ),

                              const SizedBox(height: 10),

                              AnimatedSmoothIndicator(
                                count: 4,
                                axisDirection: Axis.horizontal,
                                effect: SlideEffect(
                                  spacing: 8.0,
                                  radius: 50.0,
                                  dotWidth: 10.0,
                                  dotHeight: 10.0,
                                  paintStyle: PaintingStyle.stroke,
                                  strokeWidth: 1.5,
                                  dotColor: Theme.of(
                                    context,
                                  ).colorScheme.primary,
                                  activeDotColor: Theme.of(
                                    context,
                                  ).colorScheme.onPrimary,
                                ),
                                activeIndex: controller,
                              ),

                              const SizedBox(height: 10),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //gridview builder
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 200,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.75,
                      ),
                      itemCount: cateogryList.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            InkWell(
                              // Navigate to institutions screen with categoryId
                              onTap: () {
                                final id = cateogryList[index].categoryId;
                                log('Tapped categoryId: $id'); // test
                                AppRouter.pushNamed(
                                  Routes.institutions,
                                  args: cateogryList[index].categoryId,
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface.withAlpha(64),
                                      blurRadius: 12,
                                      spreadRadius: 1,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Card(
                                  margin: const EdgeInsets.all(0),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.surfaceContainerHighest,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      //image
                                      SizedBox(
                                        height: 120,
                                        child: Image.network(
                                          cateogryList[index].image,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/welcom1.png',
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // TEXT
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          bottom: 1,
                                        ),
                                        child: Text(
                                          isAr
                                              ? (cateogryList[index].nameAr ??
                                                    cateogryList[index].name)
                                              : (cateogryList[index].nameEn ??
                                                    cateogryList[index].name),
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge!
                                              .copyWith(
                                                color: Theme.of(
                                                  context,
                                                ).colorScheme.onSurface,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (role == "Admin") buildAdminActions(index),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            default:
              return const SizedBox();
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
              Icon(
                AppIcons.home,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Icon(
                AppIcons.volunteer,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Icon(
                AppIcons.profile,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              Icon(
                AppIcons.reels,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ],
            backgroundColor: Theme.of(
              context,
            ).colorScheme.onSurface.withAlpha(1),
            color: Theme.of(context).colorScheme.primary,
            onTap: (value) => ref.read(navbarPorvider.notifier).state = value,
          );
        },
      ),
    );
  }
}
