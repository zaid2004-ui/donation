import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:plasess/i18n/generated/app_localizations.dart';
import 'package:plasess/router/app_route.dart';
import 'package:plasess/router/route.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome1 extends StatelessWidget {
  const Welcome1({
    super.key,
    this.img,
    this.title,
    this.subtitle,
    this.index,
    this.controller,
  });
  final String? img;
  final String? title;
  final String? subtitle;
  final int? index;
  final CarouselSliderController? controller;

  @override
  Widget build(BuildContext context) {
    int maxpage = 2;

    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              //carved design
              SizedBox(
                height: 600,
                width: double.infinity,
                child: CustomPaint(
                  painter: WavePainter(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              //image
              Positioned(
                top: 20,
                left: 50,
                right: 50,
                child: Image.asset(
                  img ?? 'assets/images/logo.png',
                  width: double.infinity,
                  height: 250,
                ),
              ),
              //text
              Positioned(
                top: 380,
                right: 10,
                left: 10,
                child: ListTile(
                  title: Text(
                    title ?? 'Erorre',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(),
                  ),
                  subtitle: Text(
                    subtitle ?? 'Erorre',
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(),
                  ),
                ),
              ),
            ],
          ),
          //container for button and animated indicator
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(30),
                    child: Row(
                      children: [
                        //butoon skip
                        ElevatedButton(
                          onPressed: () {
                            AppRouter.pushNamed(Routes.login);
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.skip,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),

                        Spacer(),
                        //butoon next
                        ElevatedButton(
                          onPressed: () {
                            if (index! < maxpage - 1) {
                              controller!.nextPage();
                              Duration(seconds: 1);
                            }
                            Curves.easeInCirc;
                            if (index == 1) {
                              AppRouter.pushNamed(Routes.login);
                            }
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(
                              context,
                            ).colorScheme.onPrimary,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.next,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //animated smooth indicator
                Positioned(
                  top: 30,
                  left: 170,
                  right: 170,
                  child: AnimatedSmoothIndicator(
                    count: 2,
                    axisDirection: Axis.horizontal,
                    effect: SlideEffect(
                      spacing: 8.0,
                      radius: 50.0,
                      dotWidth: 10.0,
                      dotHeight: 10.0,
                      paintStyle: PaintingStyle.stroke,
                      strokeWidth: 1.5,
                      dotColor: const Color.fromARGB(255, 0, 0, 0),
                      activeDotColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    activeIndex: index ?? 0,
                  ),
                ),

                //butoon next
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//carved design
class WavePainter extends CustomPainter {
  final Color color;

  WavePainter({this.color = Colors.white});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for fill
    Paint paintFill = Paint()
      ..color = color
      ..style = PaintingStyle.fill
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    // Path
    Path path = Path();
    path.moveTo(size.width * 0.9962500, size.height * 0.0026623);
    path.lineTo(size.width * 1.0025000, size.height * 0.3984547);
    path.quadraticBezierTo(
      size.width * 0.8343750,
      size.height * 0.3292400,
      size.width * 0.5783500,
      size.height * 0.4358800,
    );
    path.quadraticBezierTo(
      size.width * 0.3583375,
      size.height * 0.5383400,
      size.width * 0.0037500,
      size.height * 0.4028918,
    );
    path.lineTo(0, 0);
    path.lineTo(size.width * 0.9962500, size.height * 0.0026623);
    path.close();

    // Draw fill
    canvas.drawPath(path, paintFill);

    // Paint for stroke
    Paint paintStroke = Paint()
      ..color = const Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    // Draw stroke
    canvas.drawPath(path, paintStroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
